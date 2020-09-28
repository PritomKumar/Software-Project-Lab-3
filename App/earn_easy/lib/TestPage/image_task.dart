import 'package:flutter/material.dart';

class ImageTask extends StatefulWidget {
  @override
  _ImageTaskState createState() => _ImageTaskState();
}

class _ImageTaskState extends State<ImageTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.image,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Photo"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Header",
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(5.0),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: Text("Image"),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text("Image"),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text("Image"),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text("Image"),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text("Image"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
