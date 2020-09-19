import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapCustomItemBoxViewer extends StatefulWidget {
  final List<GigMini> gigs;

  const MapCustomItemBoxViewer({Key key, this.gigs}) : super(key: key);

  @override
  _MapCustomItemBoxViewerState createState() =>
      _MapCustomItemBoxViewerState();
}

class _MapCustomItemBoxViewerState extends State<MapCustomItemBoxViewer> {
  bool isExpanded = false;
  static const List<String> sortOptionsArray = ["Distance", "Money", "Title"];
  String sortOption = sortOptionsArray[0];
  String sortResult = "";

  @override
  Widget build(BuildContext context) {

    List<GigMini> gigs = widget.gigs;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.green,
        color: Colors.blue[300],
        child: ExpansionTile(
          onExpansionChanged: (bool value) {
            setState(() {
              isExpanded = value;
            });
          },
          initiallyExpanded: isExpanded,
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
    );
  }
}
