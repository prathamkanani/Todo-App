import 'package:supabase_flutter/supabase_flutter.dart';
import '../application/logic/auth/auth_cubit.dart';
import '../application/logic/chat/chat_cubit.dart';
import '../application/logic/home_task/home_task_cubit.dart';
import '../application/logic/profile/profile_cubit.dart';
import '../application/logic/task/task_cubit.dart';
import '../application/service/locator.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/home_task_repository.dart';
import '../domain/repository/profile_repository.dart';
import '../domain/repository/task_repository.dart';
import 'repository/auth_repository.dart';
import 'repository/chat_repository.dart';
import 'repository/home_task_repository.dart';
import 'repository/profile_repository.dart';
import 'repository/task_repository.dart';
import 'source/auth_source.dart';
import 'source/chat_source.dart';
import 'source/home_task_source.dart';
import 'source/task_database_init.dart';
import 'source/profile_source.dart';
import 'source/task_source.dart';

/// Global instance for locator
final Locator locator = LocatorImpl();

/// Defines the contract for service locator based of flavor of the application.
abstract interface class AppInjector {
  /// Injects all the dependencies and initialize services.
  Future<void> init();
}

/// Service locator for development.
class DependencyInjector implements AppInjector {
  @override
  Future<void> init() async {
    locator.registerSingleton(Supabase.instance.client);

    locator.registerSingleton(LocalTaskDatabase().database);

    // Registering Auth dependencies
    locator.registerFactory<SupabaseAuthSource>(
      () => SupabaseAuthSource(locator.get()),
    );
    locator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(locator.get()),
    );
    locator.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: locator.get()),
    );

    // Registering Profile dependencies
    locator.registerFactory(() => ProfileRemoteDataSource(locator.get()));
    locator.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(locator.get()),
    );
    locator.registerFactory<ProfileCubit>(
      () => ProfileCubit(repository: locator.get()),
    );

    // Registering Task dependencies
    locator.registerFactory<TaskSource>(() => TaskLocalSource());
    locator.registerFactory<TaskRepository>(
      () => TaskRepositoryImpl(taskSource: locator.get()),
    );
    locator.registerFactory<TaskCubit>(
      () => TaskCubit(taskRepository: locator.get()),
    );

    // Registering Chat dependencies
    locator.registerFactory<ChatSource>(() => LocalChatSource());
    locator.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(source: locator.get()),
    );
    locator.registerFactory<ChatCubit>(
      () => ChatCubit(chatRepository: locator.get()),
    );

    // Registering Home Task dependencies
    locator.registerFactory<HomeTaskLocalSource>(() => HomeTaskLocalSource());
    locator.registerFactory<HomeTaskRepository>(
      () => HomeTaskRepositoryImpl(source: locator.get()),
    );
    locator.registerFactory<HomeTaskCubit>(
      () => HomeTaskCubit(homeTaskRepository: locator.get()),
    );
  }
}
