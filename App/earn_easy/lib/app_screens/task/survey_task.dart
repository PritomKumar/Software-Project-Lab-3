import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SurveyTask extends StatefulWidget {
  @override
  _SurveyTaskState createState() => _SurveyTaskState();
}

class _SurveyTaskState extends State<SurveyTask> {

  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Form(
            key:_formKey,
            child: ListView(
              children: <Widget>[
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
