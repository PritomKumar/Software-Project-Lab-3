import 'package:earneasy/app_screens/gigs/gig_page.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:flutter/material.dart';

class MapCustomItemBoxViewer extends StatefulWidget {
  final List<GigMini> gigs;

  const MapCustomItemBoxViewer({Key key, this.gigs}) : super(key: key);

  @override
  _MapCustomItemBoxViewerState createState() => _MapCustomItemBoxViewerState();
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
        color: Theme.of(context).primaryColorLight,
        child: ExpansionTile(
          onExpansionChanged: (bool value) {
            print(
                "Expansion tile color = ${Theme.of(context).primaryColorLight}");
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
                      gigs.sort((a, b) => a.distance.compareTo(b.distance));
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
                shrinkWrap: true,
                itemCount: gigs.length,
                itemBuilder: (context, index) {
                  //TODO Have to use custom stateless widget instead of ListTile
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          gigs[index].title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),

                        dense: true,
                        //TODO Subtitle with location name from google
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "\u0024 " + gigs[index].money.toString(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              gigs[index].distance > 1.0
                                  ? gigs[index].distance.round().toString() +
                                      " km"
                                  : (gigs[index].distance * 1000)
                                          .round()
                                          .toString() +
                                      " m",
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          var gig = await DatabaseServiceGigs()
                              .getGigFromGigID(gigs[index].gigId);
                          if (gig != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GigPage(
                                    gig: gig,
                                  ),
                                ));
                          }
                        },
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
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
