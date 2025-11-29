import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../../services/export_service.dart';
import '../entities/characters_screen.dart';
import '../entities/locations_screen.dart';
import 'chapters_tab.dart';

/// Book Detail Screen - Central hub for a book with tabs
/// Enhanced with export functionality
class BookDetailScreen extends ConsumerStatefulWidget {
  final Book book;
  
  const BookDetailScreen({super.key, required this.book});

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _exportService = ExportService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: const TextStyle(fontSize: 18)),
            if (book.synopsis != null && book.synopsis!.isNotEmpty)
              Text(
                book.synopsis!,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Export to EPUB',
            onPressed: () => _exportToEpub(),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Book Details',
            onPressed: () => _editBookDetails(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book), text: 'Chapters'),
            Tab(icon: Icon(Icons.people), text: 'Characters'),
            Tab(icon: Icon(Icons.location_on), text: 'Locations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChaptersTab(book: book),
          CharactersScreen(),
          LocationsScreen(),
        ],
      ),
    );
  }

  Future<void> _exportToEpub() async {
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
                Text('Exporting to EPUB...'),
              ],
            ),
          ),
        ),
      ),
    );
    
    final db = ref.read(databaseProvider);
    final path = await _exportService.exportToEpub(db, widget.book);
    
    if (context.mounted) {
      Navigator.pop(context); // Close loading dialog
      
      if (path != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('✅ Export Successful'),
            content: Text('EPUB saved to:\n$path'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export failed. Make sure you have chapters written.')),
        );
      }
    }
  }

  Future<void> _editBookDetails() async {
    // TODO: Implement book edit dialog
  }
}
