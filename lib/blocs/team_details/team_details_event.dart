import 'package:equatable/equatable.dart';

abstract class TeamDetailsEvent extends Equatable {
  const TeamDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeamDetailsEvent extends TeamDetailsEvent {
  final int teamId;

  const LoadTeamDetailsEvent(this.teamId);

  @override
  List<Object?> get props => [teamId];
}

class AddPokemonToTeamEvent extends TeamDetailsEvent {
  final int teamId;
  final int pokemonId;

  const AddPokemonToTeamEvent({
    required this.teamId,
    required this.pokemonId,
  });

  @override
  List<Object?> get props => [teamId, pokemonId];
}

class RemovePokemonFromTeamEvent extends TeamDetailsEvent {
  final int teamId;
  final int pokemonId;

  const RemovePokemonFromTeamEvent({
    required this.teamId,
    required this.pokemonId,
  });

  @override
  List<Object?> get props => [teamId, pokemonId];
}
