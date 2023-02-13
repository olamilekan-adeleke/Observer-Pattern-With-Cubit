import 'package:intl/intl.dart';

class TaskModel {
  final String id;
  final bool isCompleted;

  const TaskModel({required this.id, required this.isCompleted});
}

class FakeRepo {
  List<TaskModel> getTask() {
    List<TaskModel> taskList = [];

    for (var i = 0; i < 7; i++) {
      taskList.add(
        TaskModel(
          id: DateFormat('$i -> ddd, at hh:mm:ss a').format(DateTime.now()),
          isCompleted: i % 2 == 0 ? true : false,
        ),
      );
    }

    return taskList;
  }
}
