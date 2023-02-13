import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:observer_pattern/bloc/get_task_bloc.dart';
import 'package:observer_pattern/repo.dart';

import 'completed_task_listeners.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetTaskBloc _bloc = GetIt.instance.get<GetTaskBloc>();
  final CompletedTaskCubit _completedTaskCubit =
      GetIt.instance.get<CompletedTaskCubit>();
  final UnCompletedTaskCubit _uncompletedTaskCubit =
      GetIt.instance.get<UnCompletedTaskCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observer Pattern'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                _bloc.add(const GetTaskEvent());
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Get Tasks',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 5,
                  child: _buildCompletedTaskList(),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 5,
                  child: _buildUnCompletedTaskList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedTaskList() {
    return BlocBuilder<CompletedTaskCubit, TaskStateList>(
      bloc: _completedTaskCubit,
      builder: (context, state) {
        if (state.tasks.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              TaskModel task = state.tasks[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.green.withOpacity(0.5),
                child: ListTile(
                  title: Text(task.id),
                  subtitle: Text('Status: ${task.isCompleted.toString()}'),
                ),
              );
            },
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: Colors.green.withOpacity(0.5),
          child: const ListTile(title: Text('No Task Yet')),
        );
      },
    );
  }

  Widget _buildUnCompletedTaskList() {
    return BlocBuilder<UnCompletedTaskCubit, TaskStateList>(
      bloc: _uncompletedTaskCubit,
      builder: (context, state) {
        if (state.tasks.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              TaskModel task = state.tasks[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.red.withOpacity(0.5),
                child: ListTile(
                  title: Text(task.id),
                  subtitle: Text('Status: ${task.isCompleted.toString()}'),
                ),
              );
            },
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: Colors.red.withOpacity(0.5),
          child: const ListTile(title: Text('No Task')),
        );
      },
    );
  }
}
