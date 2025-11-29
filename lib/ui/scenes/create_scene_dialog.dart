import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database.dart';
import '../../data/tables/entities.dart';
import '../../data/providers/database_provider.dart';
import '../entities/characters_screen.dart';
import '../entities/locations_screen.dart';

/// Scene Creation Dialog - For Scene Mode books
/// Allows setting POV character, location, and status
class CreateSceneDialog extends ConsumerStatefulWidget {
  final Chapter chapter;
  final int universeId;
  
  const CreateSceneDialog({
    super.key,
    required this.chapter,
    required this.universeId,
  });

  @override
  ConsumerState<CreateSceneDialog> createState() => _CreateSceneDialogState();
}

class _CreateSceneDialogState extends ConsumerState<CreateSceneDialog> {
  final _titleController = TextEditingController();
  int? _selectedCharacterId;
  int? _selectedLocationId;
  String _status = 'draft';
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    
    return AlertDialog(
      title: const Text('📝 Create New Scene'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scene Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Scene Title (Optional)',
                  hintText: 'e.g., Opening, Conflict, Resolution',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              
              // POV Character
              FutureBuilder<List<Entity>>(
                future: db.getEntitiesByType(widget.universeId, EntityType.character),
                builder: (context, snapshot) {
                  final characters = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _selectedCharacterId,
                    decoration: const InputDecoration(
                      labelText: 'POV Character',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('None')),
                      ...characters.map((char) => DropdownMenuItem(
                        value: char.id,
                        child: Text(char.name),
                      )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCharacterId = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // Location
              FutureBuilder<List<Entity>>(
                future: db.getEntitiesByType(widget.universeId, EntityType.location),
                builder: (context, snapshot) {
                  final locations = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _selectedLocationId,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('None')),
                      ...locations.map((loc) => DropdownMenuItem(
                        value: loc.id,
                        child: Text(loc.name),
                      )),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLocationId = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // Status
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: 'draft', child: Text('📝 Draft')),
                  DropdownMenuItem(value: 'needs_work', child: Text('⚠️ Needs Work')),
                  DropdownMenuItem(value: 'final', child: Text('✅ Final')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
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
          onPressed: _createScene,
          icon: const Icon(Icons.add),
          label: const Text('Create Scene'),
        ),
      ],
    );
  }
  
  Future<void> _createScene() async {
    final db = ref.read(databaseProvider);
    
    // Get next scene number
    final existingScenes = await db.getScenesForChapter(widget.chapter.id);
    final nextNumber = existingScenes.length + 1;
    
    await db.into(db.scenesV3).insert(
      ScenesV3Companion.insert(
        chapterId: widget.chapter.id,
        sceneNumber: nextNumber,
        title: drift.Value(_titleController.text.trim().isNotEmpty 
            ? _titleController.text.trim() 
            : null),
        povCharacterId: drift.Value(_selectedCharacterId),
        locationId: drift.Value(_selectedLocationId),
        status: drift.Value(_status),
      ),
    );
    
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }
}
