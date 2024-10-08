import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'todo_controller.dart';

class TodoPage extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddTodoDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              title: Text(
                todo,
                style: TextStyle(
                  decoration: controller.isDone[index]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Obx(() => Checkbox(
                    value: controller.isDone[index],
                    onChanged: (value) {
                      controller.toggleDone(index);
                      print('toggle---');
                    },
                  )),
              onLongPress: () {
                controller.removeTodoAt(index);
              },
            );
          },
        );
      }),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();
    Get.defaultDialog(
      title: 'Add a Task',
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Enter task'),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          controller.addTodo(textController.text);
          Get.back();
        },
        child: Text('Add'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
    );
  }
}
