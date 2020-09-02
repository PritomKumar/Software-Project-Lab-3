import 'package:earneasy/app_screens/authenticate/authenticate.dart';
import 'package:earneasy/app_screens/authenticate/select_sign_in.dart';
import 'package:earneasy/app_screens/home/home_dummy.dart';
import 'package:earneasy/app_screens/home/login_screen.dart';
import 'package:earneasy/app_screens/search_screen_loader.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMinimum>(context);
    print(user);
    return user == null
        ? SignInOptions()
        : StreamProvider<UserAccount>.value(
            value: DatabaseServiceUser().userData,
            child: Home(),
          );
  }
}
