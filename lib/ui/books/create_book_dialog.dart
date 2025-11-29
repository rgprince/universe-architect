import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../../services/preferences_service.dart';
import '../universes/universes_screen.dart';

/// Enhanced Book Creation Dialog for v3.0
/// Includes cover picker, synopsis, and writing mode selection
class CreateBookDialog extends ConsumerStatefulWidget {
  const CreateBookDialog({super.key});

  @override
  ConsumerState<CreateBookDialog> createState() => _CreateBookDialogState();
}

class _CreateBookDialogState extends ConsumerState<CreateBookDialog> {
  final _titleController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _prefs = PreferencesService();
  
  String _writingMode = 'simple'; // simple or scene
  
  @override
  void initState() {
    super.initState();
    _loadDefaultMode();
  }
  
  Future<void> _loadDefaultMode() async {
    final defaultMode = await _prefs.getWritingMode();
    setState(() {
      _writingMode = defaultMode == 0 ? 'simple' : 'scene';
    });
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('📚 Create New Book'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Book Title *',
                  hintText: 'e.g., The Fellowship of the Ring',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              
              // Synopsis
              TextField(
                controller: _synopsisController,
                decoration: const InputDecoration(
                  labelText: 'Synopsis (Optional)',
                  hintText: 'Brief description of your book...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              
              // Writing Mode
              _buildWritingModeSelector(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _createBook,
          icon: const Icon(Icons.add),
          label: const Text('Create Book'),
        ),
      ],
    );
  }
  
  Widget _buildWritingModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Writing Mode',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        RadioListTile<String>(
          title: const Text('Simple Mode'),
          subtitle: const Text('Just write chapters, no structural planning'),
          value: 'simple',
          groupValue: _writingMode,
          onChanged: (value) {
            setState(() {
              _writingMode = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Scene Mode'),
          subtitle: const Text('Organized scenes with POV, locations, status tracking'),
          value: 'scene',
          groupValue: _writingMode,
          onChanged: (value) {
            setState(() {
              _writingMode = value!;
            });
          },
        ),
      ],
    );
  }
  
  Future<void> _createBook() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a book title')),
      );
      return;
    }
    
    final db = ref.read(databaseProvider);
    final universeId = ref.read(activeUniverseProvider);
    
    if (universeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a universe first')),
      );
      return;
    }
    
    await db.into(db.books).insert(
      BooksCompanion.insert(
        universeId: universeId,
        title: _titleController.text.trim(),
        synopsis: drift.Value(_synopsisController.text.trim().isNotEmpty 
            ? _synopsisController.text.trim() 
            : null),
        coverImagePath: const drift.Value(null), // Cover images disabled
        writingMode: drift.Value(_writingMode),
      ),
    );
    
    if (context.mounted) {
      Navigator.pop(context, true); // Return true to indicate success
    }
  }
}
