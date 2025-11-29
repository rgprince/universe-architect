import 'package:drift/drift.dart';
import 'books.dart';

/// Writing sessions table - Track daily writing progress
class WritingSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id, onDelete: KeyAction.cascade)();
  
  DateTimeColumn get date => dateTime()();
  IntColumn get wordsWritten => integer().withDefault(const Constant(0))();
  IntColumn get durationMinutes => integer().withDefault(const Constant(0))();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
