import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../application/logic/task/task_cubit.dart';
import '../../../application/logic/task/task_state.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../shared/base_page.dart';
import 'widgets/create_task_form.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskEntity? taskEntity;

  const CreateTaskPage({super.key, this.taskEntity});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late final TaskCubit taskCubit;

  @override
  void initState() {
    super.initState();
    taskCubit = locator.get<TaskCubit>()..loadTask();
  }

  @override
  void dispose() {
    taskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final String updateOrCreate = widget.taskEntity != null
        ? S.of(context).update
        : S.of(context).create;
    return BlocConsumer<TaskCubit, TaskState>(
      bloc: taskCubit,
      listener: (BuildContext context, TaskState state) async {
        if (state is TaskUpdatedState) {
          context.pop();
        }
      },
      buildWhen: (_,next) {
        return next is !TaskUpdatedState;
      },
      builder: (context, state) {
        return switch (state) {
          TaskLoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),
          TaskUpdateState() => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: BasePage(
              bgColorNeeded: false,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: context.pop,
                  icon: const Icon(Icons.chevron_left),
                ),
                title: Text(
                  Intl.message('$updateOrCreate Task'),
                  style: textTheme.titleLarge,
                ),
                centerTitle: true,
              ),
              child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => taskCubit,
                  child: CreateTaskForm(
                    taskEntity: widget.taskEntity,
                    updateOrCreate: updateOrCreate,
                  ),
                ),
              ),
            ),
          ),
          TaskUpdatedState() => const SizedBox.shrink(),
          TaskErrorState() => Center(child: Text(state.error.toString())),
        };
      },
    );
  }
}
