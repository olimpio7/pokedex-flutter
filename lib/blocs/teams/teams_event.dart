import 'package:equatable/equatable.dart';
import '../../database/app_database.dart';

abstract class TeamsEvent extends Equatable {
  const TeamsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeamsEvent extends TeamsEvent {}

class SaveTeamEvent extends TeamsEvent {
  final Team? team;
  final String name;
  final String description;

  const SaveTeamEvent({
    this.team,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [team, name, description];
}

class DeleteTeamEvent extends TeamsEvent {
  final int teamId;

  const DeleteTeamEvent(this.teamId);

  @override
  List<Object?> get props => [teamId];
}
