import 'package:drift/drift.dart';
import 'universes.dart';

/// Entity types for world-building elements
enum EntityType {
  character,
  location,
  item,
  event,
  planet,        // Planetary bodies in the universe hierarchy
  organization,  // ZERO, VIP factions, etc.
  technique,     // Atomic Prayer, Ashes of Fire, etc.
}

/// Type converter for EntityType enum
class EntityTypeConverter extends TypeConverter<EntityType, String> {
  const EntityTypeConverter();

  @override
  EntityType fromSql(String fromDb) {
    return EntityType.values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => EntityType.character,
    );
  }

  @override
  String toSql(EntityType value) {
    return value.name;
  }
}

/// Entities table - Characters, locations, items, and events
class Entities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get universeId => integer().references(Universes, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text().map(const EntityTypeConverter())();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get attributesJson => text().withDefault(const Constant('{}'))();
  
  // Novel-specific extensions (v4)
  IntColumn get planetId => integer().nullable()(); // Reference to Planets table
  IntColumn get currentAge => integer().nullable()(); // Character's age
  TextColumn get status => text().nullable()(); // "Alive", "Dead", "Unknown"
  TextColumn get firstAppearedIn => text().nullable()(); // Novel name
}
