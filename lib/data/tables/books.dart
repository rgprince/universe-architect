import 'package:drift/drift.dart';
import 'universes.dart';

/// Books table - Stories/documents within a universe
/// Enhanced in v3.0 with cover images, synopsis, and writing mode
class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get universeId => integer().references(Universes, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 500)();
  
  // v3.0 additions
  TextColumn get coverImagePath => text().nullable()(); // Path to 400x600 cover image
  TextColumn get synopsis => text().nullable()(); // Single synopsis for whole book
  TextColumn get writingMode => text().withDefault(const Constant('simple'))(); // 'simple' or 'scene'
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
