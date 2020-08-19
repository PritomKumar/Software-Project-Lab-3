import 'package:flutter/material.dart';

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: Center(
          child: Container(
            child: Text('Notification'),
          ),
        ),
      ),
    );
  }
}
