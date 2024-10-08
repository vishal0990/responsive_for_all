import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the passed arguments
    final String message = Get.arguments ?? 'No message received';

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Go back to the HomeScreen
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
