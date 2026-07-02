import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/trainer_repository.dart';
import 'trainer_event.dart';
import 'trainer_state.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  final TrainerRepository repository;

  TrainerBloc(this.repository) : super(TrainerLoading()) {
    on<LoadTrainerEvent>(_onLoadTrainer);
    on<SaveTrainerEvent>(_onSaveTrainer);
    on<DeleteTrainerEvent>(_onDeleteTrainer);
  }

  Future<void> _onLoadTrainer(LoadTrainerEvent event, Emitter<TrainerState> emit) async {
    emit(TrainerLoading());
    try {
      final trainers = await repository.getTrainers();
      emit(TrainerLoaded(trainer: trainers.isNotEmpty ? trainers.first : null));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> _onSaveTrainer(SaveTrainerEvent event, Emitter<TrainerState> emit) async {
    final currentState = state;
    try {
      if (currentState is TrainerLoaded && currentState.trainer != null) {
        await repository.updateTrainer(
          trainerId: currentState.trainer!.trainerId,
          name: event.name,
          city: event.city,
          avatar: event.avatar,
        );
      } else {
        await repository.createTrainer(
          name: event.name,
          city: event.city,
          avatar: event.avatar,
        );
      }
      add(LoadTrainerEvent());
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> _onDeleteTrainer(DeleteTrainerEvent event, Emitter<TrainerState> emit) async {
    final currentState = state;
    try {
      if (currentState is TrainerLoaded && currentState.trainer != null) {
        await repository.deleteTrainer(currentState.trainer!.trainerId);
      }
      add(LoadTrainerEvent());
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }
}
