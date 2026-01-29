import 'package:bloc/bloc.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/repository/task_repository.dart';
import 'task_state.dart';

/// The [Cubit] responsible for task related operations.
class TaskCubit extends Cubit<TaskState> {
  /// The [TaskRepository] repository that is needed as a dependency.
  final TaskRepository taskRepository;

  /// Creating an instance of [TaskCubit].
  TaskCubit({required this.taskRepository}) : super(TaskLoadingState());

  /// This method loads task.
  Future<void> loadTask() async {
    try {
      emit(TaskUpdateState());
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }

  /// This method updates an existing task.
  ///
  /// * [task] : The task which needs to be updated.
  Future<void> updateTask(TaskEntity task) async {
    try {
      await taskRepository.updateTask(task);
      emit(TaskUpdatedState(task: task));
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }

  /// This method creates a new task.
  ///
  /// * [task] : The task that is created.
  Future<void> createTask(TaskEntity task) async {
    try {
      await taskRepository.createTask(task);
      emit(TaskUpdatedState(task: task));
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }
}