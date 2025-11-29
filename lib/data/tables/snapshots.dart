import 'package:drift/drift.dart';
import 'chapters.dart';
import 'scenes_v3.dart';

/// Snapshots table - Version control system
/// Saves chapter/scene content before major edits
class Snapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer().references(Chapters, #id, onDelete: KeyAction.cascade)();
  IntColumn get sceneId => integer().nullable().references(ScenesV3, #id, onDelete: KeyAction.cascade)();
  
  TextColumn get snapshotName => text()();
  TextColumn get contentDelta => text()();
  TextColumn get contentHtml => text()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
