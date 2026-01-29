import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/home_task/home_task_cubit.dart';
import '../../../../application/logic/home_task/home_task_state.dart';
import '../../../../domain/entity/profile_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_spacing.dart';
import '../../chat/chat_page.dart';
import '../../create_task/create_task_page.dart';
import '../../../shared/base_page.dart';
import '../../create_task/widgets/create_task_animated_button.dart';
import 'task_filter.dart';
import 'task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.profileEntity,
    required this.homeTaskCubit,
  });

  final HomeTaskCubit homeTaskCubit;
  final ProfileEntity profileEntity;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController controller;
  late final cubit = widget.homeTaskCubit;
  bool buttonOn = true;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void createTask(BuildContext context) async {
    await context.push(const CreateTaskPage());
    return cubit.getFilteredTasks(cubit.selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return BasePage(
      safeAreaTop: false,
      padding: EdgeInsets.zero,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CreateTaskAnimatedButton(
        scrollController: controller,
        child: FilledButton.icon(
          onPressed: () => createTask(context),
          label: Text(
            S.of(context).createTask,
            style: TextStyle(color: colorScheme.secondary),
          ),
          icon: Icon(Icons.add, color: colorScheme.secondary),
        ),
      ),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar.large(
            title: Text(S.of(context).myTasks),
            surfaceTintColor: Colors.transparent,
            actions: <Widget>[
              IconButton.filledTonal(
                onPressed: () {
                  context.push(const ChatPage());
                },
                icon: const Icon(Icons.auto_awesome),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.secondaryContainer.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
              AppSpacing.w16,
            ],
          ),
          PinnedHeaderSliver(child: TaskFilterList(cubit: cubit)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<HomeTaskCubit, HomeTaskState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is HomeTaskLoadedState) {
                return TaskList(tasks: state.tasks, homeTaskCubit: cubit);
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          const SliverToBoxAdapter(child: AppSpacing.h16),
        ],
      ),
    );
  }
}
