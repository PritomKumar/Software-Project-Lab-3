import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTask extends StatefulWidget {
  @override
  _ImageTaskState createState() => _ImageTaskState();
}

class _ImageTaskState extends State<ImageTask> {
  bool isItemAvailable = false;
  Future<void> _selectImageSource() async{
    switch(await showDialog(context: context,builder: (context) {
      return SimpleDialog(
        title: Text("Choose Option "),
        elevation: 5.0,
        children: <Widget>[
          SimpleDialogOption(
            child: Row(children: <Widget>[
              Icon(Icons.photo_camera , size: 30.0,),
              SizedBox(width: 10.0,),
              Text("Take a photo"),
            ],),
            onPressed: () {
              print("Camera");
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Row(children: <Widget>[
              Icon(Icons.photo_camera , size: 30.0,),
              SizedBox(width: 10.0,),
              Text("Browse gallery"),
            ],),
            onPressed: () {
              print("Gallery");
              Navigator.pop(context);
            },
          ),
        ],
      );
    },)){}
  }
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
            // Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: GridView.count(
            //     physics: ScrollPhysics(),
            //     crossAxisCount: 3,
            //     padding: EdgeInsets.all(5.0),
            //     crossAxisSpacing: 8.0,
            //     mainAxisSpacing: 20.0,
            //     shrinkWrap: true,
            //     children: <Widget>[
            //       Card(
            //         child: GridTile(
            //           footer: Text("footer"),
            //           header: Text("Header"),
            //           child: Container(
            //             color: Colors.blue,
            //             margin: EdgeInsets.symmetric(vertical: 15.0),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         color: Colors.red,
            //         child: Text("Image"),
            //       ),
            //       Container(
            //         color: Colors.red,
            //         child: Text("Image"),
            //       ),
            //       Container(
            //         color: Colors.red,
            //         child: Text("Image"),
            //       ),
            //       Container(
            //         color: Colors.red,
            //         child: Text("Image"),
            //       ),
            //       Container(
            //         color: Colors.red,
            //         child: Text("Image"),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 5 + 1,
                // +1 for the special case
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? 3
                        : 4),
                itemBuilder: (BuildContext context, int index) {
                  return isItemAvailable
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Stack(
                            fit: StackFit.expand,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                child: Card(
                                  elevation: 5.0,
                                  shadowColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: GridTile(
                                    footer: Text("footer"),
                                    header: Text("Header"),
                                    child: Container(
                                      color: Colors.blue,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -20.0,
                                right: -20.0,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: Card(
                            elevation: 5.0,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            borderOnForeground: true,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[600],
                              ),
                              iconSize: 50.0,
                              splashColor: Colors.green,
                              onPressed: () {
                                  _selectImageSource();
                              },
                            ),
                          ),
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
