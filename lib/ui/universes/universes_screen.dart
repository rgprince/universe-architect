import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/database_provider.dart';
import '../../data/database.dart';

/// Provider for active universe ID
final activeUniverseProvider = StateProvider<int?>((ref) => null);

class UniversesScreen extends ConsumerStatefulWidget {
  const UniversesScreen({super.key});

  @override
  ConsumerState<UniversesScreen> createState() => _UniversesScreenState();
}

class _UniversesScreenState extends ConsumerState<UniversesScreen> {
  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Universes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Universe>>(
        future: db.getAllUniverses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final universes = snapshot.data ?? [];
          
          if (universes.isEmpty) {
            return _buildEmptyState();
          }
          
          return ListView.builder(
            itemCount: universes.length,
            itemBuilder: (context, index) {
              final universe = universes[index];
              final isActive = ref.watch(activeUniverseProvider) == universe.id;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: isActive ? 4 : 1,
                color: isActive ? Theme.of(context).colorScheme.primaryContainer : null,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      universe.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    universe.name,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    'Last accessed: ${_formatDate(universe.lastAccessed)}',
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: isActive 
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(activeUniverseProvider.notifier).state = universe.id;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Switched to ${universe.name}')),
                    );
                  },
                  onLongPress: () => _showDeleteDialog(universe),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: const Icon(Icons.add),
        label: const Text('Create Universe'),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.public, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No Universes Yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Create your first story universe to get started'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateDialog,
            icon: const Icon(Icons.add),
            label: const Text('Create Universe'),
          ),
        ],
      ),
    );
  }
  
  void _showCreateDialog() {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Universe'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Universe Name',
            hintText: 'e.g., Middle-earth Chronicles',
          ),
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
              await db.into(db.universes).insert(
                UniversesCompanion.insert(
                  name: controller.text.trim(),
                  lastAccessed: DateTime.now(),
                ),
              );
              
              if (context.mounted) {
                Navigator.pop(context);
                setState(() {}); // Refresh list
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(Universe universe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Universe?'),
        content: Text(
          'This will permanently delete "${universe.name}" and all its books, characters, and scenes. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              await (db.delete(db.universes)..where((u) => u.id.equals(universe.id))).go();
              
              if (context.mounted) {
                Navigator.pop(context);
                setState(() {}); // Refresh list
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Universe deleted')),
                );
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
