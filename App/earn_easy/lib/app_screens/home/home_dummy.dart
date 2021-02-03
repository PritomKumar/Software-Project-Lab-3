import 'package:earneasy/models/gig.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/shared/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///F:/IIT%207th%20Semester/SPL3/Software-Project-Lab-3/App/earn_easy/lib/app_screens/map/google_map_gig.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return StreamProvider<List<Gig>>.value(
        value: DatabaseServiceGigs().allGigData,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: _themeChanger.getTheme(),
          home: GoogleMaps(),
        ));
  }
}


