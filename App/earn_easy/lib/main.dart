import 'package:earneasy/app_screens/splash_screen.dart';
import 'package:earneasy/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_screens/theme/theme_changer.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String host = Platform.isAndroid ? '10.0.2.2:8888' : 'localhost:8888';
  // FirebaseFirestore.instance.settings = Settings(
  //   host: host,
  //   sslEnabled: false,
  // );
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
            primarySwatch: Colors.green,
          )),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Spl3 App',
            home: SplashScreen(),
          ),
        ));
  }
}
