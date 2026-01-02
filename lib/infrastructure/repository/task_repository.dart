import '../../domain/entity/task_entity.dart';
import '../../domain/repository/task_repository.dart';
import '../model/task_model.dart';
import '../source/task_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskSource taskSource;

  TaskRepositoryImpl({required this.taskSource});

  @override
  Future<void> updateTask(TaskEntity task) async {
    await taskSource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await taskSource.createTask(task);
  }
}
