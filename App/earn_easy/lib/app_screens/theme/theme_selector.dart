import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/app_screens/map/google_map_gig.dart';
import 'package:earneasy/app_screens/theme/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// import 'file:///F:/SPL3/App/earn_easy/lib/app_screens/theme/theme_changer.dart';

class ThemeSelector extends StatefulWidget {
  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  Future<bool> _onWillPop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoogleMaps()));
    return true;
  }

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
                    primarySwatch: Colors.green,
                    buttonColor: Colors.deepPurpleAccent,
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
                    buttonColor: Colors.pink,
                  )),
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.red,
                  ),
                  title: Text("Red Theme"),
                  onTap: () => _themeChanger.setTheme(ThemeData(
                    primarySwatch: Colors.red,
                    buttonColor: Colors.blueAccent,
                  )),
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.yellow,
                  ),
                  title: Text("Yellow Theme"),
                  onTap: () => _themeChanger.setTheme(ThemeData(
                    primarySwatch: Colors.yellow,
                    buttonColor: Colors.orangeAccent,
                  )),
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Deep Purple Theme"),
                  onTap: () => _themeChanger.setTheme(ThemeData(
                    primarySwatch: Colors.deepPurple,
                    buttonColor: Colors.deepPurpleAccent,
                  )),
                ),
                // Text(
                //   "Primay color = ${Theme.of(context).primaryColor}",
                //   style: TextStyle(
                //     color: Theme.of(context).primaryColor,
                //     fontSize: 30.0,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
