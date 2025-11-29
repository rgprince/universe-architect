import 'package:drift/drift.dart';
import 'chapters.dart';
import 'entities.dart';

/// Scenes table - Used only in Scene Mode
/// Allows chapters to contain multiple scenes with metadata
class ScenesV3 extends Table {
  @override
  String get tableName => 'scenes_v3';
  
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer().references(Chapters, #id, onDelete: KeyAction.cascade)();
  IntColumn get sceneNumber => integer()();
  TextColumn get title => text().nullable()();
  
  // Scene content
  TextColumn get contentDelta => text().nullable()(); // Quill delta JSON
  TextColumn get contentHtml => text().nullable()();
  
  // Scene metadata (Scene Mode only)
  IntColumn get povCharacterId => integer().nullable().references(Entities, #id)();
  IntColumn get locationId => integer().nullable().references(Entities, #id)();
  TextColumn get status => text().withDefault(const Constant('draft'))(); // draft, needs_work, final
  
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
