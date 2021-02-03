import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Container(
            color: Colors.blue[100],
            child: Center(
              child: SpinKitHourGlass(
                color: Theme.of(context).primaryColor,
                size: 100.0,
              ),
            ),
          ),
        ));
  }
}
