// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'observer.dart';
import 'repo.dart';

class TaskStateList {
  List<TaskModel> tasks;

  TaskStateList({List<TaskModel>? tasksList}) : tasks = tasksList ?? [];

  TaskStateList copyWith({List<TaskModel>? tasksList}) {
    return TaskStateList(tasksList: tasksList ?? tasks);
  }
}

class CompletedTaskCubit extends Cubit<TaskStateList>
    with TaskObserversDelegate {
  final TaskObservableDelegate observable;

  CompletedTaskCubit({required this.observable}) : super(TaskStateList()) {
    /// Once the class is created, we add it to the observer list so it can be notified
    /// when a task is been fetched
    observable.addObserver(this);
  }

  @override
  void onUpdated(TaskModel task) {
    if (task.isCompleted == true) {
      emit(state.copyWith(tasksList: [...state.tasks, task]));
    }
  }

  void dispose() {
    /// When the class is disposed, we remove it from the observer list so
    /// we don't get notified anymore
    observable.removeObserver(this);
  }
}

class UnCompletedTaskCubit extends Cubit<TaskStateList>
    with TaskObserversDelegate {
  final TaskObservableDelegate observable;

  UnCompletedTaskCubit({required this.observable}) : super(TaskStateList()) {
    /// Once the class is created, we add it to the observer list so it can be notified
    /// when a task is been fetched
    observable.addObserver(this);
  }

  @override
  void onUpdated(TaskModel task) {
    if (task.isCompleted == false) {
      emit(state.copyWith(tasksList: [...state.tasks, task]));
    }
  }

  void dispose() {
    /// When the class is disposed, we remove it from the observer list so
    /// we don't get notified anymore
    observable.removeObserver(this);
  }
}

// ignore: todo
// TODO: NOTE -> This is how you will do it if it was just a class and not a cubit
class UnCompletedTaskListener extends TaskObserversDelegate {
  final TaskObservableDelegate observable;

  UnCompletedTaskListener({required this.observable}) {
    /// Once the class is created, we add it to the observer list so it can be notified
    /// when a task is been fetched
    observable.addObserver(this);
  }

  static const List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  @override
  void onUpdated(TaskModel task) {
    if (task.isCompleted == false) {
      _tasks.add(task);
    }
  }

  void dispose() {
    /// When the class is disposed, we remove it from the observer list so
    /// we don't get notified anymore
    observable.removeObserver(this);
  }
}
