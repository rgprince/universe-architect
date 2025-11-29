import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Import all table definitions
import 'tables/universes.dart';
import 'tables/books.dart';
import 'tables/entities.dart';
import 'tables/relationships.dart';
import 'tables/scenes.dart';
import 'tables/chapters.dart';
import 'tables/scenes_v3.dart';
import 'tables/snapshots.dart';
import 'tables/writing_sessions.dart';
import 'tables/ai_conversations.dart';

part 'database.g.dart';

/// Main database configuration for Universe Architect
/// v3.5: Added AiConversations, AiMessages, chapter status
@DriftDatabase(tables: [
  Universes,
  Books,
  Entities,
  Relationships,
  Scenes,
  Chapters,
  ScenesV3,
  Snapshots,
  WritingSessions,
  AiConversations,
  AiMessages,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3; // v3.5 schema
  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // v1 to v2 migration (v2.0 to v3.0)
        await m.createTable(chapters);
        await m.createTable(scenesV3);
        await m.createTable(snapshots);
        await m.createTable(writingSessions);
        
        // Add new columns to existing Books table
        await m.addColumn(books, books.coverImagePath);
        await m.addColumn(books, books.synopsis);
        await m.addColumn(books, books.writingMode);
        await m.addColumn(books, books.createdAt);
        await m.addColumn(books, books.updatedAt);
      }
      
      if (from < 3) {
        // v2 to v3 migration (v3.0 to v3.5)
        await m.createTable(aiConversations);
        await m.createTable(aiMessages);
        
        // Add status column to Chapters
        await m.addColumn(chapters, chapters.status);
      }
    },
  );

  /// Query: Get all universes ordered by last accessed
  Future<List<Universe>> getAllUniverses() {
    return (select(universes)..orderBy([(u) => OrderingTerm.desc(u.lastAccessed)])).get();
  }

  /// Query: Get all books for a specific universe
  Future<List<Book>> getBooksForUniverse(int universeId) {
    return (select(books)..where((b) => b.universeId.equals(universeId))).get();
  }
  
  /// v3.0: Get all chapters for a book
  Future<List<Chapter>> getChaptersForBook(int bookId) {
    return (select(chapters)
      ..where((c) => c.bookId.equals(bookId))
      ..orderBy([(c) => OrderingTerm.asc(c.chapterNumber)]))
      .get();
  }
  
  /// v3.0: Get all scenes for a chapter (Scene Mode)
  Future<List<ScenesV3Data>> getScenesForChapter(int chapterId) {
    return (select(scenesV3)
      ..where((s) => s.chapterId.equals(chapterId))
      ..orderBy([(s) => OrderingTerm.asc(s.sceneNumber)]))
      .get();
  }
  
  /// v3.0: Get writing sessions for a book
  Future<List<WritingSession>> getWritingSessionsForBook(int bookId) {
    return (select(writingSessions)
      ..where((w) => w.bookId.equals(bookId))
      ..orderBy([(w) => OrderingTerm.desc(w.date)]))
      .get();
  }

  /// Query: Get all entities for a specific universe
  Future<List<Entity>> getEntitiesForUniverse(int universeId) {
    return (select(entities)..where((e) => e.universeId.equals(universeId))).get();
  }

  /// Query: Get all entities of a specific type
  Future<List<Entity>> getEntitiesByType(int universeId, EntityType type) {
    return (select(entities)
          ..where((e) => e.universeId.equals(universeId) & e.type.equals(type.name)))
        .get();
  }

  /// Query: Get all relationships for an entity (both as source and target)
  Future<List<EntityRelationship>> getRelationshipsForEntity(int entityId) {
    return (select(relationships)
          ..where((r) => r.sourceId.equals(entityId) | r.targetId.equals(entityId)))
        .get();
  }

  /// Query: Get all scenes for a specific book
  Future<List<Scene>> getScenesForBook(int bookId) {
    return (select(scenes)..where((s) => s.bookId.equals(bookId))).get();
  }

  /// Complex Query: Get entity with its relationships (for RAG context)
  Future<Map<String, dynamic>> getEntityWithRelationships(int entityId) async {
    final entity = await (select(entities)..where((e) => e.id.equals(entityId))).getSingleOrNull();
    
    if (entity == null) {
      return {};
    }

    final relatedAsSource = await (select(relationships)
          ..where((r) => r.sourceId.equals(entityId)))
        .get();

    final relatedAsTarget = await (select(relationships)
          ..where((r) => r.targetId.equals(entityId)))
        .get();

    return {
      'entity': entity,
      'outgoingRelationships': relatedAsSource,
      'incomingRelationships': relatedAsTarget,
    };
  }

  /// Query: Fetch entities by names (for RAG context retrieval in Phase 3)
  /// Used by AI chat to identify mentioned entities in user prompts
  Future<List<Entity>> fetchEntitiesByNames(int universeId, List<String> names) {
    if (names.isEmpty) {
      return Future.value([]);
    }
    return (select(entities)
          ..where((e) => e.universeId.equals(universeId) & e.name.isIn(names)))
        .get();
  }
}

/// Database connection factory for Android
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'universe_architect.db'));
    return NativeDatabase.createInBackground(file);
  });
}
