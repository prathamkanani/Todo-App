import 'package:bloc/bloc.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/repository/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;

  TaskCubit({required this.taskRepository}) : super(TaskLoadingState());

  Future<void> loadTask() async {
    try {
      emit(TaskUpdateState());
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await taskRepository.updateTask(task);
      emit(TaskUpdatedState(task: task));
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }
  
  Future<void> createTask(TaskEntity task) async {
    try {
      await taskRepository.createTask(task);
      emit(TaskUpdatedState(task: task));
    } catch (e) {
      emit(TaskErrorState(error: e));
    }
  }
}