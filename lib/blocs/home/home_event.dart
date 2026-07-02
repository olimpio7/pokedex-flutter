import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadPokemonsEvent extends HomeEvent {}

class SearchPokemonsEvent extends HomeEvent {
  final String query;
  const SearchPokemonsEvent(this.query);
  @override
  List<Object?> get props => [query];
}
