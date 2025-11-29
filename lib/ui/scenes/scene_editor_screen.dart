import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:drift/drift.dart' as drift;
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../widgets/word_count_widget.dart';

/// Scene Editor Screen - For Scene Mode
/// Similar to Chapter Editor but for individual scenes with metadata
class SceneEditorScreen extends ConsumerStatefulWidget {
  final Chapter chapter;
  final ScenesV3Data scene;
  final int universeId;
  
  const SceneEditorScreen({
    super.key,
    required this.chapter,
    required this.scene,
    required this.universeId,
  });

  @override
  ConsumerState<SceneEditorScreen> createState() => _SceneEditorScreenState();
}

class _SceneEditorScreenState extends ConsumerState<SceneEditorScreen> {
  late QuillController _controller;
  Timer? _autoSaveTimer;
  bool _isSaving = false;
  DateTime? _lastSaved;
  bool _showMetadata = false;
  
  @override
  void initState() {
    super.initState();
    _initializeEditor();
    _setupAutoSave();
  }
  
  void _initializeEditor() {
    if (widget.scene.contentDelta != null && widget.scene.contentDelta!.isNotEmpty) {
      try {
        final deltaJson = jsonDecode(widget.scene.contentDelta!);
        final doc = Document.fromJson(deltaJson);
        _controller = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        _controller = QuillController.basic();
      }
    } else {
      _controller = QuillController.basic();
    }
    
    _controller.addListener(_onContentChanged);
  }
  
  void _setupAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_isSaving) {
        _saveScene();
      }
    });
  }
  
  void _onContentChanged() {
    // Content changed, will be saved on next cycle
  }
  
  Future<void> _saveScene() async {
    setState(() {
      _isSaving = true;
    });
    
    try {
      final db = ref.read(databaseProvider);
      final delta = _controller.document.toDelta();
      final deltaJson = jsonEncode(delta.toJson());
      
      final converter = QuillDeltaToHtmlConverter(
        delta.toJson(),
        ConverterOptions.forEmail(),
      );
      final html = converter.convert();
      
      final plainText = _controller.document.toPlainText();
      final wordCount = plainText.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
      
      await (db.update(db.scenesV3)..where((s) => s.id.equals(widget.scene.id)))
          .write(ScenesV3Companion(
            contentDelta: drift.Value(deltaJson),
            contentHtml: drift.Value(html),
            wordCount: drift.Value(wordCount),
            updatedAt: drift.Value(DateTime.now()),
          ));
      
      // Also update chapter's total word count
      final allScenes = await db.getScenesForChapter(widget.chapter.id);
      final totalWords = allScenes.fold<int>(0, (sum, s) => sum + (s.wordCount ?? 0));
      await (db.update(db.chapters)..where((c) => c.id.equals(widget.chapter.id)))
          .write(ChaptersCompanion(wordCount: drift.Value(totalWords)));
      
      setState(() {
        _lastSaved = DateTime.now();
      });
    } catch (e) {
      debugPrint('Error saving scene: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }
  
  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _saveScene();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plainText = _controller.document.toPlainText();
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.scene.title ?? 'Scene ${widget.scene.sceneNumber}'),
            if (_lastSaved != null)
              Text(
                'Saved ${_formatTimeSince(_lastSaved!)}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordCountWidget(text: plainText),
          ),
          IconButton(
            icon: Icon(_showMetadata ? Icons.info : Icons.info_outline),
            tooltip: 'Toggle Metadata',
            onPressed: () {
              setState(() {
                _showMetadata = !_showMetadata;
              });
            },
          ),
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (_showMetadata) _buildMetadataPanel(),
          QuillSimpleToolbar(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _controller,
              sharedConfigurations: const QuillSharedConfigurations(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: _controller,
                placeholder: 'Write your scene...',
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMetadataPanel() {
    final db = ref.watch(databaseProvider);
    
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, size: 20),
              const SizedBox(width: 8),
              const Text('Scene Metadata', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // POV
              Expanded(
                child: widget.scene.povCharacterId != null
                    ? FutureBuilder<Entity?>(
                        future: (db.select(db.entities)
                              ..where((e) => e.id.equals(widget.scene.povCharacterId!)))
                            .getSingleOrNull(),
                        builder: (context, snapshot) {
                          return Text('POV: ${snapshot.data?.name ?? "None"}');
                        },
                      )
                    : const Text('POV: None'),
              ),
              // Location
              Expanded(
                child: widget.scene.locationId != null
                    ? FutureBuilder<Entity?>(
                        future: (db.select(db.entities)
                              ..where((e) => e.id.equals(widget.scene.locationId!)))
                            .getSingleOrNull(),
                        builder: (context, snapshot) {
                          return Text('Location: ${snapshot.data?.name ?? "None"}');
                        },
                      )
                    : const Text('Location: None'),
              ),
              // Status
              Expanded(
                child: Text('Status: ${_getStatusEmoji(widget.scene.status ?? "draft")} ${widget.scene.status?.replaceAll("_", " ").toUpperCase() ?? "DRAFT"}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _getStatusEmoji(String status) {
    switch (status) {
      case 'draft': return '📝';
      case 'needs_work': return '⚠️';
      case 'final': return '✅';
      default: return '📝';
    }
  }
  
  String _formatTimeSince(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
