import 'package:drift/drift.dart';
import 'entities.dart';

/// Power system tracking for characters (Chakra, Soul Shards, Cultivation)
class PowerSystems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entityId => integer().references(Entities, #id, onDelete: KeyAction.cascade)();
  
  // Chakra System
  IntColumn get chakraLevel => integer().nullable()(); // 1-7 (7 chakra nodes)
  IntColumn get currentChakra => integer().nullable()();
  IntColumn get maxChakra => integer().nullable()();
  
  // Soul Shards
  IntColumn get soulShards => integer().withDefault(const Constant(0))();
  IntColumn get requiredShardsForEvolution => integer().nullable()();
  
  // Cultivation Rank (stored as text for flexibility)
  TextColumn get cultivationRank => text().nullable()(); // "Innate Vein", "Soul Queen", etc.
  
  // Elements (JSON array: ["Ice", "Fire"])
  TextColumn get elementsJson => text().withDefault(const Constant('[]'))();
  
  // Special Abilities (JSON array of ability names/descriptions)
  TextColumn get specialAbilitiesJson => text().withDefault(const Constant('[]'))();
  
  // Timestamps
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();
}
