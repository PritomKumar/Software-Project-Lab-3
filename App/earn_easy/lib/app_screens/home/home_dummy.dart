
import 'package:earneasy/app_screens/gigs/gig_page.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Gig>>.value(
    value: DatabaseServiceGigs().allGigData,
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: GoogleMaps(),
    ));
  }
}


