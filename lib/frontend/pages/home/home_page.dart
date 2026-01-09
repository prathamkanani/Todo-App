import 'package:flutter/material.dart';
import '../../../application/logic/home_task/home_task_cubit.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../infrastructure/app_injector.dart';
import 'widgets/home_screen.dart';

class HomePage extends StatefulWidget {
  final ProfileEntity profileEntity;

  const HomePage({super.key, required this.profileEntity});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeTaskCubit homeTaskCubit;

  @override
  void initState() {
    super.initState();
    homeTaskCubit = locator.get<HomeTaskCubit>()
      ..getFilteredTasks(TaskFilter.all);
  }

  @override
  void dispose() {
    homeTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        profileEntity: widget.profileEntity,
        homeTaskCubit: homeTaskCubit,
      ),
    );
  }
}
