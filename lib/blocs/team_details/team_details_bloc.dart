import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/team_pokemon_repository.dart';
import '../../repositories/poke_api_repository.dart';
import '../../models/pokemon.dart';
import 'team_details_event.dart';
import 'team_details_state.dart';

class TeamDetailsBloc extends Bloc<TeamDetailsEvent, TeamDetailsState> {
  final TeamPokemonRepository teamPokemonRepository;
  final PokeApiRepository apiRepository;

  TeamDetailsBloc({
    required this.teamPokemonRepository,
    required this.apiRepository,
  }) : super(TeamDetailsLoading()) {
    on<LoadTeamDetailsEvent>(_onLoadTeamDetails);
    on<AddPokemonToTeamEvent>(_onAddPokemonToTeam);
    on<RemovePokemonFromTeamEvent>(_onRemovePokemonFromTeam);
  }

  Future<void> _onLoadTeamDetails(LoadTeamDetailsEvent event, Emitter<TeamDetailsState> emit) async {
    emit(TeamDetailsLoading());
    try {
      final teamPokemons = await teamPokemonRepository.getPokemonsByTeam(event.teamId);
      List<Pokemon> loaded = [];
      for (var tp in teamPokemons) {
        try {
          final p = await apiRepository.fetchPokemonById(tp.pokemonId);
          loaded.add(p);
        } catch (e) {
          continue;
        }
      }
      emit(TeamDetailsLoaded(pokemons: loaded));
    } catch (e) {
      emit(TeamDetailsError(e.toString()));
    }
  }

  Future<void> _onAddPokemonToTeam(AddPokemonToTeamEvent event, Emitter<TeamDetailsState> emit) async {
    final currentState = state;
    List<Pokemon> currentPokemons = [];
    if (currentState is TeamDetailsLoaded) {
      currentPokemons = currentState.pokemons;
    } else if (currentState is TeamDetailsActionError) {
      currentPokemons = currentState.currentPokemons;
    }

    try {
      bool exists = await teamPokemonRepository.isPokemonInTeam(
        teamId: event.teamId, 
        pokemonId: event.pokemonId,
      );
      
      if (exists) {
        emit(TeamDetailsActionError('Este Pokémon já está no time!', currentPokemons));
        emit(TeamDetailsLoaded(pokemons: currentPokemons));
        return;
      }

      await teamPokemonRepository.addPokemonToTeam(
        teamId: event.teamId, 
        pokemonId: event.pokemonId,
      );
      add(LoadTeamDetailsEvent(event.teamId));
    } catch (e) {
      emit(TeamDetailsActionError(e.toString(), currentPokemons));
      emit(TeamDetailsLoaded(pokemons: currentPokemons));
    }
  }

  Future<void> _onRemovePokemonFromTeam(RemovePokemonFromTeamEvent event, Emitter<TeamDetailsState> emit) async {
    try {
      await teamPokemonRepository.removePokemonFromTeam(
        teamId: event.teamId, 
        pokemonId: event.pokemonId,
      );
      add(LoadTeamDetailsEvent(event.teamId));
    } catch (e) {
      emit(TeamDetailsError(e.toString()));
    }
  }
}
