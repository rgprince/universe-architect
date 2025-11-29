import 'package:drift/drift.dart';
import 'books.dart';

/// Scenes table - Individual scenes/chapters with rich text content
class Scenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id, onDelete: KeyAction.cascade)();
  TextColumn get contentDelta => text().withDefault(const Constant(''))();
  TextColumn get contentHtml => text().withDefault(const Constant(''))();
}
