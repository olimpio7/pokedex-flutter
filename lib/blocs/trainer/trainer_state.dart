import 'package:equatable/equatable.dart';
import '../../database/app_database.dart';

abstract class TrainerState extends Equatable {
  const TrainerState();
  
  @override
  List<Object?> get props => [];
}

class TrainerLoading extends TrainerState {}

class TrainerLoaded extends TrainerState {
  final Trainer? trainer;

  const TrainerLoaded({this.trainer});

  @override
  List<Object?> get props => [trainer];
}

class TrainerError extends TrainerState {
  final String message;

  const TrainerError(this.message);

  @override
  List<Object?> get props => [message];
}
