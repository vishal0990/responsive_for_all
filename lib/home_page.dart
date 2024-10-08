import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("go to");
            Get.toNamed('/todo');
          },
          child: Text('Go to To-Do List'),
        ),
      ),
    );
  }
}
