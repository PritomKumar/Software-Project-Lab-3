import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageAndroid extends StatefulWidget {
  @override
  _MessageAndroidState createState() => _MessageAndroidState();
}

class _MessageAndroidState extends State<MessageAndroid> {
  static const platform = const MethodChannel("Payment");
  String _message = "No new message !";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MessageAndroid'),
        ),
        body: Center(
          child: Container(
            child: Text(_message),
          ),
        ),
      ),
    );
  }
}
