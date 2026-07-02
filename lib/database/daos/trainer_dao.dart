import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/trainer_table.dart';

part 'trainer_dao.g.dart';

@DriftAccessor(tables: [Trainers])
class TrainerDao extends DatabaseAccessor<AppDatabase> with _$TrainerDaoMixin {
  TrainerDao(super.db);

  /// Cria um novo treinador.
  Future<int> createTrainer(TrainersCompanion entry) {
    return into(trainers).insert(entry);
  }

  /// Busca todos os treinadores cadastrados.
  Future<List<Trainer>> getTrainers() {
    return (select(trainers)
          ..orderBy([
            (t) => OrderingTerm(expression: t.trainerId, mode: OrderingMode.asc),
          ]))
        .get();
  }

  /// Busca um treinador pelo ID.
  Future<Trainer?> getTrainerById(int trainerId) {
    return (select(trainers)..where((t) => t.trainerId.equals(trainerId))).getSingleOrNull();
  }

  /// Atualiza os dados de um treinador.
  Future<int> updateTrainer(int trainerId, TrainersCompanion entry) {
    return (update(trainers)..where((t) => t.trainerId.equals(trainerId))).write(entry);
  }

  /// Exclui um treinador pelo ID.
  Future<int> deleteTrainer(int trainerId) {
    return (delete(trainers)..where((t) => t.trainerId.equals(trainerId))).go();
  }
}
