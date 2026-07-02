import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/trainer_table.dart';

part 'trainer_dao.g.dart';

@DriftAccessor(tables: [Trainers])
class TrainerDao extends DatabaseAccessor<AppDatabase> with _$TrainerDaoMixin {
  TrainerDao(super.db);

  Future<int> createTrainer(TrainersCompanion entry) {
    return into(trainers).insert(entry);
  }

  Future<List<Trainer>> getTrainers() {
    return (select(trainers)
          ..orderBy([
            (t) => OrderingTerm(expression: t.trainerId, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<Trainer?> getTrainerById(int trainerId) {
    return (select(trainers)..where((t) => t.trainerId.equals(trainerId))).getSingleOrNull();
  }

  Future<int> updateTrainer(int trainerId, TrainersCompanion entry) {
    return (update(trainers)..where((t) => t.trainerId.equals(trainerId))).write(entry);
  }

  Future<int> deleteTrainer(int trainerId) {
    return (delete(trainers)..where((t) => t.trainerId.equals(trainerId))).go();
  }
}
