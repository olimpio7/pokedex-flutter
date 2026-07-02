import 'package:drift/drift.dart';

class Trainers extends Table {
  IntColumn get trainerId => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get city => text()();
  TextColumn get avatar => text()();
}
