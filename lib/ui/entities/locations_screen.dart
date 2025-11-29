import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';
import '../../data/providers/database_provider.dart';
import '../../data/database.dart';
import '../../data/tables/entities.dart';
import '../universes/universes_screen.dart';

class LocationsScreen extends ConsumerStatefulWidget {
  const LocationsScreen({super.key});

  @override
  ConsumerState<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends ConsumerState<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    final activeUniverseId = ref.watch(activeUniverseProvider);
    final db = ref.watch(databaseProvider);
    
    if (activeUniverseId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Locations')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.public_off, size: 100, color: Colors.grey.shade300),
              const SizedBox(height: 16),
              const Text('No Universe Selected'),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Entity>>(
        future: db.getEntitiesByType(activeUniverseId, EntityType.location),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final locations = snapshot.data ?? [];
          
          if (locations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.place_outlined, size: 100, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('No Locations Yet', style: TextStyle(fontSize: 20)),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              final attributes = _parseAttributes(location.attributesJson);
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.place, size: 40, color: Colors.green),
                  title: Text(location.name),
                  subtitle: Text(
                    attributes['climate'] ?? 'No description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(location),
                  ),
                  onTap: () => _showLocationDetails(location),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: const Icon(Icons.add_location),
        label: const Text('Add Location'),
      ),
    );
  }
  
  void _showCreateDialog() {
    final nameController = TextEditingController();
    final climateController = TextEditingController();
    final populationController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name *'),
              autofocus: true,
            ),
            TextField(
              controller: climateController,
              decoration: const InputDecoration(labelText: 'Climate/Description'),
            ),
            TextField(
              controller: populationController,
              decoration: const InputDecoration(labelText: 'Population'),
              keyboardType: TextInputType.number,
            ),
          ],
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
              if (climateController.text.isNotEmpty) {
                attributes['climate'] = climateController.text;
              }
              if (populationController.text.isNotEmpty) {
                attributes['population'] = int.tryParse(populationController.text) ?? 0;
              }
              
              final db = ref.read(databaseProvider);
              final universeId = ref.read(activeUniverseProvider)!;
              
              await db.into(db.entities).insert(
                EntitiesCompanion.insert(
                  universeId: universeId,
                  type: EntityType.location,
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
  
  void _showLocationDetails(Entity location) {
    final attributes = _parseAttributes(location.attributesJson);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location.name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (attributes['climate'] != null) ...[
              const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(attributes['climate']),
              const SizedBox(height: 8),
            ],
            if (attributes['population'] != null) ...[
              const Text('Population:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${attributes['population']}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(Entity location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Location?'),
        content: Text('Delete "${location.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              await (db.delete(db.entities)..where((e) => e.id.equals(location.id))).go();
              
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
