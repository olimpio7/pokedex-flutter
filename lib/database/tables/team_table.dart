import 'package:drift/drift.dart';

class Teams extends Table {
  IntColumn get teamId => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime()();
}
