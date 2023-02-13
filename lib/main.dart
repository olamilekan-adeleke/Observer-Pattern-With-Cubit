import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:observer_pattern/completed_task_listeners.dart';
import 'package:observer_pattern/observer.dart';

import 'bloc/get_task_bloc.dart';
import 'home_page.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => TaskObservable());
  GetIt.instance.registerLazySingleton(() => GetTaskBloc());
  GetIt.instance.registerLazySingleton(
    () => CompletedTaskCubit(observable: GetIt.instance.get<TaskObservable>()),
  );
  GetIt.instance.registerLazySingleton(
    () => UnCompletedTaskCubit(
      observable: GetIt.instance.get<TaskObservable>(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
