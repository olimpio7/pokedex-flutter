import 'package:equatable/equatable.dart';
import '../../models/pokemon.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final Pokemon pokemon;
  const AddFavoriteEvent(this.pokemon);
  @override
  List<Object?> get props => [pokemon];
}

class DeleteFavoriteEvent extends FavoritesEvent {
  final int pokemonId;
  const DeleteFavoriteEvent(this.pokemonId);
  @override
  List<Object?> get props => [pokemonId];
}

class EditFavoriteEvent extends FavoritesEvent {
  final int pokemonId;
  final String? comment;
  final int? rating;

  const EditFavoriteEvent({
    required this.pokemonId,
    this.comment,
    this.rating,
  });

  @override
  List<Object?> get props => [pokemonId, comment, rating];
}
