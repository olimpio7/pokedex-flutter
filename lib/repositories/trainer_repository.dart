import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TrainerRepository {
  final AppDatabase _db;

  TrainerRepository(this._db);

  /// Cria um novo treinador.
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

  /// Busca todos os treinadores cadastrados.
  Future<List<Trainer>> getTrainers() {
    return _db.trainerDao.getTrainers();
  }

  /// Busca um treinador pelo ID.
  Future<Trainer?> getTrainerById(int trainerId) {
    return _db.trainerDao.getTrainerById(trainerId);
  }

  /// Atualiza os dados de um treinador.
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

  /// Exclui um treinador pelo ID.
  Future<int> deleteTrainer(int trainerId) {
    return _db.trainerDao.deleteTrainer(trainerId);
  }
}
