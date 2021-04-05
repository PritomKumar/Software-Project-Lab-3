import 'package:flutter/material.dart';

class ImageTaskProvider extends StatefulWidget {
  @override
  _ImageTaskProviderState createState() => _ImageTaskProviderState();
}

class _ImageTaskProviderState extends State<ImageTaskProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Task'),
      ),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
