import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../observer.dart';
import '../repo.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final FakeRepo _repo = FakeRepo();
  final TaskObservable _observable = GetIt.instance.get<TaskObservable>();

  GetTaskBloc() : super(GetTaskInitial()) {
    on<GetTaskEvent>((event, emit) async {
      emit(GetTaskLoading());

      try {
        final List<TaskModel> tasks = _repo.getTask();

        /// Once we get the tasks, we notify all the observers, that is every class
        /// that is listening to the observable [TaskObservable], at this point we might not even
        /// need this bloc again, we can just use the observable directly bu calling it in repository or usecase or something
        for (var task in tasks) {
          await Future.delayed(const Duration(milliseconds: 500));
          _observable.notifyObservers(task);
        }

        emit(GetTaskLoaded(tasks));
      } catch (e) {
        emit(GetTaskError(e.toString()));
      }
    });
  }
}
