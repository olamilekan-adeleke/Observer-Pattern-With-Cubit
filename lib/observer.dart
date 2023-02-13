import 'package:observer_pattern/repo.dart';

abstract class TaskObserversDelegate {
  void onUpdated(TaskModel task);
}

abstract class TaskObservableDelegate {
  void addObserver(TaskObserversDelegate observer);
  void removeObserver(TaskObserversDelegate observer);
  void notifyObservers(TaskModel task);
}

class TaskObservable extends TaskObservableDelegate {
  final List<TaskObserversDelegate> _observers = [];

  @override
  void addObserver(TaskObserversDelegate observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(TaskObserversDelegate observer) {
    _observers.remove(observer);
  }

  @override
  void notifyObservers(TaskModel task) {
    for (var observer in _observers) {
      observer.onUpdated(task);
    }
  }
}
