import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//#region Task Types

const String ImageTaskType = "ImageTask";
const String CheckBoxTaskType = "CheckBoxTask";
const String MultipleChoiceTaskType = "MultipleChoiceTask";
const String DropdownTaskType = "DropdownTask";
const String FreeTextTaskType = "FreeTextTask";

const List<String> TaskTypeDropdownList = [
  ImageTaskType,
  CheckBoxTaskType,
  MultipleChoiceTaskType,
  DropdownTaskType,
  FreeTextTaskType
];

//endregion

//#region Testing
const String VeryLongTextForTestingPurpose =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sapien nibh, placerat at ligula vel, iaculis pulvinar tellus. Cras aliquet cursus justo, eu commodo ligula pulvinar ac. Duis arcu nulla, sagittis sed elit porta, interdum consequat elit. Phasellus rhoncus maximus pharetra. Vivamus commodo eu mi sed luctus. Vivamus varius, nibh at vestibulum tempor, quam felis molestie nunc, at elementum nisi sapien ac eros. Donec vehicula elit non felis fermentum, non porta ligula rutrum. Nullam viverra orci eu mauris feugiat, eget convallis ex imperdiet. Donec dapibus sed dui ut iaculis. In pulvinar sapien id sapien laoreet, ac vulputate mauris condimentum. Nunc quis fermentum tellus. In eget hendrerit lectus, ut congue massa. Integer blandit est ac odio posuere sollicitudin eu quis ante. Donec tempus, tortor ut lobortis pretium, mauris dolor semper augue, eu hendrerit libero ipsum id dui. Ut ac ex sed dui dignissim lobortis sed quis metus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin ac ipsum porttitor, vehicula leo at, tempor mauris. Nam nec lorem velit. Pellentesque sed augue eget orci tincidunt porttitor. Mauris dapibus elit nibh, vel pulvinar lacus interdum vitae. Fusce imperdiet dui lectus, a hendrerit est ullamcorper bibendum. Sed semper tempus tortor, sit amet consequat erat blandit in. Fusce condimentum ipsum imperdiet magna dapibus, eget scelerisque neque volutpat. In faucibus neque mollis, aliquam urna eu, dapibus elit. Sed nec urna euismod, mollis arcu pellentesque, luctus nisl. Nam maximus aliquet pharetra. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc elementum ultricies ligula et mattis. Phasellus vitae lectus mi. Etiam convallis accumsan tincidunt. Curabitur gravida interdum egestas. Maecenas luctus convallis risus, et ornare diam pellentesque ac. Sed ut ligula ut ante molestie pellentesque. Donec ut quam nec erat pulvinar facilisis. Mauris id efficitur leo. Nunc ut convallis ligula, at gravida ligula. Proin sodales, nisl a molestie faucibus, urna tortor ultrices dui, in varius ligula nisl at felis. Suspendisse dignissim est id arcu porttitor pellentesque. Sed ut purus faucibus metus interdum mollis at in ante. ";
//#endregion

//#region Firebase Default
Timestamp defaultInitializedTimestamp =
    Timestamp.fromDate(DateTime(1000, 1, 1));
final String userUid = FirebaseAuth.instance.currentUser.uid;
final CollectionReference fireStoreUsersRef =
    FirebaseFirestore.instance.collection("Users");
final CollectionReference fireStoreGigsRef =
    FirebaseFirestore.instance.collection("Gigs");
//#endregion

//#region Decorations
const emailInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintText: "Email",
  filled: true,
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
  prefixIcon: Icon(FontAwesomeIcons.solidEnvelope, color: Colors.greenAccent),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
  errorStyle: TextStyle(
    color: Colors.deepPurpleAccent,
  ),
);

const passwordInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintText: "Password",
  filled: true,
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
  prefixIcon: Icon(
    FontAwesomeIcons.lock,
    color: Colors.redAccent,
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
  errorStyle: TextStyle(
    color: Colors.deepPurpleAccent,
  ),
);

//#endregion
