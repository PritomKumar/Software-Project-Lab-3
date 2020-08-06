import 'package:earneasy/app_screens/authenticate/authenticate.dart';
import 'package:earneasy/app_screens/home/home_dummy.dart';
import 'package:earneasy/app_screens/home/login_screen.dart';
import 'package:earneasy/app_screens/search_screen_loader.dart';
import 'package:earneasy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return user == null ? Authenticate() : Home();
  }
}
