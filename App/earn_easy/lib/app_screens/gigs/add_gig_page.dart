
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GigAdd extends StatefulWidget {
  //final LatLng location;

  const GigAdd({Key key}) : super(key: key);
  @override
  _GigAddState createState() => _GigAddState();
}

class _GigAddState extends State<GigAdd> {
  //final LatLng location;
  final _formKey = GlobalKey<FormState>();
  var moneyController = TextEditingController();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  bool isloading = false;

  _GigAddState();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserAccount>(context);
    setState(() {
      if (user != null) {
        isloading = true;
      }
    });

    if (isloading) {
      // titleController.text = user.firstName;
      // descriptionController.text = user.lastName;
      // moneyController.text = user.email;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Add Gig'),
          ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Money :",
                          style: TextStyle(fontSize: size.width / 25),
                        ),
                        SizedBox(
                          width: size.width / 40,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: moneyController,
                            decoration: InputDecoration(hintText: "Money"),
                            validator: (value) {
                              return value.isEmpty ? "Enter Money" : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Title :",
                          style: TextStyle(fontSize: size.width / 25),
                        ),
                        SizedBox(
                          width: size.width / 40,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(hintText: "Gig Title"),
                            validator: (value) {
                              return value.isEmpty ? "Enter your gig title" : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Description :",
                          style: TextStyle(fontSize: size.width / 25),
                        ),
                        SizedBox(
                          width: size.width / 40,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(hintText: "Gig description"),
                            validator: (value) {
                              return value.isEmpty ? "Enter gig description" : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // TODO : Complete Gig update
                        // gigId: doc.data()['gigId'],
                        // money: doc.data()['money'],
                        // location: doc.data()['location'],
                        // title: doc.data()['title'],
                        // description: doc.data()['description'],
                        // startTime: doc.data()['startTime'],
                        // endTime: doc.data()['endTime'],
                        // providerId: doc.data()['providerId'],
                        // type: doc.data()['type'],

                        if (_formKey.currentState.validate()) {
                          await DatabaseServiceGigs().createNewGig(Gig(
                            money: int.parse(moneyController.text.toString()) ?? 0,
                            title: titleController.text ?? "",
                            description: descriptionController.text ?? "",
                            providerId: user.uid,

                          ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}