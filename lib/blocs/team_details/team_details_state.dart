import 'package:equatable/equatable.dart';
import '../../models/pokemon.dart';

abstract class TeamDetailsState extends Equatable {
  const TeamDetailsState();
  
  @override
  List<Object?> get props => [];
}

class TeamDetailsLoading extends TeamDetailsState {}

class TeamDetailsLoaded extends TeamDetailsState {
  final List<Pokemon> pokemons;

  const TeamDetailsLoaded({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}

class TeamDetailsError extends TeamDetailsState {
  final String message;

  const TeamDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TeamDetailsActionError extends TeamDetailsState {
  final String message;
  final List<Pokemon> currentPokemons;

  const TeamDetailsActionError(this.message, this.currentPokemons);

  @override
  List<Object?> get props => [message, currentPokemons];
}
