import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserMinimum _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null
        ? UserMinimum(
            uid: firebaseUser.uid ?? "",
            firstName: firebaseUser.displayName != null
                ? firebaseUser.displayName
                    .substring(0, firebaseUser.displayName.indexOf(" "))
                : "",
            lastName: firebaseUser.displayName != null
                ? firebaseUser.displayName
                    .substring(firebaseUser.displayName.indexOf(" ") + 1)
                : "",
            email: firebaseUser.email ?? "",
            photoUrl: firebaseUser.photoURL ?? "",
          )
        : null;
  }

  UserAccount _userAccountFromUserMinimum(User firebaseUser) {
    return firebaseUser != null
        ? UserAccount(
            uid: firebaseUser.uid ?? "",
            firstName: firebaseUser.displayName != null
                ? firebaseUser.displayName
                    .substring(0, firebaseUser.displayName.indexOf(" "))
                : "",
            lastName: firebaseUser.displayName != null
                ? firebaseUser.displayName
                    .substring(firebaseUser.displayName.indexOf(" ") + 1)
                : "",
            email: firebaseUser.email ?? "",
            photoUrl: firebaseUser.photoURL ?? "",
          )
        : null;
  }

  Stream<UserMinimum> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (DatabaseService().userData == null) {
        await DatabaseService()
            .updateUserData(_userAccountFromUserMinimum(user));
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (DatabaseService().userData == null) {
        await DatabaseService()
            .updateUserData(_userAccountFromUserMinimum(user));
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future _checkIfUserDataExists()async {
    return DatabaseService().userData;
  }

  Future signInWithGoogleAuth() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;
      final userDataIshere = await _checkIfUserDataExists();
      print("before userDataIshere " );
      print(userDataIshere);
      if (userDataIshere == null) {
        print("After userDataIshere");
        await DatabaseService()
            .updateUserData(_userAccountFromUserMinimum(user));
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      if (DatabaseService().userData == null) {
        await DatabaseService()
            .updateUserData(_userAccountFromUserMinimum(user));
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
