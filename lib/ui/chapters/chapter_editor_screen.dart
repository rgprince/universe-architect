import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:drift/drift.dart' as drift;
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'dart:convert';
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../widgets/word_count_widget.dart';
import '../../services/ai_text_service.dart';

/// Chapter Editor Screen with AI Integration
class ChapterEditorScreen extends ConsumerStatefulWidget {
  final Book book;
  final Chapter chapter;
  
  const ChapterEditorScreen({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  ConsumerState<ChapterEditorScreen> createState() => _ChapterEditorScreenState();
}

class _ChapterEditorScreenState extends ConsumerState<ChapterEditorScreen> {
  late QuillController _controller;
  Timer? _autoSaveTimer;
  bool _isSaving = false;
  DateTime? _lastSaved;
  final _aiService = AiTextService();
  bool _showAiMenu = false;
  
  @override
  void initState() {
    super.initState();
    _initializeEditor();
    _setupAutoSave();
  }
  
  void _initializeEditor() {
    if (widget.chapter.contentDelta != null && widget.chapter.contentDelta!.isNotEmpty) {
      try {
        final deltaJson = jsonDecode(widget.chapter.contentDelta!);
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
    
    // Listen to selection changes for AI menu
    _controller.addListener(() {
      final selection = _controller.selection;
      setState(() {
        _showAiMenu = !selection.isCollapsed && selection.end - selection.start > 0;
      });
    });
  }
  
  void _setupAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_isSaving) {
        _saveChapter();
      }
    });
  }
  
  Future<void> _saveChapter() async {
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
      
      await (db.update(db.chapters)..where((c) => c.id.equals(widget.chapter.id)))
          .write(ChaptersCompanion(
            contentDelta: drift.Value(deltaJson),
            contentHtml: drift.Value(html),
            wordCount: drift.Value(wordCount),
            updatedAt: drift.Value(DateTime.now()),
          ));
      
      setState(() {
        _lastSaved = DateTime.now();
      });
    } catch (e) {
      debugPrint('Error saving chapter: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }
  
  String _getSelectedText() {
    final selection = _controller.selection;
    if (selection.isCollapsed) return '';
    
    return _controller.document
        .toPlainText()
        .substring(selection.start, selection.end);
  }
  
  Future<void> _applyAiTransformation(Future<String> Function(String) transformer) async {
    final selectedText = _getSelectedText();
    if (selectedText.isEmpty) return;
    
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('AI is processing...'),
                ],
              ),
            ),
          ),
        ),
      );
      
      final transformedText = await transformer(selectedText);
      
      if (mounted) {
        Navigator.pop(context); // Close loading dialog
        
        // Replace selected text
        final selection = _controller.selection;
        _controller.replaceText(
          selection.start,
          selection.end - selection.start,
          transformedText,
          TextSelection.collapsed(offset: selection.start + transformedText.length),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✨ AI transformation applied')),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  
  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _saveChapter();
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
            Text(widget.chapter.title ?? 'Chapter ${widget.chapter.chapterNumber}'),
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
                placeholder: 'Start writing your story...',
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showAiMenu
          ? FloatingActionButton.extended(
              onPressed: () => _showAiOptions(),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('AI Tools'),
              backgroundColor: Colors.purple,
            )
          : null,
    );
  }
  
  void _showAiOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'AI Text Tools',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.auto_fix_high),
              title: const Text('Improve Writing'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.improveText);
              },
            ),
            ListTile(
              leading: const Icon(Icons.spellcheck),
              title: const Text('Fix Grammar'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.fixGrammar);
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate),
              title: const Text('Translate to English'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.translateToEnglish);
              },
            ),
            ListTile(
              leading: const Icon(Icons.compress),
              title: const Text('Make Shorter'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.makeShorter);
              },
            ),
            ListTile(
              leading: const Icon(Icons.expand),
              title: const Text('Make Longer'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.makeLonger);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_stories),
              title: const Text('Continue Writing'),
              onTap: () {
                Navigator.pop(context);
                _applyAiTransformation(_aiService.continueWriting);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatTimeSince(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
