import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/poke_api_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PokeApiRepository repository;

  HomeBloc(this.repository) : super(HomeLoading()) {
    on<LoadPokemonsEvent>(_onLoadPokemons);
    on<SearchPokemonsEvent>(_onSearchPokemons);
  }

  Future<void> _onLoadPokemons(LoadPokemonsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final list = await repository.fetchPokemons(limit: 50);
      emit(HomeLoaded(allPokemons: list, filteredPokemons: list));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchPokemons(SearchPokemonsEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final query = event.query.toLowerCase().trim();
      final filtered = query.isEmpty 
          ? currentState.allPokemons 
          : currentState.allPokemons.where((p) {
              return p.name.toLowerCase().contains(query) ||
                     p.id.toString() == query;
            }).toList();
            
      emit(HomeLoaded(allPokemons: currentState.allPokemons, filteredPokemons: filtered));
    }
  }
}
