import '../../../domain/entity/task_entity.dart';

sealed class HomeTaskState {}

final class HomeTaskLoadingState extends HomeTaskState {}

final class HomeTaskLoadedState extends HomeTaskState {
  final List<TaskEntity> tasks;
  HomeTaskLoadedState({required this.tasks});
}

final class HomeTaskErrorState extends HomeTaskState {
  final Object? error;
  HomeTaskErrorState({required this.error});
}