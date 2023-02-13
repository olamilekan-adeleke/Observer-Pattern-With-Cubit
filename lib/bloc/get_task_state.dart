part of 'get_task_bloc.dart';

abstract class GetTaskState extends Equatable {
  const GetTaskState();

  @override
  List<Object> get props => [];
}

class GetTaskInitial extends GetTaskState {}

class GetTaskLoading extends GetTaskState {}

class GetTaskLoaded extends GetTaskState {
  final List<TaskModel> tasks;

  const GetTaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class GetTaskError extends GetTaskState {
  final String message;

  const GetTaskError(this.message);

  @override
  List<Object> get props => [message];
}
