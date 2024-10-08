import 'package:get/get.dart';

class TodoController extends GetxController {
  var todos = <String>[].obs;
  var isDone = <bool>[].obs;

  void addTodo(String task) {
    if (task.isNotEmpty) {
      todos.add(task);
      isDone.add(false); // Add a "not done" status for the new task
    }
  }

  void toggleDone(int index) {
    isDone[index] = !isDone[index];
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
    isDone.removeAt(index);
  }
}
