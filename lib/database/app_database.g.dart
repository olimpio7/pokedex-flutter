// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pokemonId,
    name,
    image,
    comment,
    rating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int pokemonId;
  final String name;
  final String image;
  final String? comment;
  final int? rating;
  const Favorite({
    required this.pokemonId,
    required this.name,
    required this.image,
    this.comment,
    this.rating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      pokemonId: Value(pokemonId),
      name: Value(name),
      image: Value(image),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      comment: serializer.fromJson<String?>(json['comment']),
      rating: serializer.fromJson<int?>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'comment': serializer.toJson<String?>(comment),
      'rating': serializer.toJson<int?>(rating),
    };
  }

  Favorite copyWith({
    int? pokemonId,
    String? name,
    String? image,
    Value<String?> comment = const Value.absent(),
    Value<int?> rating = const Value.absent(),
  }) => Favorite(
    pokemonId: pokemonId ?? this.pokemonId,
    name: name ?? this.name,
    image: image ?? this.image,
    comment: comment.present ? comment.value : this.comment,
    rating: rating.present ? rating.value : this.rating,
  );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      comment: data.comment.present ? data.comment.value : this.comment,
      rating: data.rating.present ? data.rating.value : this.rating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('comment: $comment, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, name, image, comment, rating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.pokemonId == this.pokemonId &&
          other.name == this.name &&
          other.image == this.image &&
          other.comment == this.comment &&
          other.rating == this.rating);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> pokemonId;
  final Value<String> name;
  final Value<String> image;
  final Value<String?> comment;
  final Value<int?> rating;
  const FavoritesCompanion({
    this.pokemonId = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.comment = const Value.absent(),
    this.rating = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.pokemonId = const Value.absent(),
    required String name,
    required String image,
    this.comment = const Value.absent(),
    this.rating = const Value.absent(),
  }) : name = Value(name),
       image = Value(image);
  static Insertable<Favorite> custom({
    Expression<int>? pokemonId,
    Expression<String>? name,
    Expression<String>? image,
    Expression<String>? comment,
    Expression<int>? rating,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (comment != null) 'comment': comment,
      if (rating != null) 'rating': rating,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? pokemonId,
    Value<String>? name,
    Value<String>? image,
    Value<String?>? comment,
    Value<int?>? rating,
  }) {
    return FavoritesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      name: name ?? this.name,
      image: image ?? this.image,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('comment: $comment, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }
}

class $TrainersTable extends Trainers with TableInfo<$TrainersTable, Trainer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trainerIdMeta = const VerificationMeta(
    'trainerId',
  );
  @override
  late final GeneratedColumn<int> trainerId = GeneratedColumn<int>(
    'trainer_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [trainerId, name, city, avatar];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trainers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trainer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('trainer_id')) {
      context.handle(
        _trainerIdMeta,
        trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trainerId};
  @override
  Trainer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trainer(
      trainerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trainer_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      )!,
    );
  }

  @override
  $TrainersTable createAlias(String alias) {
    return $TrainersTable(attachedDatabase, alias);
  }
}

