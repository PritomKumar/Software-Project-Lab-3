import 'package:earneasy/app_screens/splash_screen.dart';
import 'package:earneasy/services/auth.dart';
import 'package:earneasy/shared/ThemeChanger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<UserMinimum>.value(
        value: AuthService().user,
        child: ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(ThemeData(
            primarySwatch: Colors.blue,
          )),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Spl3 App',
            home: SplashScreen(),
          ),
        ));
  }
}
