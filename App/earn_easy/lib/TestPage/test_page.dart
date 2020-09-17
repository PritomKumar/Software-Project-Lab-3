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
    bool isExpanded = false;
    List<String> sortOptionsArray = ["Distance", "Money", "Title"];
    String sortOption = sortOptionsArray[0];
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
              onExpansionChanged: (value) {
                setState(() {
                  isExpanded = value;
                  print(isExpanded);
                });
              },
              title: Text("Title"),
              backgroundColor: Colors.white,
              subtitle: Text("Subtitle"),
              trailing: SizedBox(
                width: 100.0,
                child: Expanded(
                  child: PopupMenuButton(
                    initialValue: "Sort By",
                    tooltip: "Sort Items",
                    elevation: 5.0,
                    enabled: isExpanded,
                    icon: Icon(Icons.sort,size: 30.0,),
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
                      });
                    },
                  ),
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
