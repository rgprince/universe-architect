import 'package:drift/drift.dart';
import 'books.dart';

/// Chapters table - Main organizational unit for writing
/// Works in both Simple Mode (chapter = single document) 
/// and Scene Mode (chapter = container for scenes)
class Chapters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id, onDelete: KeyAction.cascade)();
  IntColumn get chapterNumber => integer()();
  TextColumn get title => text().nullable()();
  
  // For Simple Mode: stores content directly
  TextColumn get contentDelta => text().nullable()(); // Quill delta JSON
  TextColumn get contentHtml => text().nullable()();
  
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  
  /// Status: 'outline', 'draft', 'final'
  TextColumn get status => text().withDefault(const Constant('draft'))();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
