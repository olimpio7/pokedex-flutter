import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TrainerRepository {
  final AppDatabase _db;

  TrainerRepository(this._db);

  Future<int> createTrainer({
    required String name,
    required String city,
    required String avatar,
  }) {
    final companion = TrainersCompanion(
      name: Value(name),
      city: Value(city),
      avatar: Value(avatar),
    );

    return _db.trainerDao.createTrainer(companion);
  }

  Future<List<Trainer>> getTrainers() {
    return _db.trainerDao.getTrainers();
  }

  Future<Trainer?> getTrainerById(int trainerId) {
    return _db.trainerDao.getTrainerById(trainerId);
  }

  Future<int> updateTrainer({
    required int trainerId,
    required String name,
    required String city,
    required String avatar,
  }) {
    final companion = TrainersCompanion(
      name: Value(name),
      city: Value(city),
      avatar: Value(avatar),
    );

    return _db.trainerDao.updateTrainer(trainerId, companion);
  }

  Future<int> deleteTrainer(int trainerId) {
    return _db.trainerDao.deleteTrainer(trainerId);
  }
}
