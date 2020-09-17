import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool isExpanded = false;
  static const List<String> sortOptionsArray = ["Distance", "Money", "Title"];
  String sortOption = sortOptionsArray[0];
  String sortResult = "";
  final gigs = [
    GigMini(
      title: "First",
      money: 100,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Second",
      money: 200,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Third",
      money: 300,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Fourth",
      money: 400,
      gigId: "fsdfuhfsjkdfhu",
    )
  ];

  @override
  Widget build(BuildContext context) {
    //sort function
    //gigs.sort((a, b) => b.money.compareTo(a.money));
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
              onExpansionChanged: (bool value) {
                setState(() {
                  isExpanded = value;
                });
              },
              title: Text("Title"),
              backgroundColor: Colors.white,
              subtitle: Text("Subtitle "),
              trailing: SizedBox(
                width: 120.0,
                child: PopupMenuButton(
                  elevation: 5.0,
                  enabled: isExpanded,
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        sortResult == "" ? "Sort By" : sortOption,
                        textScaleFactor: 1.15,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.sort,
                        size: 30.0,
                      ),
                    ],
                  ),
                  itemBuilder: (context) {
                    return sortOptionsArray.map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  onSelected: (value) {
                    setState(() {
                      sortOption = value;
                      sortResult = value;
                      print(sortOption);
                      switch (sortOption) {
                        case "Distance":
                          gigs.sort((a, b) => b.money.compareTo(a.money));
                          break;
                        case "Money":
                          gigs.sort((a, b) => b.money.compareTo(a.money));
                          break;
                        case "Title":
                          gigs.sort((a, b) => a.title.compareTo(b.title));
                          break;
                        default:
                          gigs.sort((a, b) => b.money.compareTo(a.money));
                          break;
                      }
                    });
                  },
                ),
              ),
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
