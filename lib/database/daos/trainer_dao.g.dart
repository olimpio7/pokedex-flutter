// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_dao.dart';

// ignore_for_file: type=lint
mixin _$TrainerDaoMixin on DatabaseAccessor<AppDatabase> {
  $TrainersTable get trainers => attachedDatabase.trainers;
  TrainerDaoManager get managers => TrainerDaoManager(this);
}

class TrainerDaoManager {
  final _$TrainerDaoMixin _db;
  TrainerDaoManager(this._db);
  $$TrainersTableTableManager get trainers =>
      $$TrainersTableTableManager(_db.attachedDatabase, _db.trainers);
}
