import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/favorite_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesLoading()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<DeleteFavoriteEvent>(_onDeleteFavorite);
    on<EditFavoriteEvent>(_onEditFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final list = await repository.getAllFavorites();
      emit(FavoritesLoaded(list));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(AddFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      await repository.saveFavorite(event.pokemon);
      emit(FavoriteAdded());
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onDeleteFavorite(DeleteFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      await repository.removeFavorite(event.pokemonId);
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onEditFavorite(EditFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      await repository.updateFavoriteCommentAndRating(event.pokemonId, event.comment, event.rating);
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
