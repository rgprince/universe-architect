import 'package:drift/drift.dart';
import 'books.dart';

/// AI Conversations table - stores chat history with context
class AiConversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().nullable().references(Books, #id)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// AI Messages table - individual messages in conversations
class AiMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId => integer().references(AiConversations, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()(); // 'user' or 'assistant'
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}
