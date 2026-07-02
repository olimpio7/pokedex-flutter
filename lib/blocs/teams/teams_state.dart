import 'package:equatable/equatable.dart';
import '../../database/app_database.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();
  
  @override
  List<Object?> get props => [];
}

class TeamsLoading extends TeamsState {}

class TeamsLoaded extends TeamsState {
  final List<Team> teams;

  const TeamsLoaded({required this.teams});

  @override
  List<Object?> get props => [teams];
}

class TeamsError extends TeamsState {
  final String message;

  const TeamsError(this.message);

  @override
  List<Object?> get props => [message];
}
