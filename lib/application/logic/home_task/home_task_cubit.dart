import 'package:bloc/bloc.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/repository/home_task_repository.dart';
import 'home_task_state.dart';

class HomeTaskCubit extends Cubit<HomeTaskState> {
  final HomeTaskRepository homeTaskRepository;
  TaskFilter selectedFilter = .all;

  HomeTaskCubit({required this.homeTaskRepository})
    : super(HomeTaskLoadingState());

  Future<void> getFilteredTasks(TaskFilter filter) async {
    try {
      final List<TaskEntity> tasks = await homeTaskRepository.getFilteredTasks(
        filter,
      );
      emit(HomeTaskLoadedState(tasks: tasks));
    } catch (e) {
      emit(HomeTaskErrorState(error: e));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await homeTaskRepository.deleteTask(id);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      emit(HomeTaskErrorState(error: e));
    }
  }

  Future<void> markAsComplete(TaskEntity task) async {
    try {
      await homeTaskRepository.markAsComplete(task);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      emit(HomeTaskErrorState(error: e));
    }
  }

  Future<void> revert(TaskEntity task) async {
    try {
      await homeTaskRepository.revert(task);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      HomeTaskErrorState(error: e);
    }
  }
}
