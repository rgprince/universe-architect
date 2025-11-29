// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UniversesTable extends Universes
    with TableInfo<$UniversesTable, Universe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UniversesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedMeta =
      const VerificationMeta('lastAccessed');
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
      'last_accessed', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, lastAccessed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'universes';
  @override
  VerificationContext validateIntegrity(Insertable<Universe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
          _lastAccessedMeta,
          lastAccessed.isAcceptableOrUnknown(
              data['last_accessed']!, _lastAccessedMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Universe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Universe(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastAccessed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_accessed'])!,
    );
  }

  @override
  $UniversesTable createAlias(String alias) {
    return $UniversesTable(attachedDatabase, alias);
  }
}

class Universe extends DataClass implements Insertable<Universe> {
  final int id;
  final String name;
  final DateTime lastAccessed;
  const Universe(
      {required this.id, required this.name, required this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_accessed'] = Variable<DateTime>(lastAccessed);
    return map;
  }

  UniversesCompanion toCompanion(bool nullToAbsent) {
    return UniversesCompanion(
      id: Value(id),
      name: Value(name),
      lastAccessed: Value(lastAccessed),
    );
  }

  factory Universe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Universe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastAccessed: serializer.fromJson<DateTime>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastAccessed': serializer.toJson<DateTime>(lastAccessed),
    };
  }

  Universe copyWith({int? id, String? name, DateTime? lastAccessed}) =>
      Universe(
        id: id ?? this.id,
        name: name ?? this.name,
        lastAccessed: lastAccessed ?? this.lastAccessed,
      );
  Universe copyWithCompanion(UniversesCompanion data) {
    return Universe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Universe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Universe &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastAccessed == this.lastAccessed);
}

