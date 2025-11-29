import 'package:drift/drift.dart';
import 'universes.dart';

/// Planetary tier classification
enum PlanetTier {
  cosmic,   // Galaxy destroyer level
  topTier,  // Superior races with advanced tech + cultivation
  midTier,  // Demon planets, etc.
  lowTier,  // Earth and similar
}

/// Type converter for PlanetTier enum
class PlanetTierConverter extends TypeConverter<PlanetTier, String> {
  const PlanetTierConverter();

  @override
  PlanetTier fromSql(String fromDb) {
    return PlanetTier.values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => PlanetTier.lowTier,
    );
  }

  @override
  String toSql(PlanetTier value) {
    return value.name;
  }
}

/// Planets table - Hierarchical planetary system
class Planets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get universeId => integer().references(Universes, #id, onDelete: KeyAction.cascade)();
  
  // Basic info
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get tier => text().map(const PlanetTierConverter())();
  TextColumn get description => text().nullable()();
  
  // World details (JSON arrays for flexibility)
  TextColumn get keyLocationsJson => text().withDefault(const Constant('[]'))();
  TextColumn get dominantRacesJson => text().withDefault(const Constant('[]'))();
  
  // Characteristics
  TextColumn get technologyLevel => text().nullable()(); // "Advanced", "Medieval", etc.
  TextColumn get cultivationStyle => text().nullable()(); // "Chakra-based", "Demonic", etc.
  
  // Special properties
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))(); // Like Earth
  TextColumn get hiddenMethod => text().nullable()(); // "Protective layer", etc.
  
  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
