import 'package:drift/drift.dart';

/// Universes table - Root level for all world-building data
class Universes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  DateTimeColumn get lastAccessed => dateTime()();
}
