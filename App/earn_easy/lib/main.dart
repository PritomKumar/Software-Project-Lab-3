import 'package:earneasy/TestPage/firemap_test_copy.dart';
import 'package:earneasy/services/auth.dart';
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spl3 App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: GeoFlutterExampleVersion2(),
        ));
  }
}
