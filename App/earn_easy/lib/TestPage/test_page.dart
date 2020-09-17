import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    List<GigMini> gigs = List<GigMini>();
    gigs.add(GigMini(
      title: "First",
      money: 100,
      gigId: "fsdfuhfsjkdfhu",
    ));
    gigs.add(GigMini(
      title: "Second",
      money: 200,
      gigId: "fsdfuhfsjkdfhu",
    ));
    gigs.add(GigMini(
      title: "Third",
      money: 300,
      gigId: "fsdfuhfsjkdfhu",
    ));
    gigs.add(GigMini(
      title: "Fourth",
      money: 400,
      gigId: "fsdfuhfsjkdfhu",
    ));
    //sort function
    gigs.sort((a, b) => a.money.compareTo(b.money));
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
            child: ExpansionTile(
              title: Text("Title"),
              backgroundColor: Colors.white,
              subtitle: Text("Subtitle"),
              trailing: Icon(FontAwesomeIcons.arrowDown),
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemCount: gigs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(gigs[index].title),
                        subtitle: Text("TODO"),
                        trailing: Text(
                          gigs[index].money.toString(),
                          textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: true,
                            applyHeightToLastDescent: true,
                          ),
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          print(gigs[index].toMap());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
