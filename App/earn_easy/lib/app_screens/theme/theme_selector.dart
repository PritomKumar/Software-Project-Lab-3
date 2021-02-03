import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/shared/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: _themeChanger.getTheme(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          drawer: SideDrawer(),
          appBar: AppBar(
            title: Text('Theme Select'),
          ),
          body: Center(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.green,
                  ),
                  title: Text("Green Theme"),
                  onTap: () => _themeChanger.setTheme(ThemeData(
                    primarySwatch: Colors.purple,
                  )),
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.blue,
                  ),
                  title: Text("Blue Theme"),
                  onTap: () => _themeChanger.setTheme(ThemeData(
                    primarySwatch: Colors.blue,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
