import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            elevation: 15.0,
            shadowColor: Colors.green,
            color: Colors.blue,
            child: SizedBox(
              //height: MediaQuery.of(context).size.height / 2,
              child: ExpansionTile(
                title: Text("Title"),
                backgroundColor: Colors.redAccent,
                subtitle: Text("Subtitle"),
                trailing: Icon(FontAwesomeIcons.arrowDown),
                children: <Widget>[
                  ListTile(
                    title: Text("Item 1"),
                    trailing: Icon(Icons.hourglass_empty),
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    trailing: Icon(Icons.brush),
                  ),
                  ListTile(
                    title: Text("Item 3"),
                    trailing: Icon(Icons.settings_input_composite),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
