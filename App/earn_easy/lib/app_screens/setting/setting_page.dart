import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/app_screens/map/google_map_gig.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<bool> _onWillPop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoogleMaps()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        theme: Theme.of(context),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
              title: Text('Setting'),
            ),
            body: Center(
              child: Container(
                child: Text('Setting'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
