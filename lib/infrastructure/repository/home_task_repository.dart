import '../../domain/entity/task_entity.dart';
import '../source/home_task_source.dart';
import '../../domain/repository/home_task_repository.dart';

class HomeTaskRepositoryImpl implements HomeTaskRepository {
  final HomeTaskLocalSource source;

  HomeTaskRepositoryImpl({required this.source});

  @override
  Future<void> deleteTask(int id) async {
    await source.deleteTask(id);
  }

  @override
  Future<List<TaskEntity>> getFilteredTasks(TaskFilter filter) async {
    return await source.getFilteredTasks(filter);
  }

  @override
  Future<void> markAsComplete(TaskEntity task) async {
    await source.markAsComplete(task);
  }

  @override
  Future<void> revert(TaskEntity task) async {
    await source.revert(task);
  }
}