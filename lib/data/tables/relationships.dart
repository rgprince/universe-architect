import 'package:drift/drift.dart';
import 'entities.dart';

/// Relationships table - Graph connections between entities
@DataClassName('EntityRelationship')
class Relationships extends Table {
  IntColumn get sourceId => integer().references(Entities, #id, onDelete: KeyAction.cascade)();
  IntColumn get targetId => integer().references(Entities, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text().withLength(min: 1, max: 100)();
  TextColumn get metadata => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {sourceId, targetId};
}
