import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Add a comment',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            // Add comment submission logic here
            if (_controller.text.isNotEmpty) {
              // Here, you would typically add the comment to a list or send it to a backend
              print('Comment: ${_controller.text}');
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