class Trainer extends DataClass implements Insertable<Trainer> {
  final int trainerId;
  final String name;
  final String city;
  final String avatar;
  const Trainer({
    required this.trainerId,
    required this.name,
    required this.city,
    required this.avatar,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['trainer_id'] = Variable<int>(trainerId);
    map['name'] = Variable<String>(name);
    map['city'] = Variable<String>(city);
    map['avatar'] = Variable<String>(avatar);
    return map;
  }

  TrainersCompanion toCompanion(bool nullToAbsent) {
    return TrainersCompanion(
      trainerId: Value(trainerId),
      name: Value(name),
      city: Value(city),
      avatar: Value(avatar),
    );
  }

  factory Trainer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trainer(
      trainerId: serializer.fromJson<int>(json['trainerId']),
      name: serializer.fromJson<String>(json['name']),
      city: serializer.fromJson<String>(json['city']),
      avatar: serializer.fromJson<String>(json['avatar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trainerId': serializer.toJson<int>(trainerId),
      'name': serializer.toJson<String>(name),
      'city': serializer.toJson<String>(city),
      'avatar': serializer.toJson<String>(avatar),
    };
  }

  Trainer copyWith({
    int? trainerId,
    String? name,
    String? city,
    String? avatar,
  }) => Trainer(
    trainerId: trainerId ?? this.trainerId,
    name: name ?? this.name,
    city: city ?? this.city,
    avatar: avatar ?? this.avatar,
  );
  Trainer copyWithCompanion(TrainersCompanion data) {
    return Trainer(
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      name: data.name.present ? data.name.value : this.name,
      city: data.city.present ? data.city.value : this.city,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trainer(')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trainerId, name, city, avatar);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trainer &&
          other.trainerId == this.trainerId &&
          other.name == this.name &&
          other.city == this.city &&
          other.avatar == this.avatar);
}

class TrainersCompanion extends UpdateCompanion<Trainer> {
  final Value<int> trainerId;
  final Value<String> name;
  final Value<String> city;
  final Value<String> avatar;
  const TrainersCompanion({
    this.trainerId = const Value.absent(),
    this.name = const Value.absent(),
    this.city = const Value.absent(),
    this.avatar = const Value.absent(),
  });
  TrainersCompanion.insert({
    this.trainerId = const Value.absent(),
    required String name,
    required String city,
    required String avatar,
  }) : name = Value(name),
       city = Value(city),
       avatar = Value(avatar);
  static Insertable<Trainer> custom({
    Expression<int>? trainerId,
    Expression<String>? name,
    Expression<String>? city,
    Expression<String>? avatar,
  }) {
    return RawValuesInsertable({
      if (trainerId != null) 'trainer_id': trainerId,
      if (name != null) 'name': name,
      if (city != null) 'city': city,
      if (avatar != null) 'avatar': avatar,
    });
  }

  TrainersCompanion copyWith({
    Value<int>? trainerId,
    Value<String>? name,
    Value<String>? city,
    Value<String>? avatar,
  }) {
    return TrainersCompanion(
      trainerId: trainerId ?? this.trainerId,
      name: name ?? this.name,
      city: city ?? this.city,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trainerId.present) {
      map['trainer_id'] = Variable<int>(trainerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainersCompanion(')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [teamId, name, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Team> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final int teamId;
  final String name;
  final String description;
  final DateTime createdAt;
  const Team({
    required this.teamId,
    required this.name,
    required this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<int>(teamId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      teamId: Value(teamId),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Team.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      teamId: serializer.fromJson<int>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<int>(teamId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Team copyWith({
    int? teamId,
    String? name,
    String? description,
    DateTime? createdAt,
  }) => Team(
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teamId, name, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> teamId;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  const TeamsCompanion({
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.teamId = const Value.absent(),
    required String name,
    required String description,
    required DateTime createdAt,
  }) : name = Value(name),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<Team> custom({
    Expression<int>? teamId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TeamsCompanion copyWith({
    Value<int>? teamId,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? createdAt,
  }) {
    return TeamsCompanion(
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TeamPokemonsTable extends TeamPokemons
    with TableInfo<$TeamPokemonsTable, TeamPokemon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamPokemonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [teamId, pokemonId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_pokemons';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamPokemon> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, pokemonId};
  @override
  TeamPokemon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamPokemon(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
    );
  }

  @override
  $TeamPokemonsTable createAlias(String alias) {
    return $TeamPokemonsTable(attachedDatabase, alias);
  }
}

class TeamPokemon extends DataClass implements Insertable<TeamPokemon> {
  final int teamId;
  final int pokemonId;
  const TeamPokemon({required this.teamId, required this.pokemonId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<int>(teamId);
    map['pokemon_id'] = Variable<int>(pokemonId);
    return map;
  }

  TeamPokemonsCompanion toCompanion(bool nullToAbsent) {
    return TeamPokemonsCompanion(
      teamId: Value(teamId),
      pokemonId: Value(pokemonId),
    );
  }

  factory TeamPokemon.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPokemon(
      teamId: serializer.fromJson<int>(json['teamId']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<int>(teamId),
      'pokemonId': serializer.toJson<int>(pokemonId),
    };
  }

  TeamPokemon copyWith({int? teamId, int? pokemonId}) => TeamPokemon(
    teamId: teamId ?? this.teamId,
    pokemonId: pokemonId ?? this.pokemonId,
  );
  TeamPokemon copyWithCompanion(TeamPokemonsCompanion data) {
    return TeamPokemon(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPokemon(')
          ..write('teamId: $teamId, ')
          ..write('pokemonId: $pokemonId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teamId, pokemonId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPokemon &&
          other.teamId == this.teamId &&
          other.pokemonId == this.pokemonId);
}

class TeamPokemonsCompanion extends UpdateCompanion<TeamPokemon> {
  final Value<int> teamId;
  final Value<int> pokemonId;
  final Value<int> rowid;
  const TeamPokemonsCompanion({
    this.teamId = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamPokemonsCompanion.insert({
    required int teamId,
    required int pokemonId,
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       pokemonId = Value(pokemonId);
  static Insertable<TeamPokemon> custom({
    Expression<int>? teamId,
    Expression<int>? pokemonId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamPokemonsCompanion copyWith({
    Value<int>? teamId,
    Value<int>? pokemonId,
    Value<int>? rowid,
  }) {
    return TeamPokemonsCompanion(
      teamId: teamId ?? this.teamId,
      pokemonId: pokemonId ?? this.pokemonId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPokemonsCompanion(')
          ..write('teamId: $teamId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $TrainersTable trainers = $TrainersTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $TeamPokemonsTable teamPokemons = $TeamPokemonsTable(this);
  late final FavoriteDao favoriteDao = FavoriteDao(this as AppDatabase);
  late final TrainerDao trainerDao = TrainerDao(this as AppDatabase);
  late final TeamDao teamDao = TeamDao(this as AppDatabase);
  late final TeamPokemonDao teamPokemonDao = TeamPokemonDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favorites,
    trainers,
    teams,
    teamPokemons,
  ];
}

typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      Value<int> pokemonId,
      required String name,
      required String image,
      Value<String?> comment,
      Value<int?> rating,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<int> pokemonId,
      Value<String> name,
      Value<String> image,
      Value<String?> comment,
      Value<int?> rating,
    });

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<int?> rating = const Value.absent(),
              }) => FavoritesCompanion(
                pokemonId: pokemonId,
                name: name,
                image: image,
                comment: comment,
                rating: rating,
              ),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                required String name,
                required String image,
                Value<String?> comment = const Value.absent(),
                Value<int?> rating = const Value.absent(),
              }) => FavoritesCompanion.insert(
                pokemonId: pokemonId,
                name: name,
                image: image,
                comment: comment,
                rating: rating,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;
typedef $$TrainersTableCreateCompanionBuilder =
    TrainersCompanion Function({
      Value<int> trainerId,
      required String name,
      required String city,
      required String avatar,
    });
typedef $$TrainersTableUpdateCompanionBuilder =
    TrainersCompanion Function({
      Value<int> trainerId,
      Value<String> name,
      Value<String> city,
      Value<String> avatar,
    });

class $$TrainersTableFilterComposer
    extends Composer<_$AppDatabase, $TrainersTable> {
  $$TrainersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get trainerId => $composableBuilder(
    column: $table.trainerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrainersTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainersTable> {
  $$TrainersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get trainerId => $composableBuilder(
    column: $table.trainerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrainersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainersTable> {
  $$TrainersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get trainerId =>
      $composableBuilder(column: $table.trainerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);
}

class $$TrainersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainersTable,
          Trainer,
          $$TrainersTableFilterComposer,
          $$TrainersTableOrderingComposer,
          $$TrainersTableAnnotationComposer,
          $$TrainersTableCreateCompanionBuilder,
          $$TrainersTableUpdateCompanionBuilder,
          (Trainer, BaseReferences<_$AppDatabase, $TrainersTable, Trainer>),
          Trainer,
          PrefetchHooks Function()
        > {
  $$TrainersTableTableManager(_$AppDatabase db, $TrainersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trainerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> avatar = const Value.absent(),
              }) => TrainersCompanion(
                trainerId: trainerId,
                name: name,
                city: city,
                avatar: avatar,
              ),
          createCompanionCallback:
              ({
                Value<int> trainerId = const Value.absent(),
                required String name,
                required String city,
                required String avatar,
              }) => TrainersCompanion.insert(
                trainerId: trainerId,
                name: name,
                city: city,
                avatar: avatar,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrainersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainersTable,
      Trainer,
      $$TrainersTableFilterComposer,
      $$TrainersTableOrderingComposer,
      $$TrainersTableAnnotationComposer,
      $$TrainersTableCreateCompanionBuilder,
      $$TrainersTableUpdateCompanionBuilder,
      (Trainer, BaseReferences<_$AppDatabase, $TrainersTable, Trainer>),
      Trainer,
      PrefetchHooks Function()
    >;
typedef $$TeamsTableCreateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> teamId,
      required String name,
      required String description,
      required DateTime createdAt,
    });
typedef $$TeamsTableUpdateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> teamId,
      Value<String> name,
      Value<String> description,
      Value<DateTime> createdAt,
    });

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamsTable,
          Team,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (Team, BaseReferences<_$AppDatabase, $TeamsTable, Team>),
          Team,
          PrefetchHooks Function()
        > {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> teamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TeamsCompanion(
                teamId: teamId,
                name: name,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> teamId = const Value.absent(),
                required String name,
                required String description,
                required DateTime createdAt,
              }) => TeamsCompanion.insert(
                teamId: teamId,
                name: name,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamsTable,
      Team,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (Team, BaseReferences<_$AppDatabase, $TeamsTable, Team>),
      Team,
      PrefetchHooks Function()
    >;
typedef $$TeamPokemonsTableCreateCompanionBuilder =
    TeamPokemonsCompanion Function({
      required int teamId,
      required int pokemonId,
      Value<int> rowid,
    });
typedef $$TeamPokemonsTableUpdateCompanionBuilder =
    TeamPokemonsCompanion Function({
      Value<int> teamId,
      Value<int> pokemonId,
      Value<int> rowid,
    });

class $$TeamPokemonsTableFilterComposer
    extends Composer<_$AppDatabase, $TeamPokemonsTable> {
  $$TeamPokemonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamPokemonsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamPokemonsTable> {
  $$TeamPokemonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamPokemonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamPokemonsTable> {
  $$TeamPokemonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);
}

class $$TeamPokemonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamPokemonsTable,
          TeamPokemon,
          $$TeamPokemonsTableFilterComposer,
          $$TeamPokemonsTableOrderingComposer,
          $$TeamPokemonsTableAnnotationComposer,
          $$TeamPokemonsTableCreateCompanionBuilder,
          $$TeamPokemonsTableUpdateCompanionBuilder,
          (
            TeamPokemon,
            BaseReferences<_$AppDatabase, $TeamPokemonsTable, TeamPokemon>,
          ),
          TeamPokemon,
          PrefetchHooks Function()
        > {
  $$TeamPokemonsTableTableManager(_$AppDatabase db, $TeamPokemonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamPokemonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamPokemonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamPokemonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> teamId = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamPokemonsCompanion(
                teamId: teamId,
                pokemonId: pokemonId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int teamId,
                required int pokemonId,
                Value<int> rowid = const Value.absent(),
              }) => TeamPokemonsCompanion.insert(
                teamId: teamId,
                pokemonId: pokemonId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamPokemonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamPokemonsTable,
      TeamPokemon,
      $$TeamPokemonsTableFilterComposer,
      $$TeamPokemonsTableOrderingComposer,
      $$TeamPokemonsTableAnnotationComposer,
      $$TeamPokemonsTableCreateCompanionBuilder,
      $$TeamPokemonsTableUpdateCompanionBuilder,
      (
        TeamPokemon,
        BaseReferences<_$AppDatabase, $TeamPokemonsTable, TeamPokemon>,
      ),
      TeamPokemon,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$TrainersTableTableManager get trainers =>
      $$TrainersTableTableManager(_db, _db.trainers);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$TeamPokemonsTableTableManager get teamPokemons =>
      $$TeamPokemonsTableTableManager(_db, _db.teamPokemons);
}
