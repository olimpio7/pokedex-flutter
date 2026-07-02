import 'package:equatable/equatable.dart';

abstract class TrainerEvent extends Equatable {
  const TrainerEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrainerEvent extends TrainerEvent {}

class SaveTrainerEvent extends TrainerEvent {
  final String name;
  final String city;
  final String avatar;

  const SaveTrainerEvent({
    required this.name,
    required this.city,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, city, avatar];
}

class DeleteTrainerEvent extends TrainerEvent {}
