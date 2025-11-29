import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../chapters/chapter_editor_screen.dart';
import '../scenes/create_scene_dialog.dart';
import '../scenes/scene_editor_screen.dart';
import '../../services/email_service.dart';

/// Chapters Tab with Status Filtering (Outline/Draft/Final)
class ChaptersTab extends ConsumerStatefulWidget {
  final Book book;
  
  const ChaptersTab({super.key, required this.book});

  @override
  ConsumerState<ChaptersTab> createState() => _ChaptersTabState();
}

class _ChaptersTabState extends ConsumerState<ChaptersTab> with SingleTickerProviderStateMixin {
  bool _isSceneMode = false;
  late TabController _statusTabController;
  String _currentStatus = 'draft'; // outline, draft, final
  
  @override
  void initState() {
    super.initState();
    _isSceneMode = widget.book.writingMode == 'scene';
    _statusTabController = TabController(length: 3, vsync: this, initialIndex: 1); // Default to Draft
    _statusTabController.addListener(() {
      setState(() {
        _currentStatus = ['outline', 'draft', 'final'][_statusTabController.index];
      });
    });
  }
  
  @override
  void dispose() {
    _statusTabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status Tabs
        Container(
          color: Colors.grey.shade100,
          child: TabBar(
            controller: _statusTabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(icon: Icon(Icons.lightbulb_outline), text: 'Outline'),
              Tab(icon: Icon(Icons.edit_note), text: 'Draft'),
              Tab(icon: Icon(Icons.check_circle_outline), text: 'Final'),
            ],
          ),
        ),
        // Chapter List
        Expanded(
          child: FutureBuilder<List<Chapter>>(
            future: _getChaptersByStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final chapters = snapshot.data ?? [];
              
              if (chapters.isEmpty) {
                return _buildEmptyState();
              }
              
              return _buildChaptersList(chapters);
            },
          ),
        ),
      ],
    );
  }

  Future<List<Chapter>> _getChaptersByStatus() async {
    final db = ref.read(databaseProvider);
    final allChapters = await db.getChaptersForBook(widget.book.id);
    return allChapters.where((c) => (c.status ?? 'draft') == _currentStatus).toList();
  }

  Widget _buildEmptyState() {
    String message = '';
    String buttonText = '';
    
    switch (_currentStatus) {
      case 'outline':
        message = 'No outline chapters yet';
        buttonText = 'Create Outline';
        break;
      case 'draft':
        message = 'No drafts yet';
        buttonText = 'Start Writing';
        break;
      case 'final':
        message = 'No final chapters yet';
        buttonText = 'Promote a Draft';
        break;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_books_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          if (_currentStatus != 'final')
            FilledButton.icon(
              onPressed: () => _createChapter(_currentStatus),
              icon: const Icon(Icons.add),
              label: Text(buttonText),
            ),
        ],
      ),
    );
  }

  Widget _buildChaptersList(List<Chapter> chapters) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: chapters.length + 1,
      itemBuilder: (context, index) {
        if (index == chapters.length) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton.icon(
              onPressed: () => _createChapter(_currentStatus),
              icon: const Icon(Icons.add),
              label: Text('New ${_currentStatus == 'outline' ? 'Outline' : _currentStatus == 'draft' ? 'Draft' : 'Chapter'}'),
            ),
          );
        }
        
        final chapter = chapters[index];
        return _isSceneMode 
            ? _buildSceneModeChapterCard(chapter)
            : _buildSimpleModeChapterCard(chapter);
      },
    );
  }

  Widget _buildSimpleModeChapterCard(Chapter chapter) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(chapter.status ?? 'draft'),
          child: Text('${chapter.chapterNumber}'),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chapter.title ?? 'Chapter ${chapter.chapterNumber}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _getStatusBadge(chapter.status ?? 'draft'),
          ],
        ),
        subtitle: Text('${chapter.wordCount} words'),
        trailing: _buildChapterActions(chapter),
        onTap: () => _editChapter(chapter),
      ),
    );
  }

  Widget _buildSceneModeChapterCard(Chapter chapter) {
    final db = ref.watch(databaseProvider);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(chapter.status ?? 'draft'),
          child: Text('${chapter.chapterNumber}'),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chapter.title ?? 'Chapter ${chapter.chapterNumber}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _getStatusBadge(chapter.status ?? 'draft'),
          ],
        ),
        subtitle: FutureBuilder<List<ScenesV3Data>>(
          future: db.getScenesForChapter(chapter.id),
          builder: (context, snapshot) {
            final scenes = snapshot.data ?? [];
            return Text('${scenes.length} scenes • ${chapter.wordCount} words');
          },
        ),
        trailing: _buildChapterActions(chapter),
        children: [
          FutureBuilder<List<ScenesV3Data>>(
            future: db.getScenesForChapter(chapter.id),
            builder: (context, snapshot) {
              final scenes = snapshot.data ?? [];
              
              if (scenes.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('No scenes yet'),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () => _createScene(chapter),
                        icon: const Icon(Icons.add),
                        label: const Text('Add First Scene'),
                      ),
                    ],
                  ),
                );
              }
              
              return Column(
                children: [
                  ...scenes.map((scene) => ListTile(
                    dense: true,
                    leading: Text('${scene.sceneNumber}.'),
                    title: Text(scene.title ?? 'Scene ${scene.sceneNumber}'),
                    subtitle: Text('${scene.wordCount} words • ${_getSceneStatusLabel(scene.status ?? "draft")}'),
                    trailing: const Icon(Icons.edit, size: 18),
                    onTap: () => _editScene(chapter, scene),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: OutlinedButton.icon(
                      onPressed: () => _createScene(chapter),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add Scene'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChapterActions(Chapter chapter) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email button
        IconButton(
          icon: const Icon(Icons.email_outlined, size: 20),
          tooltip: 'Email Chapter',
          onPressed: () => _emailChapter(chapter),
        ),
        // Promote button (only for outline/draft)
        if (chapter.status != 'final')
          IconButton(
            icon: Icon(
              chapter.status == 'outline' ? Icons.arrow_forward : Icons.check_circle,
              size: 20,
            ),
            tooltip: chapter.status == 'outline' ? 'Promote to Draft' : 'Promote to Final',
            onPressed: () => _promoteChapter(chapter),
          ),
      ],
    );
  }

  Widget _getStatusBadge(String status) {
    IconData icon;
    Color color;
    
    switch (status) {
      case 'outline':
        icon = Icons.lightbulb;
        color = Colors.amber;
        break;
      case 'draft':
        icon = Icons.edit_note;
        color = Colors.blue;
        break;
      case 'final':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      default:
        icon = Icons.edit;
        color = Colors.grey;
    }
    
    return Icon(icon, color: color, size: 20);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'outline':
        return Colors.amber.shade200;
      case 'draft':
        return Colors.blue.shade200;
      case 'final':
        return Colors.green.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  String _getSceneStatusLabel(String status) {
    switch (status) {
      case 'draft': return '📝 Draft';
      case 'needs_work': return '⚠️ Needs Work';
      case 'final': return '✅ Final';
      default: return '📝 Draft';
    }
  }

  Future<void> _createChapter(String status) async {
    final db = ref.read(databaseProvider);
    final existingChapters = await db.getChaptersForBook(widget.book.id);
    final nextNumber = existingChapters.length + 1;
    
    final newChapter = ChaptersCompanion.insert(
      bookId: widget.book.id,
      chapterNumber: nextNumber,
      title: drift.Value('Chapter $nextNumber'),
      status: drift.Value(status),
    );
    
    await db.into(db.chapters).insert(newChapter);
    setState(() {});
  }

  void _editChapter(Chapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChapterEditorScreen(
          book: widget.book,
          chapter: chapter,
        ),
      ),
    ).then((_) => setState(() {}));
  }
  
  Future<void> _createScene(Chapter chapter) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => CreateSceneDialog(
        chapter: chapter,
        universeId: widget.book.universeId,
      ),
    );
    
    if (result == true) {
      setState(() {});
    }
  }
  
  void _editScene(Chapter chapter, ScenesV3Data scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SceneEditorScreen(
          chapter: chapter,
          scene: scene,
          universeId: widget.book.universeId,
        ),
      ),
    ).then((_) => setState(() {}));
  }

  Future<void> _promoteChapter(Chapter chapter) async {
    final newStatus = chapter.status == 'outline' ? 'draft' : 'final';
    final db = ref.read(databaseProvider);
    
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Promote to ${newStatus == 'draft' ? 'Draft' : 'Final'}?'),
        content: Text(
          newStatus == 'final'
              ? 'This will mark the chapter as final and trigger auto-email if configured.'
              : 'This will mark the chapter as draft, ready for writing.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Promote'),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    // Create snapshot before promoting to final
   if (newStatus == 'final') {
      await db.into(db.snapshots).insert(
        SnapshotsCompanion.insert(
          chapterId: chapter.id,
          snapshotName: 'Before Final - ${DateTime.now()}',
          contentDelta: chapter.contentDelta ?? '',
          contentHtml: chapter.contentHtml ?? '',
        ),
      );
    }
    
    // Update status
    await (db.update(db.chapters)..where((c) => c.id.equals(chapter.id)))
        .write(ChaptersCompanion(status: drift.Value(newStatus)));
    
    // Auto-email if promoting to final
    if (newStatus == 'final' && mounted) {
      _emailChapter(chapter);
    }
    
    setState(() {});
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Promoted to ${newStatus == 'draft' ? 'Draft' : 'Final'}')),
      );
    }
  }

  void _emailChapter(Chapter chapter) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email feature available in Settings')),
    );
  }
}
