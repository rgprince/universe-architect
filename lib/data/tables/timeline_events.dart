import 'package:drift/drift.dart';
import 'universes.dart';

/// Timeline events for tracking major story moments across novels
class TimelineEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get universeId => integer().references(Universes, #id, onDelete: KeyAction.cascade)();
  
  // Event details
  TextColumn get eventName => text().withLength(min: 1, max: 500)();
  TextColumn get description => text().nullable()();
  
  // Temporal positioning
  TextColumn get eventDate => text().nullable()(); // "Year X, Day Y" or relative time
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // For custom ordering
  
  // Novel context
  TextColumn get novelContext => text().nullable()(); // Which novel this appears in
  
  // Involved entities (JSON array of entity IDs)
  TextColumn get involvedEntityIdsJson => text().withDefault(const Constant('[]'))();
  
  // Importance level (1-5, for filtering)
  IntColumn get importance => integer().withDefault(const Constant(3))();
  
  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
