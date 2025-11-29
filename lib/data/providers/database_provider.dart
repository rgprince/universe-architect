import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database.dart';

/// Global database provider for Universe Architect
/// 
/// Provides a singleton instance of AppDatabase across the application.
/// Use this provider to access database queries and operations.
/// 
/// Example usage:
/// ```dart
/// final db = ref.read(databaseProvider);
/// final universes = await db.getAllUniverses();
/// ```
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  
  // Ensure database is disposed when provider is disposed
  ref.onDispose(() {
    db.close();
  });
  
  return db;
});
