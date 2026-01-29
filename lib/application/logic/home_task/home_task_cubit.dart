import 'package:bloc/bloc.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/repository/home_task_repository.dart';
import 'home_task_state.dart';

/// The [Cubit] responsible for home page task related operations.
class HomeTaskCubit extends Cubit<HomeTaskState> {

  /// The [HomeTaskRepository] repository that is needed as a dependency.
  final HomeTaskRepository homeTaskRepository;

  /// Default selected task filter.
  TaskFilter selectedFilter = .all;

  /// Creates an instance of [HomeTaskCubit].
  HomeTaskCubit({required this.homeTaskRepository})
    : super(HomeTaskLoadingState());

  /// This method gets only the selected filtered task.
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

  /// This method deletes a task.
  Future<void> deleteTask(int id) async {
    try {
      await homeTaskRepository.deleteTask(id);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      emit(HomeTaskErrorState(error: e));
    }
  }

  /// This method marks a task complete.
  Future<void> markAsComplete(TaskEntity task) async {
    try {
      await homeTaskRepository.markAsComplete(task);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      emit(HomeTaskErrorState(error: e));
    }
  }

  /// This method reverts the task status from complete to original.
  Future<void> revert(TaskEntity task) async {
    try {
      await homeTaskRepository.revert(task);
      await getFilteredTasks(selectedFilter);
    } catch (e) {
      HomeTaskErrorState(error: e);
    }
  }
}
