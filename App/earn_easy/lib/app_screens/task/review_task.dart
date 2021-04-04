import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';

class ReviewTask extends StatefulWidget {
  final List<GigMini> gigMiniList;

  const ReviewTask({Key key, this.gigMiniList}) : super(key: key);

  @override
  _ReviewTaskState createState() => _ReviewTaskState();
}

class _ReviewTaskState extends State<ReviewTask> {
  _checkTask(int index) async {
    var userResponse = await fireStoreUsersRef
        .doc(userUid)
        .collection("submittedResponse")
        .doc(widget.gigMiniList[index].gigId)
        .get()
        .then((value) {
      if (value.exists) {
        return UserResponse.fromMap(value.data());
      } else {
        return null;
      }
    });

    if (userResponse == null) {
      showNeutralToast("No response for this task yet!");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskListPage(
              userResponse: userResponse,
            ),
          ));
    }
  }

  List<UserResponse> userResponseList = <UserResponse>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Review Task'),
          ),
          body: widget.gigMiniList.length == 0
              ? Center(
                  child: Container(
                    child: Text(
                      'No task to review!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.gigMiniList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      elevation: 5.0,
                      shadowColor: Colors.black54,
                      child: ListTile(
                        onTap: () async {
                          await _checkTask(index);
                        },
                        leading: Text(
                          "\u0024 " +
                              widget.gigMiniList[index].money.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                        title: Text(
                          widget.gigMiniList[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
