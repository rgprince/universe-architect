import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/providers/database_provider.dart';
import '../../data/database.dart';
import '../universes/universes_screen.dart';
import 'book_detail_screen.dart';
import 'create_book_dialog.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    final activeUniverseId = ref.watch(activeUniverseProvider);
    final db = ref.watch(databaseProvider);
    
    if (activeUniverseId == null) {
      return _buildNoUniverseState();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Book>>(
        future: db.getBooksForUniverse(activeUniverseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final books = snapshot.data ?? [];
          
          if (books.isEmpty) {
            return _buildEmptyState();
          }
          
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.book, size: 40),
                  title: Text(book.title),
                  subtitle: Text('${book.writingMode == 'simple' ? 'Simple' : 'Scene'} Mode'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showBookOptions(book),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: const Icon(Icons.add),
        label: const Text('New Book'),
      ),
    );
  }
  
  Widget _buildNoUniverseState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.public_off, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No Universe Selected', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          const Text('Please select a universe first'),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No Books Yet', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          const Text('Create your first book to start writing'),
        ],
      ),
    );
  }
  
  void _showCreateDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const CreateBookDialog(),
    );
    
    if (result == true && mounted) {
      setState(() {}); // Refresh the list
    }
  }
  
  void _showBookOptions(Book book) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                _showRenameDialog(book);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteDialog(book);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _showRenameDialog(Book book) {
    final controller = TextEditingController(text: book.title);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Book'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Book Title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              
              final db = ref.read(databaseProvider);
              await (db.update(db.books)..where((b) => b.id.equals(book.id)))
                  .write(BooksCompanion(title: drift.Value(controller.text.trim())));
              
              if (context.mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book?'),
        content: Text('This will delete "${book.title}" and all its scenes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              await (db.delete(db.books)..where((b) => b.id.equals(book.id))).go();
              
              if (context.mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
