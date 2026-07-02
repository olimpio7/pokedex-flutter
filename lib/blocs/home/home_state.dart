import 'package:equatable/equatable.dart';
import '../../models/pokemon.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Pokemon> allPokemons;
  final List<Pokemon> filteredPokemons;

  const HomeLoaded({
    required this.allPokemons,
    required this.filteredPokemons,
  });

  @override
  List<Object?> get props => [allPokemons, filteredPokemons];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