class UniversesCompanion extends UpdateCompanion<Universe> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> lastAccessed;
  const UniversesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastAccessed = const Value.absent(),
  });
  UniversesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime lastAccessed,
  })  : name = Value(name),
        lastAccessed = Value(lastAccessed);
  static Insertable<Universe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? lastAccessed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
    });
  }

  UniversesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<DateTime>? lastAccessed}) {
    return UniversesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UniversesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _universeIdMeta =
      const VerificationMeta('universeId');
  @override
  late final GeneratedColumn<int> universeId = GeneratedColumn<int>(
      'universe_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES universes (id) ON DELETE CASCADE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _coverImagePathMeta =
      const VerificationMeta('coverImagePath');
  @override
  late final GeneratedColumn<String> coverImagePath = GeneratedColumn<String>(
      'cover_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _synopsisMeta =
      const VerificationMeta('synopsis');
  @override
  late final GeneratedColumn<String> synopsis = GeneratedColumn<String>(
      'synopsis', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _writingModeMeta =
      const VerificationMeta('writingMode');
  @override
  late final GeneratedColumn<String> writingMode = GeneratedColumn<String>(
      'writing_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('simple'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        universeId,
        title,
        coverImagePath,
        synopsis,
        writingMode,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('universe_id')) {
      context.handle(
          _universeIdMeta,
          universeId.isAcceptableOrUnknown(
              data['universe_id']!, _universeIdMeta));
    } else if (isInserting) {
      context.missing(_universeIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cover_image_path')) {
      context.handle(
          _coverImagePathMeta,
          coverImagePath.isAcceptableOrUnknown(
              data['cover_image_path']!, _coverImagePathMeta));
    }
    if (data.containsKey('synopsis')) {
      context.handle(_synopsisMeta,
          synopsis.isAcceptableOrUnknown(data['synopsis']!, _synopsisMeta));
    }
    if (data.containsKey('writing_mode')) {
      context.handle(
          _writingModeMeta,
          writingMode.isAcceptableOrUnknown(
              data['writing_mode']!, _writingModeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      universeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}universe_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      coverImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cover_image_path']),
      synopsis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synopsis']),
      writingMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}writing_mode'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final int universeId;
  final String title;
  final String? coverImagePath;
  final String? synopsis;
  final String writingMode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Book(
      {required this.id,
      required this.universeId,
      required this.title,
      this.coverImagePath,
      this.synopsis,
      required this.writingMode,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['universe_id'] = Variable<int>(universeId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || coverImagePath != null) {
      map['cover_image_path'] = Variable<String>(coverImagePath);
    }
    if (!nullToAbsent || synopsis != null) {
      map['synopsis'] = Variable<String>(synopsis);
    }
    map['writing_mode'] = Variable<String>(writingMode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      universeId: Value(universeId),
      title: Value(title),
      coverImagePath: coverImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImagePath),
      synopsis: synopsis == null && nullToAbsent
          ? const Value.absent()
          : Value(synopsis),
      writingMode: Value(writingMode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      universeId: serializer.fromJson<int>(json['universeId']),
      title: serializer.fromJson<String>(json['title']),
      coverImagePath: serializer.fromJson<String?>(json['coverImagePath']),
      synopsis: serializer.fromJson<String?>(json['synopsis']),
      writingMode: serializer.fromJson<String>(json['writingMode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'universeId': serializer.toJson<int>(universeId),
      'title': serializer.toJson<String>(title),
      'coverImagePath': serializer.toJson<String?>(coverImagePath),
      'synopsis': serializer.toJson<String?>(synopsis),
      'writingMode': serializer.toJson<String>(writingMode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Book copyWith(
          {int? id,
          int? universeId,
          String? title,
          Value<String?> coverImagePath = const Value.absent(),
          Value<String?> synopsis = const Value.absent(),
          String? writingMode,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Book(
        id: id ?? this.id,
        universeId: universeId ?? this.universeId,
        title: title ?? this.title,
        coverImagePath:
            coverImagePath.present ? coverImagePath.value : this.coverImagePath,
        synopsis: synopsis.present ? synopsis.value : this.synopsis,
        writingMode: writingMode ?? this.writingMode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      universeId:
          data.universeId.present ? data.universeId.value : this.universeId,
      title: data.title.present ? data.title.value : this.title,
      coverImagePath: data.coverImagePath.present
          ? data.coverImagePath.value
          : this.coverImagePath,
      synopsis: data.synopsis.present ? data.synopsis.value : this.synopsis,
      writingMode:
          data.writingMode.present ? data.writingMode.value : this.writingMode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('universeId: $universeId, ')
          ..write('title: $title, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('synopsis: $synopsis, ')
          ..write('writingMode: $writingMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, universeId, title, coverImagePath,
      synopsis, writingMode, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.universeId == this.universeId &&
          other.title == this.title &&
          other.coverImagePath == this.coverImagePath &&
          other.synopsis == this.synopsis &&
          other.writingMode == this.writingMode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<int> universeId;
  final Value<String> title;
  final Value<String?> coverImagePath;
  final Value<String?> synopsis;
  final Value<String> writingMode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.universeId = const Value.absent(),
    this.title = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.writingMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required int universeId,
    required String title,
    this.coverImagePath = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.writingMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : universeId = Value(universeId),
        title = Value(title);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<int>? universeId,
    Expression<String>? title,
    Expression<String>? coverImagePath,
    Expression<String>? synopsis,
    Expression<String>? writingMode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (universeId != null) 'universe_id': universeId,
      if (title != null) 'title': title,
      if (coverImagePath != null) 'cover_image_path': coverImagePath,
      if (synopsis != null) 'synopsis': synopsis,
      if (writingMode != null) 'writing_mode': writingMode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BooksCompanion copyWith(
      {Value<int>? id,
      Value<int>? universeId,
      Value<String>? title,
      Value<String?>? coverImagePath,
      Value<String?>? synopsis,
      Value<String>? writingMode,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BooksCompanion(
      id: id ?? this.id,
      universeId: universeId ?? this.universeId,
      title: title ?? this.title,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      synopsis: synopsis ?? this.synopsis,
      writingMode: writingMode ?? this.writingMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (universeId.present) {
      map['universe_id'] = Variable<int>(universeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (coverImagePath.present) {
      map['cover_image_path'] = Variable<String>(coverImagePath.value);
    }
    if (synopsis.present) {
      map['synopsis'] = Variable<String>(synopsis.value);
    }
    if (writingMode.present) {
      map['writing_mode'] = Variable<String>(writingMode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('universeId: $universeId, ')
          ..write('title: $title, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('synopsis: $synopsis, ')
          ..write('writingMode: $writingMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EntitiesTable extends Entities with TableInfo<$EntitiesTable, Entity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _universeIdMeta =
      const VerificationMeta('universeId');
  @override
  late final GeneratedColumn<int> universeId = GeneratedColumn<int>(
      'universe_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES universes (id) ON DELETE CASCADE'));
  @override
  late final GeneratedColumnWithTypeConverter<EntityType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<EntityType>($EntitiesTable.$convertertype);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _attributesJsonMeta =
      const VerificationMeta('attributesJson');
  @override
  late final GeneratedColumn<String> attributesJson = GeneratedColumn<String>(
      'attributes_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, universeId, type, name, attributesJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entities';
  @override
  VerificationContext validateIntegrity(Insertable<Entity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('universe_id')) {
      context.handle(
          _universeIdMeta,
          universeId.isAcceptableOrUnknown(
              data['universe_id']!, _universeIdMeta));
    } else if (isInserting) {
      context.missing(_universeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('attributes_json')) {
      context.handle(
          _attributesJsonMeta,
          attributesJson.isAcceptableOrUnknown(
              data['attributes_json']!, _attributesJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      universeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}universe_id'])!,
      type: $EntitiesTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      attributesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}attributes_json'])!,
    );
  }

  @override
  $EntitiesTable createAlias(String alias) {
    return $EntitiesTable(attachedDatabase, alias);
  }

  static TypeConverter<EntityType, String> $convertertype =
      const EntityTypeConverter();
}

class Entity extends DataClass implements Insertable<Entity> {
  final int id;
  final int universeId;
  final EntityType type;
  final String name;
  final String attributesJson;
  const Entity(
      {required this.id,
      required this.universeId,
      required this.type,
      required this.name,
      required this.attributesJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['universe_id'] = Variable<int>(universeId);
    {
      map['type'] = Variable<String>($EntitiesTable.$convertertype.toSql(type));
    }
    map['name'] = Variable<String>(name);
    map['attributes_json'] = Variable<String>(attributesJson);
    return map;
  }

  EntitiesCompanion toCompanion(bool nullToAbsent) {
    return EntitiesCompanion(
      id: Value(id),
      universeId: Value(universeId),
      type: Value(type),
      name: Value(name),
      attributesJson: Value(attributesJson),
    );
  }

  factory Entity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entity(
      id: serializer.fromJson<int>(json['id']),
      universeId: serializer.fromJson<int>(json['universeId']),
      type: serializer.fromJson<EntityType>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      attributesJson: serializer.fromJson<String>(json['attributesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'universeId': serializer.toJson<int>(universeId),
      'type': serializer.toJson<EntityType>(type),
      'name': serializer.toJson<String>(name),
      'attributesJson': serializer.toJson<String>(attributesJson),
    };
  }

  Entity copyWith(
          {int? id,
          int? universeId,
          EntityType? type,
          String? name,
          String? attributesJson}) =>
      Entity(
        id: id ?? this.id,
        universeId: universeId ?? this.universeId,
        type: type ?? this.type,
        name: name ?? this.name,
        attributesJson: attributesJson ?? this.attributesJson,
      );
  Entity copyWithCompanion(EntitiesCompanion data) {
    return Entity(
      id: data.id.present ? data.id.value : this.id,
      universeId:
          data.universeId.present ? data.universeId.value : this.universeId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      attributesJson: data.attributesJson.present
          ? data.attributesJson.value
          : this.attributesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entity(')
          ..write('id: $id, ')
          ..write('universeId: $universeId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('attributesJson: $attributesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, universeId, type, name, attributesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entity &&
          other.id == this.id &&
          other.universeId == this.universeId &&
          other.type == this.type &&
          other.name == this.name &&
          other.attributesJson == this.attributesJson);
}

class EntitiesCompanion extends UpdateCompanion<Entity> {
  final Value<int> id;
  final Value<int> universeId;
  final Value<EntityType> type;
  final Value<String> name;
  final Value<String> attributesJson;
  const EntitiesCompanion({
    this.id = const Value.absent(),
    this.universeId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.attributesJson = const Value.absent(),
  });
  EntitiesCompanion.insert({
    this.id = const Value.absent(),
    required int universeId,
    required EntityType type,
    required String name,
    this.attributesJson = const Value.absent(),
  })  : universeId = Value(universeId),
        type = Value(type),
        name = Value(name);
  static Insertable<Entity> custom({
    Expression<int>? id,
    Expression<int>? universeId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? attributesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (universeId != null) 'universe_id': universeId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (attributesJson != null) 'attributes_json': attributesJson,
    });
  }

  EntitiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? universeId,
      Value<EntityType>? type,
      Value<String>? name,
      Value<String>? attributesJson}) {
    return EntitiesCompanion(
      id: id ?? this.id,
      universeId: universeId ?? this.universeId,
      type: type ?? this.type,
      name: name ?? this.name,
      attributesJson: attributesJson ?? this.attributesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (universeId.present) {
      map['universe_id'] = Variable<int>(universeId.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($EntitiesTable.$convertertype.toSql(type.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (attributesJson.present) {
      map['attributes_json'] = Variable<String>(attributesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesCompanion(')
          ..write('id: $id, ')
          ..write('universeId: $universeId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('attributesJson: $attributesJson')
          ..write(')'))
        .toString();
  }
}

class $RelationshipsTable extends Relationships
    with TableInfo<$RelationshipsTable, EntityRelationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _targetIdMeta =
      const VerificationMeta('targetId');
  @override
  late final GeneratedColumn<int> targetId = GeneratedColumn<int>(
      'target_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [sourceId, targetId, type, metadata];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(Insertable<EntityRelationship> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(_targetIdMeta,
          targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta));
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sourceId, targetId};
  @override
  EntityRelationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntityRelationship(
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id'])!,
      targetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
    );
  }

  @override
  $RelationshipsTable createAlias(String alias) {
    return $RelationshipsTable(attachedDatabase, alias);
  }
}

class EntityRelationship extends DataClass
    implements Insertable<EntityRelationship> {
  final int sourceId;
  final int targetId;
  final String type;
  final String metadata;
  const EntityRelationship(
      {required this.sourceId,
      required this.targetId,
      required this.type,
      required this.metadata});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['source_id'] = Variable<int>(sourceId);
    map['target_id'] = Variable<int>(targetId);
    map['type'] = Variable<String>(type);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  RelationshipsCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsCompanion(
      sourceId: Value(sourceId),
      targetId: Value(targetId),
      type: Value(type),
      metadata: Value(metadata),
    );
  }

  factory EntityRelationship.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntityRelationship(
      sourceId: serializer.fromJson<int>(json['sourceId']),
      targetId: serializer.fromJson<int>(json['targetId']),
      type: serializer.fromJson<String>(json['type']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sourceId': serializer.toJson<int>(sourceId),
      'targetId': serializer.toJson<int>(targetId),
      'type': serializer.toJson<String>(type),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  EntityRelationship copyWith(
          {int? sourceId, int? targetId, String? type, String? metadata}) =>
      EntityRelationship(
        sourceId: sourceId ?? this.sourceId,
        targetId: targetId ?? this.targetId,
        type: type ?? this.type,
        metadata: metadata ?? this.metadata,
      );
  EntityRelationship copyWithCompanion(RelationshipsCompanion data) {
    return EntityRelationship(
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      type: data.type.present ? data.type.value : this.type,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntityRelationship(')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('type: $type, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sourceId, targetId, type, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntityRelationship &&
          other.sourceId == this.sourceId &&
          other.targetId == this.targetId &&
          other.type == this.type &&
          other.metadata == this.metadata);
}

class RelationshipsCompanion extends UpdateCompanion<EntityRelationship> {
  final Value<int> sourceId;
  final Value<int> targetId;
  final Value<String> type;
  final Value<String> metadata;
  final Value<int> rowid;
  const RelationshipsCompanion({
    this.sourceId = const Value.absent(),
    this.targetId = const Value.absent(),
    this.type = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipsCompanion.insert({
    required int sourceId,
    required int targetId,
    required String type,
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : sourceId = Value(sourceId),
        targetId = Value(targetId),
        type = Value(type);
  static Insertable<EntityRelationship> custom({
    Expression<int>? sourceId,
    Expression<int>? targetId,
    Expression<String>? type,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sourceId != null) 'source_id': sourceId,
      if (targetId != null) 'target_id': targetId,
      if (type != null) 'type': type,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipsCompanion copyWith(
      {Value<int>? sourceId,
      Value<int>? targetId,
      Value<String>? type,
      Value<String>? metadata,
      Value<int>? rowid}) {
    return RelationshipsCompanion(
      sourceId: sourceId ?? this.sourceId,
      targetId: targetId ?? this.targetId,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<int>(targetId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsCompanion(')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('type: $type, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScenesTable extends Scenes with TableInfo<$ScenesTable, Scene> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES books (id) ON DELETE CASCADE'));
  static const VerificationMeta _contentDeltaMeta =
      const VerificationMeta('contentDelta');
  @override
  late final GeneratedColumn<String> contentDelta = GeneratedColumn<String>(
      'content_delta', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _contentHtmlMeta =
      const VerificationMeta('contentHtml');
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
      'content_html', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, bookId, contentDelta, contentHtml];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scenes';
  @override
  VerificationContext validateIntegrity(Insertable<Scene> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('content_delta')) {
      context.handle(
          _contentDeltaMeta,
          contentDelta.isAcceptableOrUnknown(
              data['content_delta']!, _contentDeltaMeta));
    }
    if (data.containsKey('content_html')) {
      context.handle(
          _contentHtmlMeta,
          contentHtml.isAcceptableOrUnknown(
              data['content_html']!, _contentHtmlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scene map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scene(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      contentDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_delta'])!,
      contentHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_html'])!,
    );
  }

  @override
  $ScenesTable createAlias(String alias) {
    return $ScenesTable(attachedDatabase, alias);
  }
}

class Scene extends DataClass implements Insertable<Scene> {
  final int id;
  final int bookId;
  final String contentDelta;
  final String contentHtml;
  const Scene(
      {required this.id,
      required this.bookId,
      required this.contentDelta,
      required this.contentHtml});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['content_delta'] = Variable<String>(contentDelta);
    map['content_html'] = Variable<String>(contentHtml);
    return map;
  }

  ScenesCompanion toCompanion(bool nullToAbsent) {
    return ScenesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      contentDelta: Value(contentDelta),
      contentHtml: Value(contentHtml),
    );
  }

  factory Scene.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scene(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      contentDelta: serializer.fromJson<String>(json['contentDelta']),
      contentHtml: serializer.fromJson<String>(json['contentHtml']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'contentDelta': serializer.toJson<String>(contentDelta),
      'contentHtml': serializer.toJson<String>(contentHtml),
    };
  }

  Scene copyWith(
          {int? id, int? bookId, String? contentDelta, String? contentHtml}) =>
      Scene(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        contentDelta: contentDelta ?? this.contentDelta,
        contentHtml: contentHtml ?? this.contentHtml,
      );
  Scene copyWithCompanion(ScenesCompanion data) {
    return Scene(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      contentDelta: data.contentDelta.present
          ? data.contentDelta.value
          : this.contentDelta,
      contentHtml:
          data.contentHtml.present ? data.contentHtml.value : this.contentHtml,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Scene(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, contentDelta, contentHtml);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scene &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.contentDelta == this.contentDelta &&
          other.contentHtml == this.contentHtml);
}

class ScenesCompanion extends UpdateCompanion<Scene> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<String> contentDelta;
  final Value<String> contentHtml;
  const ScenesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
  });
  ScenesCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
  }) : bookId = Value(bookId);
  static Insertable<Scene> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<String>? contentDelta,
    Expression<String>? contentHtml,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (contentDelta != null) 'content_delta': contentDelta,
      if (contentHtml != null) 'content_html': contentHtml,
    });
  }

  ScenesCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<String>? contentDelta,
      Value<String>? contentHtml}) {
    return ScenesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      contentDelta: contentDelta ?? this.contentDelta,
      contentHtml: contentHtml ?? this.contentHtml,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (contentDelta.present) {
      map['content_delta'] = Variable<String>(contentDelta.value);
    }
    if (contentHtml.present) {
      map['content_html'] = Variable<String>(contentHtml.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES books (id) ON DELETE CASCADE'));
  static const VerificationMeta _chapterNumberMeta =
      const VerificationMeta('chapterNumber');
  @override
  late final GeneratedColumn<int> chapterNumber = GeneratedColumn<int>(
      'chapter_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentDeltaMeta =
      const VerificationMeta('contentDelta');
  @override
  late final GeneratedColumn<String> contentDelta = GeneratedColumn<String>(
      'content_delta', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentHtmlMeta =
      const VerificationMeta('contentHtml');
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
      'content_html', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wordCountMeta =
      const VerificationMeta('wordCount');
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
      'word_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        chapterNumber,
        title,
        contentDelta,
        contentHtml,
        wordCount,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(Insertable<Chapter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter_number')) {
      context.handle(
          _chapterNumberMeta,
          chapterNumber.isAcceptableOrUnknown(
              data['chapter_number']!, _chapterNumberMeta));
    } else if (isInserting) {
      context.missing(_chapterNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content_delta')) {
      context.handle(
          _contentDeltaMeta,
          contentDelta.isAcceptableOrUnknown(
              data['content_delta']!, _contentDeltaMeta));
    }
    if (data.containsKey('content_html')) {
      context.handle(
          _contentHtmlMeta,
          contentHtml.isAcceptableOrUnknown(
              data['content_html']!, _contentHtmlMeta));
    }
    if (data.containsKey('word_count')) {
      context.handle(_wordCountMeta,
          wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      chapterNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_number'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      contentDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_delta']),
      contentHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_html']),
      wordCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_count'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final int bookId;
  final int chapterNumber;
  final String? title;
  final String? contentDelta;
  final String? contentHtml;
  final int wordCount;

  /// Status: 'outline', 'draft', 'final'
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Chapter(
      {required this.id,
      required this.bookId,
      required this.chapterNumber,
      this.title,
      this.contentDelta,
      this.contentHtml,
      required this.wordCount,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter_number'] = Variable<int>(chapterNumber);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || contentDelta != null) {
      map['content_delta'] = Variable<String>(contentDelta);
    }
    if (!nullToAbsent || contentHtml != null) {
      map['content_html'] = Variable<String>(contentHtml);
    }
    map['word_count'] = Variable<int>(wordCount);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapterNumber: Value(chapterNumber),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      contentDelta: contentDelta == null && nullToAbsent
          ? const Value.absent()
          : Value(contentDelta),
      contentHtml: contentHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtml),
      wordCount: Value(wordCount),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Chapter.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapterNumber: serializer.fromJson<int>(json['chapterNumber']),
      title: serializer.fromJson<String?>(json['title']),
      contentDelta: serializer.fromJson<String?>(json['contentDelta']),
      contentHtml: serializer.fromJson<String?>(json['contentHtml']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapterNumber': serializer.toJson<int>(chapterNumber),
      'title': serializer.toJson<String?>(title),
      'contentDelta': serializer.toJson<String?>(contentDelta),
      'contentHtml': serializer.toJson<String?>(contentHtml),
      'wordCount': serializer.toJson<int>(wordCount),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Chapter copyWith(
          {int? id,
          int? bookId,
          int? chapterNumber,
          Value<String?> title = const Value.absent(),
          Value<String?> contentDelta = const Value.absent(),
          Value<String?> contentHtml = const Value.absent(),
          int? wordCount,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Chapter(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        title: title.present ? title.value : this.title,
        contentDelta:
            contentDelta.present ? contentDelta.value : this.contentDelta,
        contentHtml: contentHtml.present ? contentHtml.value : this.contentHtml,
        wordCount: wordCount ?? this.wordCount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapterNumber: data.chapterNumber.present
          ? data.chapterNumber.value
          : this.chapterNumber,
      title: data.title.present ? data.title.value : this.title,
      contentDelta: data.contentDelta.present
          ? data.contentDelta.value
          : this.contentDelta,
      contentHtml:
          data.contentHtml.present ? data.contentHtml.value : this.contentHtml,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('title: $title, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('wordCount: $wordCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, chapterNumber, title,
      contentDelta, contentHtml, wordCount, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapterNumber == this.chapterNumber &&
          other.title == this.title &&
          other.contentDelta == this.contentDelta &&
          other.contentHtml == this.contentHtml &&
          other.wordCount == this.wordCount &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapterNumber;
  final Value<String?> title;
  final Value<String?> contentDelta;
  final Value<String?> contentHtml;
  final Value<int> wordCount;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapterNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapterNumber,
    this.title = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : bookId = Value(bookId),
        chapterNumber = Value(chapterNumber);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapterNumber,
    Expression<String>? title,
    Expression<String>? contentDelta,
    Expression<String>? contentHtml,
    Expression<int>? wordCount,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapterNumber != null) 'chapter_number': chapterNumber,
      if (title != null) 'title': title,
      if (contentDelta != null) 'content_delta': contentDelta,
      if (contentHtml != null) 'content_html': contentHtml,
      if (wordCount != null) 'word_count': wordCount,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChaptersCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<int>? chapterNumber,
      Value<String?>? title,
      Value<String?>? contentDelta,
      Value<String?>? contentHtml,
      Value<int>? wordCount,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ChaptersCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      title: title ?? this.title,
      contentDelta: contentDelta ?? this.contentDelta,
      contentHtml: contentHtml ?? this.contentHtml,
      wordCount: wordCount ?? this.wordCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapterNumber.present) {
      map['chapter_number'] = Variable<int>(chapterNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentDelta.present) {
      map['content_delta'] = Variable<String>(contentDelta.value);
    }
    if (contentHtml.present) {
      map['content_html'] = Variable<String>(contentHtml.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('title: $title, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('wordCount: $wordCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ScenesV3Table extends ScenesV3
    with TableInfo<$ScenesV3Table, ScenesV3Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenesV3Table(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chapterIdMeta =
      const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
      'chapter_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chapters (id) ON DELETE CASCADE'));
  static const VerificationMeta _sceneNumberMeta =
      const VerificationMeta('sceneNumber');
  @override
  late final GeneratedColumn<int> sceneNumber = GeneratedColumn<int>(
      'scene_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentDeltaMeta =
      const VerificationMeta('contentDelta');
  @override
  late final GeneratedColumn<String> contentDelta = GeneratedColumn<String>(
      'content_delta', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentHtmlMeta =
      const VerificationMeta('contentHtml');
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
      'content_html', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _povCharacterIdMeta =
      const VerificationMeta('povCharacterId');
  @override
  late final GeneratedColumn<int> povCharacterId = GeneratedColumn<int>(
      'pov_character_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES entities (id)'));
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<int> locationId = GeneratedColumn<int>(
      'location_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES entities (id)'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _wordCountMeta =
      const VerificationMeta('wordCount');
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
      'word_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        chapterId,
        sceneNumber,
        title,
        contentDelta,
        contentHtml,
        povCharacterId,
        locationId,
        status,
        wordCount,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scenes_v3';
  @override
  VerificationContext validateIntegrity(Insertable<ScenesV3Data> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta,
          chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('scene_number')) {
      context.handle(
          _sceneNumberMeta,
          sceneNumber.isAcceptableOrUnknown(
              data['scene_number']!, _sceneNumberMeta));
    } else if (isInserting) {
      context.missing(_sceneNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content_delta')) {
      context.handle(
          _contentDeltaMeta,
          contentDelta.isAcceptableOrUnknown(
              data['content_delta']!, _contentDeltaMeta));
    }
    if (data.containsKey('content_html')) {
      context.handle(
          _contentHtmlMeta,
          contentHtml.isAcceptableOrUnknown(
              data['content_html']!, _contentHtmlMeta));
    }
    if (data.containsKey('pov_character_id')) {
      context.handle(
          _povCharacterIdMeta,
          povCharacterId.isAcceptableOrUnknown(
              data['pov_character_id']!, _povCharacterIdMeta));
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('word_count')) {
      context.handle(_wordCountMeta,
          wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScenesV3Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScenesV3Data(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chapterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_id'])!,
      sceneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scene_number'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      contentDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_delta']),
      contentHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_html']),
      povCharacterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pov_character_id']),
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}location_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      wordCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ScenesV3Table createAlias(String alias) {
    return $ScenesV3Table(attachedDatabase, alias);
  }
}

class ScenesV3Data extends DataClass implements Insertable<ScenesV3Data> {
  final int id;
  final int chapterId;
  final int sceneNumber;
  final String? title;
  final String? contentDelta;
  final String? contentHtml;
  final int? povCharacterId;
  final int? locationId;
  final String status;
  final int wordCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScenesV3Data(
      {required this.id,
      required this.chapterId,
      required this.sceneNumber,
      this.title,
      this.contentDelta,
      this.contentHtml,
      this.povCharacterId,
      this.locationId,
      required this.status,
      required this.wordCount,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chapter_id'] = Variable<int>(chapterId);
    map['scene_number'] = Variable<int>(sceneNumber);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || contentDelta != null) {
      map['content_delta'] = Variable<String>(contentDelta);
    }
    if (!nullToAbsent || contentHtml != null) {
      map['content_html'] = Variable<String>(contentHtml);
    }
    if (!nullToAbsent || povCharacterId != null) {
      map['pov_character_id'] = Variable<int>(povCharacterId);
    }
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<int>(locationId);
    }
    map['status'] = Variable<String>(status);
    map['word_count'] = Variable<int>(wordCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScenesV3Companion toCompanion(bool nullToAbsent) {
    return ScenesV3Companion(
      id: Value(id),
      chapterId: Value(chapterId),
      sceneNumber: Value(sceneNumber),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      contentDelta: contentDelta == null && nullToAbsent
          ? const Value.absent()
          : Value(contentDelta),
      contentHtml: contentHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtml),
      povCharacterId: povCharacterId == null && nullToAbsent
          ? const Value.absent()
          : Value(povCharacterId),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      status: Value(status),
      wordCount: Value(wordCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScenesV3Data.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScenesV3Data(
      id: serializer.fromJson<int>(json['id']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      sceneNumber: serializer.fromJson<int>(json['sceneNumber']),
      title: serializer.fromJson<String?>(json['title']),
      contentDelta: serializer.fromJson<String?>(json['contentDelta']),
      contentHtml: serializer.fromJson<String?>(json['contentHtml']),
      povCharacterId: serializer.fromJson<int?>(json['povCharacterId']),
      locationId: serializer.fromJson<int?>(json['locationId']),
      status: serializer.fromJson<String>(json['status']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chapterId': serializer.toJson<int>(chapterId),
      'sceneNumber': serializer.toJson<int>(sceneNumber),
      'title': serializer.toJson<String?>(title),
      'contentDelta': serializer.toJson<String?>(contentDelta),
      'contentHtml': serializer.toJson<String?>(contentHtml),
      'povCharacterId': serializer.toJson<int?>(povCharacterId),
      'locationId': serializer.toJson<int?>(locationId),
      'status': serializer.toJson<String>(status),
      'wordCount': serializer.toJson<int>(wordCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScenesV3Data copyWith(
          {int? id,
          int? chapterId,
          int? sceneNumber,
          Value<String?> title = const Value.absent(),
          Value<String?> contentDelta = const Value.absent(),
          Value<String?> contentHtml = const Value.absent(),
          Value<int?> povCharacterId = const Value.absent(),
          Value<int?> locationId = const Value.absent(),
          String? status,
          int? wordCount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ScenesV3Data(
        id: id ?? this.id,
        chapterId: chapterId ?? this.chapterId,
        sceneNumber: sceneNumber ?? this.sceneNumber,
        title: title.present ? title.value : this.title,
        contentDelta:
            contentDelta.present ? contentDelta.value : this.contentDelta,
        contentHtml: contentHtml.present ? contentHtml.value : this.contentHtml,
        povCharacterId:
            povCharacterId.present ? povCharacterId.value : this.povCharacterId,
        locationId: locationId.present ? locationId.value : this.locationId,
        status: status ?? this.status,
        wordCount: wordCount ?? this.wordCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ScenesV3Data copyWithCompanion(ScenesV3Companion data) {
    return ScenesV3Data(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      sceneNumber:
          data.sceneNumber.present ? data.sceneNumber.value : this.sceneNumber,
      title: data.title.present ? data.title.value : this.title,
      contentDelta: data.contentDelta.present
          ? data.contentDelta.value
          : this.contentDelta,
      contentHtml:
          data.contentHtml.present ? data.contentHtml.value : this.contentHtml,
      povCharacterId: data.povCharacterId.present
          ? data.povCharacterId.value
          : this.povCharacterId,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      status: data.status.present ? data.status.value : this.status,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScenesV3Data(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('sceneNumber: $sceneNumber, ')
          ..write('title: $title, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('povCharacterId: $povCharacterId, ')
          ..write('locationId: $locationId, ')
          ..write('status: $status, ')
          ..write('wordCount: $wordCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      chapterId,
      sceneNumber,
      title,
      contentDelta,
      contentHtml,
      povCharacterId,
      locationId,
      status,
      wordCount,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenesV3Data &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.sceneNumber == this.sceneNumber &&
          other.title == this.title &&
          other.contentDelta == this.contentDelta &&
          other.contentHtml == this.contentHtml &&
          other.povCharacterId == this.povCharacterId &&
          other.locationId == this.locationId &&
          other.status == this.status &&
          other.wordCount == this.wordCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScenesV3Companion extends UpdateCompanion<ScenesV3Data> {
  final Value<int> id;
  final Value<int> chapterId;
  final Value<int> sceneNumber;
  final Value<String?> title;
  final Value<String?> contentDelta;
  final Value<String?> contentHtml;
  final Value<int?> povCharacterId;
  final Value<int?> locationId;
  final Value<String> status;
  final Value<int> wordCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ScenesV3Companion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.sceneNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.povCharacterId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.status = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ScenesV3Companion.insert({
    this.id = const Value.absent(),
    required int chapterId,
    required int sceneNumber,
    this.title = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.povCharacterId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.status = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : chapterId = Value(chapterId),
        sceneNumber = Value(sceneNumber);
  static Insertable<ScenesV3Data> custom({
    Expression<int>? id,
    Expression<int>? chapterId,
    Expression<int>? sceneNumber,
    Expression<String>? title,
    Expression<String>? contentDelta,
    Expression<String>? contentHtml,
    Expression<int>? povCharacterId,
    Expression<int>? locationId,
    Expression<String>? status,
    Expression<int>? wordCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (sceneNumber != null) 'scene_number': sceneNumber,
      if (title != null) 'title': title,
      if (contentDelta != null) 'content_delta': contentDelta,
      if (contentHtml != null) 'content_html': contentHtml,
      if (povCharacterId != null) 'pov_character_id': povCharacterId,
      if (locationId != null) 'location_id': locationId,
      if (status != null) 'status': status,
      if (wordCount != null) 'word_count': wordCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ScenesV3Companion copyWith(
      {Value<int>? id,
      Value<int>? chapterId,
      Value<int>? sceneNumber,
      Value<String?>? title,
      Value<String?>? contentDelta,
      Value<String?>? contentHtml,
      Value<int?>? povCharacterId,
      Value<int?>? locationId,
      Value<String>? status,
      Value<int>? wordCount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ScenesV3Companion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      sceneNumber: sceneNumber ?? this.sceneNumber,
      title: title ?? this.title,
      contentDelta: contentDelta ?? this.contentDelta,
      contentHtml: contentHtml ?? this.contentHtml,
      povCharacterId: povCharacterId ?? this.povCharacterId,
      locationId: locationId ?? this.locationId,
      status: status ?? this.status,
      wordCount: wordCount ?? this.wordCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (sceneNumber.present) {
      map['scene_number'] = Variable<int>(sceneNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentDelta.present) {
      map['content_delta'] = Variable<String>(contentDelta.value);
    }
    if (contentHtml.present) {
      map['content_html'] = Variable<String>(contentHtml.value);
    }
    if (povCharacterId.present) {
      map['pov_character_id'] = Variable<int>(povCharacterId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<int>(locationId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenesV3Companion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('sceneNumber: $sceneNumber, ')
          ..write('title: $title, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('povCharacterId: $povCharacterId, ')
          ..write('locationId: $locationId, ')
          ..write('status: $status, ')
          ..write('wordCount: $wordCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SnapshotsTable extends Snapshots
    with TableInfo<$SnapshotsTable, Snapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chapterIdMeta =
      const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
      'chapter_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chapters (id) ON DELETE CASCADE'));
  static const VerificationMeta _sceneIdMeta =
      const VerificationMeta('sceneId');
  @override
  late final GeneratedColumn<int> sceneId = GeneratedColumn<int>(
      'scene_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES scenes_v3 (id) ON DELETE CASCADE'));
  static const VerificationMeta _snapshotNameMeta =
      const VerificationMeta('snapshotName');
  @override
  late final GeneratedColumn<String> snapshotName = GeneratedColumn<String>(
      'snapshot_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentDeltaMeta =
      const VerificationMeta('contentDelta');
  @override
  late final GeneratedColumn<String> contentDelta = GeneratedColumn<String>(
      'content_delta', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentHtmlMeta =
      const VerificationMeta('contentHtml');
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
      'content_html', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        chapterId,
        sceneId,
        snapshotName,
        contentDelta,
        contentHtml,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<Snapshot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta,
          chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('scene_id')) {
      context.handle(_sceneIdMeta,
          sceneId.isAcceptableOrUnknown(data['scene_id']!, _sceneIdMeta));
    }
    if (data.containsKey('snapshot_name')) {
      context.handle(
          _snapshotNameMeta,
          snapshotName.isAcceptableOrUnknown(
              data['snapshot_name']!, _snapshotNameMeta));
    } else if (isInserting) {
      context.missing(_snapshotNameMeta);
    }
    if (data.containsKey('content_delta')) {
      context.handle(
          _contentDeltaMeta,
          contentDelta.isAcceptableOrUnknown(
              data['content_delta']!, _contentDeltaMeta));
    } else if (isInserting) {
      context.missing(_contentDeltaMeta);
    }
    if (data.containsKey('content_html')) {
      context.handle(
          _contentHtmlMeta,
          contentHtml.isAcceptableOrUnknown(
              data['content_html']!, _contentHtmlMeta));
    } else if (isInserting) {
      context.missing(_contentHtmlMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Snapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Snapshot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chapterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_id'])!,
      sceneId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scene_id']),
      snapshotName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snapshot_name'])!,
      contentDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_delta'])!,
      contentHtml: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_html'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SnapshotsTable createAlias(String alias) {
    return $SnapshotsTable(attachedDatabase, alias);
  }
}

class Snapshot extends DataClass implements Insertable<Snapshot> {
  final int id;
  final int chapterId;
  final int? sceneId;
  final String snapshotName;
  final String contentDelta;
  final String contentHtml;
  final DateTime createdAt;
  const Snapshot(
      {required this.id,
      required this.chapterId,
      this.sceneId,
      required this.snapshotName,
      required this.contentDelta,
      required this.contentHtml,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chapter_id'] = Variable<int>(chapterId);
    if (!nullToAbsent || sceneId != null) {
      map['scene_id'] = Variable<int>(sceneId);
    }
    map['snapshot_name'] = Variable<String>(snapshotName);
    map['content_delta'] = Variable<String>(contentDelta);
    map['content_html'] = Variable<String>(contentHtml);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SnapshotsCompanion toCompanion(bool nullToAbsent) {
    return SnapshotsCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      sceneId: sceneId == null && nullToAbsent
          ? const Value.absent()
          : Value(sceneId),
      snapshotName: Value(snapshotName),
      contentDelta: Value(contentDelta),
      contentHtml: Value(contentHtml),
      createdAt: Value(createdAt),
    );
  }

  factory Snapshot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Snapshot(
      id: serializer.fromJson<int>(json['id']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      sceneId: serializer.fromJson<int?>(json['sceneId']),
      snapshotName: serializer.fromJson<String>(json['snapshotName']),
      contentDelta: serializer.fromJson<String>(json['contentDelta']),
      contentHtml: serializer.fromJson<String>(json['contentHtml']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chapterId': serializer.toJson<int>(chapterId),
      'sceneId': serializer.toJson<int?>(sceneId),
      'snapshotName': serializer.toJson<String>(snapshotName),
      'contentDelta': serializer.toJson<String>(contentDelta),
      'contentHtml': serializer.toJson<String>(contentHtml),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Snapshot copyWith(
          {int? id,
          int? chapterId,
          Value<int?> sceneId = const Value.absent(),
          String? snapshotName,
          String? contentDelta,
          String? contentHtml,
          DateTime? createdAt}) =>
      Snapshot(
        id: id ?? this.id,
        chapterId: chapterId ?? this.chapterId,
        sceneId: sceneId.present ? sceneId.value : this.sceneId,
        snapshotName: snapshotName ?? this.snapshotName,
        contentDelta: contentDelta ?? this.contentDelta,
        contentHtml: contentHtml ?? this.contentHtml,
        createdAt: createdAt ?? this.createdAt,
      );
  Snapshot copyWithCompanion(SnapshotsCompanion data) {
    return Snapshot(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      sceneId: data.sceneId.present ? data.sceneId.value : this.sceneId,
      snapshotName: data.snapshotName.present
          ? data.snapshotName.value
          : this.snapshotName,
      contentDelta: data.contentDelta.present
          ? data.contentDelta.value
          : this.contentDelta,
      contentHtml:
          data.contentHtml.present ? data.contentHtml.value : this.contentHtml,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Snapshot(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('sceneId: $sceneId, ')
          ..write('snapshotName: $snapshotName, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chapterId, sceneId, snapshotName,
      contentDelta, contentHtml, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Snapshot &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.sceneId == this.sceneId &&
          other.snapshotName == this.snapshotName &&
          other.contentDelta == this.contentDelta &&
          other.contentHtml == this.contentHtml &&
          other.createdAt == this.createdAt);
}

class SnapshotsCompanion extends UpdateCompanion<Snapshot> {
  final Value<int> id;
  final Value<int> chapterId;
  final Value<int?> sceneId;
  final Value<String> snapshotName;
  final Value<String> contentDelta;
  final Value<String> contentHtml;
  final Value<DateTime> createdAt;
  const SnapshotsCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.sceneId = const Value.absent(),
    this.snapshotName = const Value.absent(),
    this.contentDelta = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required int chapterId,
    this.sceneId = const Value.absent(),
    required String snapshotName,
    required String contentDelta,
    required String contentHtml,
    this.createdAt = const Value.absent(),
  })  : chapterId = Value(chapterId),
        snapshotName = Value(snapshotName),
        contentDelta = Value(contentDelta),
        contentHtml = Value(contentHtml);
  static Insertable<Snapshot> custom({
    Expression<int>? id,
    Expression<int>? chapterId,
    Expression<int>? sceneId,
    Expression<String>? snapshotName,
    Expression<String>? contentDelta,
    Expression<String>? contentHtml,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (sceneId != null) 'scene_id': sceneId,
      if (snapshotName != null) 'snapshot_name': snapshotName,
      if (contentDelta != null) 'content_delta': contentDelta,
      if (contentHtml != null) 'content_html': contentHtml,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SnapshotsCompanion copyWith(
      {Value<int>? id,
      Value<int>? chapterId,
      Value<int?>? sceneId,
      Value<String>? snapshotName,
      Value<String>? contentDelta,
      Value<String>? contentHtml,
      Value<DateTime>? createdAt}) {
    return SnapshotsCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      sceneId: sceneId ?? this.sceneId,
      snapshotName: snapshotName ?? this.snapshotName,
      contentDelta: contentDelta ?? this.contentDelta,
      contentHtml: contentHtml ?? this.contentHtml,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (sceneId.present) {
      map['scene_id'] = Variable<int>(sceneId.value);
    }
    if (snapshotName.present) {
      map['snapshot_name'] = Variable<String>(snapshotName.value);
    }
    if (contentDelta.present) {
      map['content_delta'] = Variable<String>(contentDelta.value);
    }
    if (contentHtml.present) {
      map['content_html'] = Variable<String>(contentHtml.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('sceneId: $sceneId, ')
          ..write('snapshotName: $snapshotName, ')
          ..write('contentDelta: $contentDelta, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WritingSessionsTable extends WritingSessions
    with TableInfo<$WritingSessionsTable, WritingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WritingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES books (id) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _wordsWrittenMeta =
      const VerificationMeta('wordsWritten');
  @override
  late final GeneratedColumn<int> wordsWritten = GeneratedColumn<int>(
      'words_written', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, date, wordsWritten, durationMinutes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'writing_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<WritingSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('words_written')) {
      context.handle(
          _wordsWrittenMeta,
          wordsWritten.isAcceptableOrUnknown(
              data['words_written']!, _wordsWrittenMeta));
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WritingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WritingSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      wordsWritten: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}words_written'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WritingSessionsTable createAlias(String alias) {
    return $WritingSessionsTable(attachedDatabase, alias);
  }
}

class WritingSession extends DataClass implements Insertable<WritingSession> {
  final int id;
  final int bookId;
  final DateTime date;
  final int wordsWritten;
  final int durationMinutes;
  final DateTime createdAt;
  const WritingSession(
      {required this.id,
      required this.bookId,
      required this.date,
      required this.wordsWritten,
      required this.durationMinutes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['date'] = Variable<DateTime>(date);
    map['words_written'] = Variable<int>(wordsWritten);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WritingSessionsCompanion toCompanion(bool nullToAbsent) {
    return WritingSessionsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      date: Value(date),
      wordsWritten: Value(wordsWritten),
      durationMinutes: Value(durationMinutes),
      createdAt: Value(createdAt),
    );
  }

  factory WritingSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WritingSession(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      date: serializer.fromJson<DateTime>(json['date']),
      wordsWritten: serializer.fromJson<int>(json['wordsWritten']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'date': serializer.toJson<DateTime>(date),
      'wordsWritten': serializer.toJson<int>(wordsWritten),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WritingSession copyWith(
          {int? id,
          int? bookId,
          DateTime? date,
          int? wordsWritten,
          int? durationMinutes,
          DateTime? createdAt}) =>
      WritingSession(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        date: date ?? this.date,
        wordsWritten: wordsWritten ?? this.wordsWritten,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        createdAt: createdAt ?? this.createdAt,
      );
  WritingSession copyWithCompanion(WritingSessionsCompanion data) {
    return WritingSession(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      date: data.date.present ? data.date.value : this.date,
      wordsWritten: data.wordsWritten.present
          ? data.wordsWritten.value
          : this.wordsWritten,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WritingSession(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('date: $date, ')
          ..write('wordsWritten: $wordsWritten, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, date, wordsWritten, durationMinutes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WritingSession &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.date == this.date &&
          other.wordsWritten == this.wordsWritten &&
          other.durationMinutes == this.durationMinutes &&
          other.createdAt == this.createdAt);
}

class WritingSessionsCompanion extends UpdateCompanion<WritingSession> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<DateTime> date;
  final Value<int> wordsWritten;
  final Value<int> durationMinutes;
  final Value<DateTime> createdAt;
  const WritingSessionsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.date = const Value.absent(),
    this.wordsWritten = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WritingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required DateTime date,
    this.wordsWritten = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : bookId = Value(bookId),
        date = Value(date);
  static Insertable<WritingSession> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<DateTime>? date,
    Expression<int>? wordsWritten,
    Expression<int>? durationMinutes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (date != null) 'date': date,
      if (wordsWritten != null) 'words_written': wordsWritten,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WritingSessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<DateTime>? date,
      Value<int>? wordsWritten,
      Value<int>? durationMinutes,
      Value<DateTime>? createdAt}) {
    return WritingSessionsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      date: date ?? this.date,
      wordsWritten: wordsWritten ?? this.wordsWritten,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (wordsWritten.present) {
      map['words_written'] = Variable<int>(wordsWritten.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WritingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('date: $date, ')
          ..write('wordsWritten: $wordsWritten, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AiConversationsTable extends AiConversations
    with TableInfo<$AiConversationsTable, AiConversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES books (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, title, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_conversations';
  @override
  VerificationContext validateIntegrity(Insertable<AiConversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiConversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiConversation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AiConversationsTable createAlias(String alias) {
    return $AiConversationsTable(attachedDatabase, alias);
  }
}

class AiConversation extends DataClass implements Insertable<AiConversation> {
  final int id;
  final int? bookId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AiConversation(
      {required this.id,
      this.bookId,
      required this.title,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || bookId != null) {
      map['book_id'] = Variable<int>(bookId);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AiConversationsCompanion toCompanion(bool nullToAbsent) {
    return AiConversationsCompanion(
      id: Value(id),
      bookId:
          bookId == null && nullToAbsent ? const Value.absent() : Value(bookId),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AiConversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiConversation(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int?>(json['bookId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int?>(bookId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AiConversation copyWith(
          {int? id,
          Value<int?> bookId = const Value.absent(),
          String? title,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      AiConversation(
        id: id ?? this.id,
        bookId: bookId.present ? bookId.value : this.bookId,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AiConversation copyWithCompanion(AiConversationsCompanion data) {
    return AiConversation(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiConversation(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiConversation &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AiConversationsCompanion extends UpdateCompanion<AiConversation> {
  final Value<int> id;
  final Value<int?> bookId;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AiConversationsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AiConversationsCompanion.insert({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    required String title,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<AiConversation> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AiConversationsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? bookId,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return AiConversationsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiConversationsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AiMessagesTable extends AiMessages
    with TableInfo<$AiMessagesTable, AiMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES ai_conversations (id) ON DELETE CASCADE'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, conversationId, role, content, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_messages';
  @override
  VerificationContext validateIntegrity(Insertable<AiMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      conversationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}conversation_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $AiMessagesTable createAlias(String alias) {
    return $AiMessagesTable(attachedDatabase, alias);
  }
}

class AiMessage extends DataClass implements Insertable<AiMessage> {
  final int id;
  final int conversationId;
  final String role;
  final String content;
  final DateTime timestamp;
  const AiMessage(
      {required this.id,
      required this.conversationId,
      required this.role,
      required this.content,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<int>(conversationId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  AiMessagesCompanion toCompanion(bool nullToAbsent) {
    return AiMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      content: Value(content),
      timestamp: Value(timestamp),
    );
  }

  factory AiMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiMessage(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<int>(conversationId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  AiMessage copyWith(
          {int? id,
          int? conversationId,
          String? role,
          String? content,
          DateTime? timestamp}) =>
      AiMessage(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        role: role ?? this.role,
        content: content ?? this.content,
        timestamp: timestamp ?? this.timestamp,
      );
  AiMessage copyWithCompanion(AiMessagesCompanion data) {
    return AiMessage(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiMessage(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conversationId, role, content, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiMessage &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.content == this.content &&
          other.timestamp == this.timestamp);
}

class AiMessagesCompanion extends UpdateCompanion<AiMessage> {
  final Value<int> id;
  final Value<int> conversationId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> timestamp;
  const AiMessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  AiMessagesCompanion.insert({
    this.id = const Value.absent(),
    required int conversationId,
    required String role,
    required String content,
    this.timestamp = const Value.absent(),
  })  : conversationId = Value(conversationId),
        role = Value(role),
        content = Value(content);
  static Insertable<AiMessage> custom({
    Expression<int>? id,
    Expression<int>? conversationId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  AiMessagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? conversationId,
      Value<String>? role,
      Value<String>? content,
      Value<DateTime>? timestamp}) {
    return AiMessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiMessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UniversesTable universes = $UniversesTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $EntitiesTable entities = $EntitiesTable(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $ScenesTable scenes = $ScenesTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $ScenesV3Table scenesV3 = $ScenesV3Table(this);
  late final $SnapshotsTable snapshots = $SnapshotsTable(this);
  late final $WritingSessionsTable writingSessions =
      $WritingSessionsTable(this);
  late final $AiConversationsTable aiConversations =
      $AiConversationsTable(this);
  late final $AiMessagesTable aiMessages = $AiMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        universes,
        books,
        entities,
        relationships,
        scenes,
        chapters,
        scenesV3,
        snapshots,
        writingSessions,
        aiConversations,
        aiMessages
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('universes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('books', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('universes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('entities', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('relationships', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('relationships', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('books',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('scenes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('books',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chapters', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chapters',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('scenes_v3', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chapters',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('snapshots', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('scenes_v3',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('snapshots', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('books',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('writing_sessions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('ai_conversations',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('ai_messages', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UniversesTableCreateCompanionBuilder = UniversesCompanion Function({
  Value<int> id,
  required String name,
  required DateTime lastAccessed,
});
typedef $$UniversesTableUpdateCompanionBuilder = UniversesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> lastAccessed,
});

final class $$UniversesTableReferences
    extends BaseReferences<_$AppDatabase, $UniversesTable, Universe> {
  $$UniversesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BooksTable, List<Book>> _booksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.books,
          aliasName:
              $_aliasNameGenerator(db.universes.id, db.books.universeId));

  $$BooksTableProcessedTableManager get booksRefs {
    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.universeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_booksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EntitiesTable, List<Entity>> _entitiesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.entities,
          aliasName:
              $_aliasNameGenerator(db.universes.id, db.entities.universeId));

  $$EntitiesTableProcessedTableManager get entitiesRefs {
    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.universeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UniversesTableFilterComposer
    extends Composer<_$AppDatabase, $UniversesTable> {
  $$UniversesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => ColumnFilters(column));

  Expression<bool> booksRefs(
      Expression<bool> Function($$BooksTableFilterComposer f) f) {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.universeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> entitiesRefs(
      Expression<bool> Function($$EntitiesTableFilterComposer f) f) {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.universeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UniversesTableOrderingComposer
    extends Composer<_$AppDatabase, $UniversesTable> {
  $$UniversesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed,
      builder: (column) => ColumnOrderings(column));
}

class $$UniversesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UniversesTable> {
  $$UniversesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => column);

  Expression<T> booksRefs<T extends Object>(
      Expression<T> Function($$BooksTableAnnotationComposer a) f) {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.universeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> entitiesRefs<T extends Object>(
      Expression<T> Function($$EntitiesTableAnnotationComposer a) f) {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.universeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UniversesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UniversesTable,
    Universe,
    $$UniversesTableFilterComposer,
    $$UniversesTableOrderingComposer,
    $$UniversesTableAnnotationComposer,
    $$UniversesTableCreateCompanionBuilder,
    $$UniversesTableUpdateCompanionBuilder,
    (Universe, $$UniversesTableReferences),
    Universe,
    PrefetchHooks Function({bool booksRefs, bool entitiesRefs})> {
  $$UniversesTableTableManager(_$AppDatabase db, $UniversesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UniversesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UniversesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UniversesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> lastAccessed = const Value.absent(),
          }) =>
              UniversesCompanion(
            id: id,
            name: name,
            lastAccessed: lastAccessed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required DateTime lastAccessed,
          }) =>
              UniversesCompanion.insert(
            id: id,
            name: name,
            lastAccessed: lastAccessed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UniversesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({booksRefs = false, entitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (booksRefs) db.books,
                if (entitiesRefs) db.entities
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (booksRefs)
                    await $_getPrefetchedData<Universe, $UniversesTable, Book>(
                        currentTable: table,
                        referencedTable:
                            $$UniversesTableReferences._booksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UniversesTableReferences(db, table, p0).booksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.universeId == item.id),
                        typedResults: items),
                  if (entitiesRefs)
                    await $_getPrefetchedData<Universe, $UniversesTable,
                            Entity>(
                        currentTable: table,
                        referencedTable:
                            $$UniversesTableReferences._entitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UniversesTableReferences(db, table, p0)
                                .entitiesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.universeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UniversesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UniversesTable,
    Universe,
    $$UniversesTableFilterComposer,
    $$UniversesTableOrderingComposer,
    $$UniversesTableAnnotationComposer,
    $$UniversesTableCreateCompanionBuilder,
    $$UniversesTableUpdateCompanionBuilder,
    (Universe, $$UniversesTableReferences),
    Universe,
    PrefetchHooks Function({bool booksRefs, bool entitiesRefs})>;
typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  required int universeId,
  required String title,
  Value<String?> coverImagePath,
  Value<String?> synopsis,
  Value<String> writingMode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  Value<int> universeId,
  Value<String> title,
  Value<String?> coverImagePath,
  Value<String?> synopsis,
  Value<String> writingMode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UniversesTable _universeIdTable(_$AppDatabase db) => db.universes
      .createAlias($_aliasNameGenerator(db.books.universeId, db.universes.id));

  $$UniversesTableProcessedTableManager get universeId {
    final $_column = $_itemColumn<int>('universe_id')!;

    final manager = $$UniversesTableTableManager($_db, $_db.universes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_universeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ScenesTable, List<Scene>> _scenesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.scenes,
          aliasName: $_aliasNameGenerator(db.books.id, db.scenes.bookId));

  $$ScenesTableProcessedTableManager get scenesRefs {
    final manager = $$ScenesTableTableManager($_db, $_db.scenes)
        .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scenesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ChaptersTable, List<Chapter>> _chaptersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.chapters,
          aliasName: $_aliasNameGenerator(db.books.id, db.chapters.bookId));

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager($_db, $_db.chapters)
        .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WritingSessionsTable, List<WritingSession>>
      _writingSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.writingSessions,
              aliasName:
                  $_aliasNameGenerator(db.books.id, db.writingSessions.bookId));

  $$WritingSessionsTableProcessedTableManager get writingSessionsRefs {
    final manager =
        $$WritingSessionsTableTableManager($_db, $_db.writingSessions)
            .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_writingSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AiConversationsTable, List<AiConversation>>
      _aiConversationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aiConversations,
              aliasName:
                  $_aliasNameGenerator(db.books.id, db.aiConversations.bookId));

  $$AiConversationsTableProcessedTableManager get aiConversationsRefs {
    final manager =
        $$AiConversationsTableTableManager($_db, $_db.aiConversations)
            .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_aiConversationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get synopsis => $composableBuilder(
      column: $table.synopsis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get writingMode => $composableBuilder(
      column: $table.writingMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UniversesTableFilterComposer get universeId {
    final $$UniversesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableFilterComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> scenesRefs(
      Expression<bool> Function($$ScenesTableFilterComposer f) f) {
    final $$ScenesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scenes,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesTableFilterComposer(
              $db: $db,
              $table: $db.scenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> chaptersRefs(
      Expression<bool> Function($$ChaptersTableFilterComposer f) f) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableFilterComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> writingSessionsRefs(
      Expression<bool> Function($$WritingSessionsTableFilterComposer f) f) {
    final $$WritingSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.writingSessions,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WritingSessionsTableFilterComposer(
              $db: $db,
              $table: $db.writingSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aiConversationsRefs(
      Expression<bool> Function($$AiConversationsTableFilterComposer f) f) {
    final $$AiConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiConversations,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiConversationsTableFilterComposer(
              $db: $db,
              $table: $db.aiConversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get synopsis => $composableBuilder(
      column: $table.synopsis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get writingMode => $composableBuilder(
      column: $table.writingMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UniversesTableOrderingComposer get universeId {
    final $$UniversesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableOrderingComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath, builder: (column) => column);

  GeneratedColumn<String> get synopsis =>
      $composableBuilder(column: $table.synopsis, builder: (column) => column);

  GeneratedColumn<String> get writingMode => $composableBuilder(
      column: $table.writingMode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UniversesTableAnnotationComposer get universeId {
    final $$UniversesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableAnnotationComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> scenesRefs<T extends Object>(
      Expression<T> Function($$ScenesTableAnnotationComposer a) f) {
    final $$ScenesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scenes,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesTableAnnotationComposer(
              $db: $db,
              $table: $db.scenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> chaptersRefs<T extends Object>(
      Expression<T> Function($$ChaptersTableAnnotationComposer a) f) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableAnnotationComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> writingSessionsRefs<T extends Object>(
      Expression<T> Function($$WritingSessionsTableAnnotationComposer a) f) {
    final $$WritingSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.writingSessions,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WritingSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.writingSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aiConversationsRefs<T extends Object>(
      Expression<T> Function($$AiConversationsTableAnnotationComposer a) f) {
    final $$AiConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiConversations,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.aiConversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function(
        {bool universeId,
        bool scenesRefs,
        bool chaptersRefs,
        bool writingSessionsRefs,
        bool aiConversationsRefs})> {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> universeId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> coverImagePath = const Value.absent(),
            Value<String?> synopsis = const Value.absent(),
            Value<String> writingMode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BooksCompanion(
            id: id,
            universeId: universeId,
            title: title,
            coverImagePath: coverImagePath,
            synopsis: synopsis,
            writingMode: writingMode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int universeId,
            required String title,
            Value<String?> coverImagePath = const Value.absent(),
            Value<String?> synopsis = const Value.absent(),
            Value<String> writingMode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BooksCompanion.insert(
            id: id,
            universeId: universeId,
            title: title,
            coverImagePath: coverImagePath,
            synopsis: synopsis,
            writingMode: writingMode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BooksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {universeId = false,
              scenesRefs = false,
              chaptersRefs = false,
              writingSessionsRefs = false,
              aiConversationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (scenesRefs) db.scenes,
                if (chaptersRefs) db.chapters,
                if (writingSessionsRefs) db.writingSessions,
                if (aiConversationsRefs) db.aiConversations
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (universeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.universeId,
                    referencedTable:
                        $$BooksTableReferences._universeIdTable(db),
                    referencedColumn:
                        $$BooksTableReferences._universeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scenesRefs)
                    await $_getPrefetchedData<Book, $BooksTable, Scene>(
                        currentTable: table,
                        referencedTable:
                            $$BooksTableReferences._scenesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0).scenesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items),
                  if (chaptersRefs)
                    await $_getPrefetchedData<Book, $BooksTable, Chapter>(
                        currentTable: table,
                        referencedTable:
                            $$BooksTableReferences._chaptersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0).chaptersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items),
                  if (writingSessionsRefs)
                    await $_getPrefetchedData<Book, $BooksTable,
                            WritingSession>(
                        currentTable: table,
                        referencedTable: $$BooksTableReferences
                            ._writingSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0)
                                .writingSessionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items),
                  if (aiConversationsRefs)
                    await $_getPrefetchedData<Book, $BooksTable,
                            AiConversation>(
                        currentTable: table,
                        referencedTable: $$BooksTableReferences
                            ._aiConversationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0)
                                .aiConversationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function(
        {bool universeId,
        bool scenesRefs,
        bool chaptersRefs,
        bool writingSessionsRefs,
        bool aiConversationsRefs})>;
typedef $$EntitiesTableCreateCompanionBuilder = EntitiesCompanion Function({
  Value<int> id,
  required int universeId,
  required EntityType type,
  required String name,
  Value<String> attributesJson,
});
typedef $$EntitiesTableUpdateCompanionBuilder = EntitiesCompanion Function({
  Value<int> id,
  Value<int> universeId,
  Value<EntityType> type,
  Value<String> name,
  Value<String> attributesJson,
});

final class $$EntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $EntitiesTable, Entity> {
  $$EntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UniversesTable _universeIdTable(_$AppDatabase db) =>
      db.universes.createAlias(
          $_aliasNameGenerator(db.entities.universeId, db.universes.id));

  $$UniversesTableProcessedTableManager get universeId {
    final $_column = $_itemColumn<int>('universe_id')!;

    final manager = $$UniversesTableTableManager($_db, $_db.universes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_universeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EntityType, EntityType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson,
      builder: (column) => ColumnFilters(column));

  $$UniversesTableFilterComposer get universeId {
    final $$UniversesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableFilterComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson,
      builder: (column) => ColumnOrderings(column));

  $$UniversesTableOrderingComposer get universeId {
    final $$UniversesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableOrderingComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EntityType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get attributesJson => $composableBuilder(
      column: $table.attributesJson, builder: (column) => column);

  $$UniversesTableAnnotationComposer get universeId {
    final $$UniversesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.universeId,
        referencedTable: $db.universes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UniversesTableAnnotationComposer(
              $db: $db,
              $table: $db.universes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntitiesTable,
    Entity,
    $$EntitiesTableFilterComposer,
    $$EntitiesTableOrderingComposer,
    $$EntitiesTableAnnotationComposer,
    $$EntitiesTableCreateCompanionBuilder,
    $$EntitiesTableUpdateCompanionBuilder,
    (Entity, $$EntitiesTableReferences),
    Entity,
    PrefetchHooks Function({bool universeId})> {
  $$EntitiesTableTableManager(_$AppDatabase db, $EntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> universeId = const Value.absent(),
            Value<EntityType> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> attributesJson = const Value.absent(),
          }) =>
              EntitiesCompanion(
            id: id,
            universeId: universeId,
            type: type,
            name: name,
            attributesJson: attributesJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int universeId,
            required EntityType type,
            required String name,
            Value<String> attributesJson = const Value.absent(),
          }) =>
              EntitiesCompanion.insert(
            id: id,
            universeId: universeId,
            type: type,
            name: name,
            attributesJson: attributesJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EntitiesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({universeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (universeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.universeId,
                    referencedTable:
                        $$EntitiesTableReferences._universeIdTable(db),
                    referencedColumn:
                        $$EntitiesTableReferences._universeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntitiesTable,
    Entity,
    $$EntitiesTableFilterComposer,
    $$EntitiesTableOrderingComposer,
    $$EntitiesTableAnnotationComposer,
    $$EntitiesTableCreateCompanionBuilder,
    $$EntitiesTableUpdateCompanionBuilder,
    (Entity, $$EntitiesTableReferences),
    Entity,
    PrefetchHooks Function({bool universeId})>;
typedef $$RelationshipsTableCreateCompanionBuilder = RelationshipsCompanion
    Function({
  required int sourceId,
  required int targetId,
  required String type,
  Value<String> metadata,
  Value<int> rowid,
});
typedef $$RelationshipsTableUpdateCompanionBuilder = RelationshipsCompanion
    Function({
  Value<int> sourceId,
  Value<int> targetId,
  Value<String> type,
  Value<String> metadata,
  Value<int> rowid,
});

final class $$RelationshipsTableReferences extends BaseReferences<_$AppDatabase,
    $RelationshipsTable, EntityRelationship> {
  $$RelationshipsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _sourceIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.relationships.sourceId, db.entities.id));

  $$EntitiesTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<int>('source_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _targetIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.relationships.targetId, db.entities.id));

  $$EntitiesTableProcessedTableManager get targetId {
    final $_column = $_itemColumn<int>('target_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RelationshipsTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  $$EntitiesTableFilterComposer get sourceId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get targetId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationshipsTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  $$EntitiesTableOrderingComposer get sourceId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get targetId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationshipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  $$EntitiesTableAnnotationComposer get sourceId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get targetId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationshipsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    EntityRelationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (EntityRelationship, $$RelationshipsTableReferences),
    EntityRelationship,
    PrefetchHooks Function({bool sourceId, bool targetId})> {
  $$RelationshipsTableTableManager(_$AppDatabase db, $RelationshipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> sourceId = const Value.absent(),
            Value<int> targetId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion(
            sourceId: sourceId,
            targetId: targetId,
            type: type,
            metadata: metadata,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int sourceId,
            required int targetId,
            required String type,
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion.insert(
            sourceId: sourceId,
            targetId: targetId,
            type: type,
            metadata: metadata,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RelationshipsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sourceId = false, targetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sourceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sourceId,
                    referencedTable:
                        $$RelationshipsTableReferences._sourceIdTable(db),
                    referencedColumn:
                        $$RelationshipsTableReferences._sourceIdTable(db).id,
                  ) as T;
                }
                if (targetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.targetId,
                    referencedTable:
                        $$RelationshipsTableReferences._targetIdTable(db),
                    referencedColumn:
                        $$RelationshipsTableReferences._targetIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RelationshipsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    EntityRelationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (EntityRelationship, $$RelationshipsTableReferences),
    EntityRelationship,
    PrefetchHooks Function({bool sourceId, bool targetId})>;
typedef $$ScenesTableCreateCompanionBuilder = ScenesCompanion Function({
  Value<int> id,
  required int bookId,
  Value<String> contentDelta,
  Value<String> contentHtml,
});
typedef $$ScenesTableUpdateCompanionBuilder = ScenesCompanion Function({
  Value<int> id,
  Value<int> bookId,
  Value<String> contentDelta,
  Value<String> contentHtml,
});

final class $$ScenesTableReferences
    extends BaseReferences<_$AppDatabase, $ScenesTable, Scene> {
  $$ScenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias($_aliasNameGenerator(db.scenes.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ScenesTableFilterComposer
    extends Composer<_$AppDatabase, $ScenesTable> {
  $$ScenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScenesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScenesTable> {
  $$ScenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScenesTable> {
  $$ScenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScenesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScenesTable,
    Scene,
    $$ScenesTableFilterComposer,
    $$ScenesTableOrderingComposer,
    $$ScenesTableAnnotationComposer,
    $$ScenesTableCreateCompanionBuilder,
    $$ScenesTableUpdateCompanionBuilder,
    (Scene, $$ScenesTableReferences),
    Scene,
    PrefetchHooks Function({bool bookId})> {
  $$ScenesTableTableManager(_$AppDatabase db, $ScenesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<String> contentDelta = const Value.absent(),
            Value<String> contentHtml = const Value.absent(),
          }) =>
              ScenesCompanion(
            id: id,
            bookId: bookId,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            Value<String> contentDelta = const Value.absent(),
            Value<String> contentHtml = const Value.absent(),
          }) =>
              ScenesCompanion.insert(
            id: id,
            bookId: bookId,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ScenesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable: $$ScenesTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$ScenesTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ScenesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScenesTable,
    Scene,
    $$ScenesTableFilterComposer,
    $$ScenesTableOrderingComposer,
    $$ScenesTableAnnotationComposer,
    $$ScenesTableCreateCompanionBuilder,
    $$ScenesTableUpdateCompanionBuilder,
    (Scene, $$ScenesTableReferences),
    Scene,
    PrefetchHooks Function({bool bookId})>;
typedef $$ChaptersTableCreateCompanionBuilder = ChaptersCompanion Function({
  Value<int> id,
  required int bookId,
  required int chapterNumber,
  Value<String?> title,
  Value<String?> contentDelta,
  Value<String?> contentHtml,
  Value<int> wordCount,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ChaptersTableUpdateCompanionBuilder = ChaptersCompanion Function({
  Value<int> id,
  Value<int> bookId,
  Value<int> chapterNumber,
  Value<String?> title,
  Value<String?> contentDelta,
  Value<String?> contentHtml,
  Value<int> wordCount,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books
      .createAlias($_aliasNameGenerator(db.chapters.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ScenesV3Table, List<ScenesV3Data>>
      _scenesV3RefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.scenesV3,
              aliasName:
                  $_aliasNameGenerator(db.chapters.id, db.scenesV3.chapterId));

  $$ScenesV3TableProcessedTableManager get scenesV3Refs {
    final manager = $$ScenesV3TableTableManager($_db, $_db.scenesV3)
        .filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scenesV3RefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SnapshotsTable, List<Snapshot>>
      _snapshotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.snapshots,
              aliasName:
                  $_aliasNameGenerator(db.chapters.id, db.snapshots.chapterId));

  $$SnapshotsTableProcessedTableManager get snapshotsRefs {
    final manager = $$SnapshotsTableTableManager($_db, $_db.snapshots)
        .filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_snapshotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> scenesV3Refs(
      Expression<bool> Function($$ScenesV3TableFilterComposer f) f) {
    final $$ScenesV3TableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scenesV3,
        getReferencedColumn: (t) => t.chapterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesV3TableFilterComposer(
              $db: $db,
              $table: $db.scenesV3,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> snapshotsRefs(
      Expression<bool> Function($$SnapshotsTableFilterComposer f) f) {
    final $$SnapshotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.snapshots,
        getReferencedColumn: (t) => t.chapterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SnapshotsTableFilterComposer(
              $db: $db,
              $table: $db.snapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => column);

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> scenesV3Refs<T extends Object>(
      Expression<T> Function($$ScenesV3TableAnnotationComposer a) f) {
    final $$ScenesV3TableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scenesV3,
        getReferencedColumn: (t) => t.chapterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesV3TableAnnotationComposer(
              $db: $db,
              $table: $db.scenesV3,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> snapshotsRefs<T extends Object>(
      Expression<T> Function($$SnapshotsTableAnnotationComposer a) f) {
    final $$SnapshotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.snapshots,
        getReferencedColumn: (t) => t.chapterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SnapshotsTableAnnotationComposer(
              $db: $db,
              $table: $db.snapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChaptersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChaptersTable,
    Chapter,
    $$ChaptersTableFilterComposer,
    $$ChaptersTableOrderingComposer,
    $$ChaptersTableAnnotationComposer,
    $$ChaptersTableCreateCompanionBuilder,
    $$ChaptersTableUpdateCompanionBuilder,
    (Chapter, $$ChaptersTableReferences),
    Chapter,
    PrefetchHooks Function(
        {bool bookId, bool scenesV3Refs, bool snapshotsRefs})> {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<int> chapterNumber = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> contentDelta = const Value.absent(),
            Value<String?> contentHtml = const Value.absent(),
            Value<int> wordCount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChaptersCompanion(
            id: id,
            bookId: bookId,
            chapterNumber: chapterNumber,
            title: title,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            wordCount: wordCount,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            required int chapterNumber,
            Value<String?> title = const Value.absent(),
            Value<String?> contentDelta = const Value.absent(),
            Value<String?> contentHtml = const Value.absent(),
            Value<int> wordCount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChaptersCompanion.insert(
            id: id,
            bookId: bookId,
            chapterNumber: chapterNumber,
            title: title,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            wordCount: wordCount,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ChaptersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {bookId = false, scenesV3Refs = false, snapshotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (scenesV3Refs) db.scenesV3,
                if (snapshotsRefs) db.snapshots
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable: $$ChaptersTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$ChaptersTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scenesV3Refs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable,
                            ScenesV3Data>(
                        currentTable: table,
                        referencedTable:
                            $$ChaptersTableReferences._scenesV3RefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChaptersTableReferences(db, table, p0)
                                .scenesV3Refs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chapterId == item.id),
                        typedResults: items),
                  if (snapshotsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable,
                            Snapshot>(
                        currentTable: table,
                        referencedTable:
                            $$ChaptersTableReferences._snapshotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChaptersTableReferences(db, table, p0)
                                .snapshotsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chapterId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChaptersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChaptersTable,
    Chapter,
    $$ChaptersTableFilterComposer,
    $$ChaptersTableOrderingComposer,
    $$ChaptersTableAnnotationComposer,
    $$ChaptersTableCreateCompanionBuilder,
    $$ChaptersTableUpdateCompanionBuilder,
    (Chapter, $$ChaptersTableReferences),
    Chapter,
    PrefetchHooks Function(
        {bool bookId, bool scenesV3Refs, bool snapshotsRefs})>;
typedef $$ScenesV3TableCreateCompanionBuilder = ScenesV3Companion Function({
  Value<int> id,
  required int chapterId,
  required int sceneNumber,
  Value<String?> title,
  Value<String?> contentDelta,
  Value<String?> contentHtml,
  Value<int?> povCharacterId,
  Value<int?> locationId,
  Value<String> status,
  Value<int> wordCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ScenesV3TableUpdateCompanionBuilder = ScenesV3Companion Function({
  Value<int> id,
  Value<int> chapterId,
  Value<int> sceneNumber,
  Value<String?> title,
  Value<String?> contentDelta,
  Value<String?> contentHtml,
  Value<int?> povCharacterId,
  Value<int?> locationId,
  Value<String> status,
  Value<int> wordCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ScenesV3TableReferences
    extends BaseReferences<_$AppDatabase, $ScenesV3Table, ScenesV3Data> {
  $$ScenesV3TableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) => db.chapters
      .createAlias($_aliasNameGenerator(db.scenesV3.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _povCharacterIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.scenesV3.povCharacterId, db.entities.id));

  $$EntitiesTableProcessedTableManager? get povCharacterId {
    final $_column = $_itemColumn<int>('pov_character_id');
    if ($_column == null) return null;
    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_povCharacterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _locationIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.scenesV3.locationId, db.entities.id));

  $$EntitiesTableProcessedTableManager? get locationId {
    final $_column = $_itemColumn<int>('location_id');
    if ($_column == null) return null;
    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SnapshotsTable, List<Snapshot>>
      _snapshotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.snapshots,
              aliasName:
                  $_aliasNameGenerator(db.scenesV3.id, db.snapshots.sceneId));

  $$SnapshotsTableProcessedTableManager get snapshotsRefs {
    final manager = $$SnapshotsTableTableManager($_db, $_db.snapshots)
        .filter((f) => f.sceneId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_snapshotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ScenesV3TableFilterComposer
    extends Composer<_$AppDatabase, $ScenesV3Table> {
  $$ScenesV3TableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sceneNumber => $composableBuilder(
      column: $table.sceneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableFilterComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get povCharacterId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.povCharacterId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get locationId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> snapshotsRefs(
      Expression<bool> Function($$SnapshotsTableFilterComposer f) f) {
    final $$SnapshotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.snapshots,
        getReferencedColumn: (t) => t.sceneId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SnapshotsTableFilterComposer(
              $db: $db,
              $table: $db.snapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ScenesV3TableOrderingComposer
    extends Composer<_$AppDatabase, $ScenesV3Table> {
  $$ScenesV3TableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sceneNumber => $composableBuilder(
      column: $table.sceneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableOrderingComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get povCharacterId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.povCharacterId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get locationId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScenesV3TableAnnotationComposer
    extends Composer<_$AppDatabase, $ScenesV3Table> {
  $$ScenesV3TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sceneNumber => $composableBuilder(
      column: $table.sceneNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableAnnotationComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get povCharacterId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.povCharacterId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get locationId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> snapshotsRefs<T extends Object>(
      Expression<T> Function($$SnapshotsTableAnnotationComposer a) f) {
    final $$SnapshotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.snapshots,
        getReferencedColumn: (t) => t.sceneId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SnapshotsTableAnnotationComposer(
              $db: $db,
              $table: $db.snapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ScenesV3TableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScenesV3Table,
    ScenesV3Data,
    $$ScenesV3TableFilterComposer,
    $$ScenesV3TableOrderingComposer,
    $$ScenesV3TableAnnotationComposer,
    $$ScenesV3TableCreateCompanionBuilder,
    $$ScenesV3TableUpdateCompanionBuilder,
    (ScenesV3Data, $$ScenesV3TableReferences),
    ScenesV3Data,
    PrefetchHooks Function(
        {bool chapterId,
        bool povCharacterId,
        bool locationId,
        bool snapshotsRefs})> {
  $$ScenesV3TableTableManager(_$AppDatabase db, $ScenesV3Table table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenesV3TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenesV3TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenesV3TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> chapterId = const Value.absent(),
            Value<int> sceneNumber = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> contentDelta = const Value.absent(),
            Value<String?> contentHtml = const Value.absent(),
            Value<int?> povCharacterId = const Value.absent(),
            Value<int?> locationId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> wordCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ScenesV3Companion(
            id: id,
            chapterId: chapterId,
            sceneNumber: sceneNumber,
            title: title,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            povCharacterId: povCharacterId,
            locationId: locationId,
            status: status,
            wordCount: wordCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int chapterId,
            required int sceneNumber,
            Value<String?> title = const Value.absent(),
            Value<String?> contentDelta = const Value.absent(),
            Value<String?> contentHtml = const Value.absent(),
            Value<int?> povCharacterId = const Value.absent(),
            Value<int?> locationId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> wordCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ScenesV3Companion.insert(
            id: id,
            chapterId: chapterId,
            sceneNumber: sceneNumber,
            title: title,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            povCharacterId: povCharacterId,
            locationId: locationId,
            status: status,
            wordCount: wordCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ScenesV3TableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {chapterId = false,
              povCharacterId = false,
              locationId = false,
              snapshotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (snapshotsRefs) db.snapshots],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (chapterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chapterId,
                    referencedTable:
                        $$ScenesV3TableReferences._chapterIdTable(db),
                    referencedColumn:
                        $$ScenesV3TableReferences._chapterIdTable(db).id,
                  ) as T;
                }
                if (povCharacterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.povCharacterId,
                    referencedTable:
                        $$ScenesV3TableReferences._povCharacterIdTable(db),
                    referencedColumn:
                        $$ScenesV3TableReferences._povCharacterIdTable(db).id,
                  ) as T;
                }
                if (locationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.locationId,
                    referencedTable:
                        $$ScenesV3TableReferences._locationIdTable(db),
                    referencedColumn:
                        $$ScenesV3TableReferences._locationIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (snapshotsRefs)
                    await $_getPrefetchedData<ScenesV3Data, $ScenesV3Table,
                            Snapshot>(
                        currentTable: table,
                        referencedTable:
                            $$ScenesV3TableReferences._snapshotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ScenesV3TableReferences(db, table, p0)
                                .snapshotsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.sceneId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ScenesV3TableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScenesV3Table,
    ScenesV3Data,
    $$ScenesV3TableFilterComposer,
    $$ScenesV3TableOrderingComposer,
    $$ScenesV3TableAnnotationComposer,
    $$ScenesV3TableCreateCompanionBuilder,
    $$ScenesV3TableUpdateCompanionBuilder,
    (ScenesV3Data, $$ScenesV3TableReferences),
    ScenesV3Data,
    PrefetchHooks Function(
        {bool chapterId,
        bool povCharacterId,
        bool locationId,
        bool snapshotsRefs})>;
typedef $$SnapshotsTableCreateCompanionBuilder = SnapshotsCompanion Function({
  Value<int> id,
  required int chapterId,
  Value<int?> sceneId,
  required String snapshotName,
  required String contentDelta,
  required String contentHtml,
  Value<DateTime> createdAt,
});
typedef $$SnapshotsTableUpdateCompanionBuilder = SnapshotsCompanion Function({
  Value<int> id,
  Value<int> chapterId,
  Value<int?> sceneId,
  Value<String> snapshotName,
  Value<String> contentDelta,
  Value<String> contentHtml,
  Value<DateTime> createdAt,
});

final class $$SnapshotsTableReferences
    extends BaseReferences<_$AppDatabase, $SnapshotsTable, Snapshot> {
  $$SnapshotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias(
          $_aliasNameGenerator(db.snapshots.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ScenesV3Table _sceneIdTable(_$AppDatabase db) => db.scenesV3
      .createAlias($_aliasNameGenerator(db.snapshots.sceneId, db.scenesV3.id));

  $$ScenesV3TableProcessedTableManager? get sceneId {
    final $_column = $_itemColumn<int>('scene_id');
    if ($_column == null) return null;
    final manager = $$ScenesV3TableTableManager($_db, $_db.scenesV3)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sceneIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableFilterComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ScenesV3TableFilterComposer get sceneId {
    final $$ScenesV3TableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sceneId,
        referencedTable: $db.scenesV3,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesV3TableFilterComposer(
              $db: $db,
              $table: $db.scenesV3,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableOrderingComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ScenesV3TableOrderingComposer get sceneId {
    final $$ScenesV3TableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sceneId,
        referencedTable: $db.scenesV3,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesV3TableOrderingComposer(
              $db: $db,
              $table: $db.scenesV3,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName, builder: (column) => column);

  GeneratedColumn<String> get contentDelta => $composableBuilder(
      column: $table.contentDelta, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
      column: $table.contentHtml, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chapterId,
        referencedTable: $db.chapters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChaptersTableAnnotationComposer(
              $db: $db,
              $table: $db.chapters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ScenesV3TableAnnotationComposer get sceneId {
    final $$ScenesV3TableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sceneId,
        referencedTable: $db.scenesV3,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScenesV3TableAnnotationComposer(
              $db: $db,
              $table: $db.scenesV3,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SnapshotsTable,
    Snapshot,
    $$SnapshotsTableFilterComposer,
    $$SnapshotsTableOrderingComposer,
    $$SnapshotsTableAnnotationComposer,
    $$SnapshotsTableCreateCompanionBuilder,
    $$SnapshotsTableUpdateCompanionBuilder,
    (Snapshot, $$SnapshotsTableReferences),
    Snapshot,
    PrefetchHooks Function({bool chapterId, bool sceneId})> {
  $$SnapshotsTableTableManager(_$AppDatabase db, $SnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> chapterId = const Value.absent(),
            Value<int?> sceneId = const Value.absent(),
            Value<String> snapshotName = const Value.absent(),
            Value<String> contentDelta = const Value.absent(),
            Value<String> contentHtml = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SnapshotsCompanion(
            id: id,
            chapterId: chapterId,
            sceneId: sceneId,
            snapshotName: snapshotName,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int chapterId,
            Value<int?> sceneId = const Value.absent(),
            required String snapshotName,
            required String contentDelta,
            required String contentHtml,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SnapshotsCompanion.insert(
            id: id,
            chapterId: chapterId,
            sceneId: sceneId,
            snapshotName: snapshotName,
            contentDelta: contentDelta,
            contentHtml: contentHtml,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SnapshotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({chapterId = false, sceneId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (chapterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chapterId,
                    referencedTable:
                        $$SnapshotsTableReferences._chapterIdTable(db),
                    referencedColumn:
                        $$SnapshotsTableReferences._chapterIdTable(db).id,
                  ) as T;
                }
                if (sceneId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sceneId,
                    referencedTable:
                        $$SnapshotsTableReferences._sceneIdTable(db),
                    referencedColumn:
                        $$SnapshotsTableReferences._sceneIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SnapshotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SnapshotsTable,
    Snapshot,
    $$SnapshotsTableFilterComposer,
    $$SnapshotsTableOrderingComposer,
    $$SnapshotsTableAnnotationComposer,
    $$SnapshotsTableCreateCompanionBuilder,
    $$SnapshotsTableUpdateCompanionBuilder,
    (Snapshot, $$SnapshotsTableReferences),
    Snapshot,
    PrefetchHooks Function({bool chapterId, bool sceneId})>;
typedef $$WritingSessionsTableCreateCompanionBuilder = WritingSessionsCompanion
    Function({
  Value<int> id,
  required int bookId,
  required DateTime date,
  Value<int> wordsWritten,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
});
typedef $$WritingSessionsTableUpdateCompanionBuilder = WritingSessionsCompanion
    Function({
  Value<int> id,
  Value<int> bookId,
  Value<DateTime> date,
  Value<int> wordsWritten,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
});

final class $$WritingSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $WritingSessionsTable, WritingSession> {
  $$WritingSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
      $_aliasNameGenerator(db.writingSessions.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WritingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WritingSessionsTable> {
  $$WritingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordsWritten => $composableBuilder(
      column: $table.wordsWritten, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WritingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WritingSessionsTable> {
  $$WritingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordsWritten => $composableBuilder(
      column: $table.wordsWritten,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WritingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WritingSessionsTable> {
  $$WritingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get wordsWritten => $composableBuilder(
      column: $table.wordsWritten, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WritingSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WritingSessionsTable,
    WritingSession,
    $$WritingSessionsTableFilterComposer,
    $$WritingSessionsTableOrderingComposer,
    $$WritingSessionsTableAnnotationComposer,
    $$WritingSessionsTableCreateCompanionBuilder,
    $$WritingSessionsTableUpdateCompanionBuilder,
    (WritingSession, $$WritingSessionsTableReferences),
    WritingSession,
    PrefetchHooks Function({bool bookId})> {
  $$WritingSessionsTableTableManager(
      _$AppDatabase db, $WritingSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WritingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WritingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WritingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> wordsWritten = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WritingSessionsCompanion(
            id: id,
            bookId: bookId,
            date: date,
            wordsWritten: wordsWritten,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            required DateTime date,
            Value<int> wordsWritten = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WritingSessionsCompanion.insert(
            id: id,
            bookId: bookId,
            date: date,
            wordsWritten: wordsWritten,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WritingSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$WritingSessionsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$WritingSessionsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WritingSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WritingSessionsTable,
    WritingSession,
    $$WritingSessionsTableFilterComposer,
    $$WritingSessionsTableOrderingComposer,
    $$WritingSessionsTableAnnotationComposer,
    $$WritingSessionsTableCreateCompanionBuilder,
    $$WritingSessionsTableUpdateCompanionBuilder,
    (WritingSession, $$WritingSessionsTableReferences),
    WritingSession,
    PrefetchHooks Function({bool bookId})>;
typedef $$AiConversationsTableCreateCompanionBuilder = AiConversationsCompanion
    Function({
  Value<int> id,
  Value<int?> bookId,
  required String title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$AiConversationsTableUpdateCompanionBuilder = AiConversationsCompanion
    Function({
  Value<int> id,
  Value<int?> bookId,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$AiConversationsTableReferences extends BaseReferences<
    _$AppDatabase, $AiConversationsTable, AiConversation> {
  $$AiConversationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
      $_aliasNameGenerator(db.aiConversations.bookId, db.books.id));

  $$BooksTableProcessedTableManager? get bookId {
    final $_column = $_itemColumn<int>('book_id');
    if ($_column == null) return null;
    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AiMessagesTable, List<AiMessage>>
      _aiMessagesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aiMessages,
              aliasName: $_aliasNameGenerator(
                  db.aiConversations.id, db.aiMessages.conversationId));

  $$AiMessagesTableProcessedTableManager get aiMessagesRefs {
    final manager = $$AiMessagesTableTableManager($_db, $_db.aiMessages)
        .filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiMessagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AiConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $AiConversationsTable> {
  $$AiConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> aiMessagesRefs(
      Expression<bool> Function($$AiMessagesTableFilterComposer f) f) {
    final $$AiMessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiMessages,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiMessagesTableFilterComposer(
              $db: $db,
              $table: $db.aiMessages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AiConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiConversationsTable> {
  $$AiConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiConversationsTable> {
  $$AiConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> aiMessagesRefs<T extends Object>(
      Expression<T> Function($$AiMessagesTableAnnotationComposer a) f) {
    final $$AiMessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiMessages,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiMessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.aiMessages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AiConversationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiConversationsTable,
    AiConversation,
    $$AiConversationsTableFilterComposer,
    $$AiConversationsTableOrderingComposer,
    $$AiConversationsTableAnnotationComposer,
    $$AiConversationsTableCreateCompanionBuilder,
    $$AiConversationsTableUpdateCompanionBuilder,
    (AiConversation, $$AiConversationsTableReferences),
    AiConversation,
    PrefetchHooks Function({bool bookId, bool aiMessagesRefs})> {
  $$AiConversationsTableTableManager(
      _$AppDatabase db, $AiConversationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> bookId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiConversationsCompanion(
            id: id,
            bookId: bookId,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> bookId = const Value.absent(),
            required String title,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiConversationsCompanion.insert(
            id: id,
            bookId: bookId,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AiConversationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false, aiMessagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (aiMessagesRefs) db.aiMessages],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$AiConversationsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$AiConversationsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aiMessagesRefs)
                    await $_getPrefetchedData<AiConversation,
                            $AiConversationsTable, AiMessage>(
                        currentTable: table,
                        referencedTable: $$AiConversationsTableReferences
                            ._aiMessagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AiConversationsTableReferences(db, table, p0)
                                .aiMessagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.conversationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AiConversationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AiConversationsTable,
    AiConversation,
    $$AiConversationsTableFilterComposer,
    $$AiConversationsTableOrderingComposer,
    $$AiConversationsTableAnnotationComposer,
    $$AiConversationsTableCreateCompanionBuilder,
    $$AiConversationsTableUpdateCompanionBuilder,
    (AiConversation, $$AiConversationsTableReferences),
    AiConversation,
    PrefetchHooks Function({bool bookId, bool aiMessagesRefs})>;
typedef $$AiMessagesTableCreateCompanionBuilder = AiMessagesCompanion Function({
  Value<int> id,
  required int conversationId,
  required String role,
  required String content,
  Value<DateTime> timestamp,
});
typedef $$AiMessagesTableUpdateCompanionBuilder = AiMessagesCompanion Function({
  Value<int> id,
  Value<int> conversationId,
  Value<String> role,
  Value<String> content,
  Value<DateTime> timestamp,
});

final class $$AiMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $AiMessagesTable, AiMessage> {
  $$AiMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AiConversationsTable _conversationIdTable(_$AppDatabase db) =>
      db.aiConversations.createAlias($_aliasNameGenerator(
          db.aiMessages.conversationId, db.aiConversations.id));

  $$AiConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager =
        $$AiConversationsTableTableManager($_db, $_db.aiConversations)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AiMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  $$AiConversationsTableFilterComposer get conversationId {
    final $$AiConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.aiConversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiConversationsTableFilterComposer(
              $db: $db,
              $table: $db.aiConversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  $$AiConversationsTableOrderingComposer get conversationId {
    final $$AiConversationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.aiConversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiConversationsTableOrderingComposer(
              $db: $db,
              $table: $db.aiConversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$AiConversationsTableAnnotationComposer get conversationId {
    final $$AiConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.aiConversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.aiConversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiMessagesTable,
    AiMessage,
    $$AiMessagesTableFilterComposer,
    $$AiMessagesTableOrderingComposer,
    $$AiMessagesTableAnnotationComposer,
    $$AiMessagesTableCreateCompanionBuilder,
    $$AiMessagesTableUpdateCompanionBuilder,
    (AiMessage, $$AiMessagesTableReferences),
    AiMessage,
    PrefetchHooks Function({bool conversationId})> {
  $$AiMessagesTableTableManager(_$AppDatabase db, $AiMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> conversationId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              AiMessagesCompanion(
            id: id,
            conversationId: conversationId,
            role: role,
            content: content,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int conversationId,
            required String role,
            required String content,
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              AiMessagesCompanion.insert(
            id: id,
            conversationId: conversationId,
            role: role,
            content: content,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AiMessagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (conversationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.conversationId,
                    referencedTable:
                        $$AiMessagesTableReferences._conversationIdTable(db),
                    referencedColumn:
                        $$AiMessagesTableReferences._conversationIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AiMessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AiMessagesTable,
    AiMessage,
    $$AiMessagesTableFilterComposer,
    $$AiMessagesTableOrderingComposer,
    $$AiMessagesTableAnnotationComposer,
    $$AiMessagesTableCreateCompanionBuilder,
    $$AiMessagesTableUpdateCompanionBuilder,
    (AiMessage, $$AiMessagesTableReferences),
    AiMessage,
    PrefetchHooks Function({bool conversationId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UniversesTableTableManager get universes =>
      $$UniversesTableTableManager(_db, _db.universes);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$EntitiesTableTableManager get entities =>
      $$EntitiesTableTableManager(_db, _db.entities);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$ScenesTableTableManager get scenes =>
      $$ScenesTableTableManager(_db, _db.scenes);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$ScenesV3TableTableManager get scenesV3 =>
      $$ScenesV3TableTableManager(_db, _db.scenesV3);
  $$SnapshotsTableTableManager get snapshots =>
      $$SnapshotsTableTableManager(_db, _db.snapshots);
  $$WritingSessionsTableTableManager get writingSessions =>
      $$WritingSessionsTableTableManager(_db, _db.writingSessions);
  $$AiConversationsTableTableManager get aiConversations =>
      $$AiConversationsTableTableManager(_db, _db.aiConversations);
  $$AiMessagesTableTableManager get aiMessages =>
      $$AiMessagesTableTableManager(_db, _db.aiMessages);
}
