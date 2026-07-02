import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/team_repository.dart';
import 'teams_event.dart';
import 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final TeamRepository repository;

  TeamsBloc(this.repository) : super(TeamsLoading()) {
    on<LoadTeamsEvent>(_onLoadTeams);
    on<SaveTeamEvent>(_onSaveTeam);
    on<DeleteTeamEvent>(_onDeleteTeam);
  }

  Future<void> _onLoadTeams(LoadTeamsEvent event, Emitter<TeamsState> emit) async {
    emit(TeamsLoading());
    try {
      final teams = await repository.getTeams();
      emit(TeamsLoaded(teams: teams));
    } catch (e) {
      emit(TeamsError(e.toString()));
    }
  }

  Future<void> _onSaveTeam(SaveTeamEvent event, Emitter<TeamsState> emit) async {
    try {
      if (event.team == null) {
        await repository.createTeam(
          name: event.name,
          description: event.description,
        );
      } else {
        await repository.updateTeam(
          teamId: event.team!.teamId,
          name: event.name,
          description: event.description,
          createdAt: event.team!.createdAt,
        );
      }
      add(LoadTeamsEvent());
    } catch (e) {
      emit(TeamsError(e.toString()));
    }
  }

  Future<void> _onDeleteTeam(DeleteTeamEvent event, Emitter<TeamsState> emit) async {
    try {
      await repository.deleteTeam(event.teamId);
      add(LoadTeamsEvent());
    } catch (e) {
      emit(TeamsError(e.toString()));
    }
  }
}
