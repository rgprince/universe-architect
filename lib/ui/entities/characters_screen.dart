import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';
import '../../data/providers/database_provider.dart';
import '../../data/database.dart';
import '../../data/tables/entities.dart';
import '../universes/universes_screen.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    final activeUniverseId = ref.watch(activeUniverseProvider);
    final db = ref.watch(databaseProvider);
    
    if (activeUniverseId == null) {
      return _buildNoUniverseState();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Entity>>(
        future: db.getEntitiesByType(activeUniverseId, EntityType.character),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final characters = snapshot.data ?? [];
          
          if (characters.isEmpty) {
            return _buildEmptyState();
          }
          
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              final attributes = _parseAttributes(character.attributesJson);
              
              return Card(
                child: InkWell(
                  onTap: () => _showCharacterDetails(character),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          character.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        character.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      if (attributes['species'] != null)
                        Text(
                          attributes['species'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      if (attributes['age'] != null)
                        Text(
                          'Age: ${attributes['age']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Character'),
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
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No Characters Yet', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          const Text('Create your first character'),
        ],
      ),
    );
  }
  
  void _showCreateDialog() {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final speciesController = TextEditingController();
    final backstoryController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Character'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name *'),
                autofocus: true,
              ),
              TextField(
                controller: speciesController,
                decoration: const InputDecoration(labelText: 'Species'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: backstoryController,
                decoration: const InputDecoration(labelText: 'Backstory'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;
              
              final attributes = <String, dynamic>{};
              if (speciesController.text.isNotEmpty) {
                attributes['species'] = speciesController.text;
              }
              if (ageController.text.isNotEmpty) {
                attributes['age'] = int.tryParse(ageController.text) ?? 0;
              }
              if (backstoryController.text.isNotEmpty) {
                attributes['backstory'] = backstoryController.text;
              }
              
              final db = ref.read(databaseProvider);
              final universeId = ref.read(activeUniverseProvider)!;
              
              await db.into(db.entities).insert(
                EntitiesCompanion.insert(
                  universeId: universeId,
                  type: EntityType.character,
                  name: nameController.text.trim(),
                  attributesJson: drift.Value(jsonEncode(attributes)),
                ),
              );
              
              if (context.mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
  
  void _showCharacterDetails(Entity character) {
    final attributes = _parseAttributes(character.attributesJson);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(character.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (attributes['species'] != null) ...[
                const Text('Species:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(attributes['species']),
                const SizedBox(height: 8),
              ],
              if (attributes['age'] != null) ...[
                const Text('Age:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${attributes['age']}'),
                const SizedBox(height: 8),
              ],
              if (attributes['backstory'] != null) ...[
                const Text('Backstory:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(attributes['backstory']),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _showDeleteDialog(character);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(Entity character) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Character?'),
        content: Text('Delete "${character.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              await (db.delete(db.entities)..where((e) => e.id.equals(character.id))).go();
              
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
  
  Map<String, dynamic> _parseAttributes(String json) {
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}
