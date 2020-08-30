import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserAccount _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null
        ? UserAccount(
            uid: firebaseUser.uid ?? "",
            name: firebaseUser.displayName ?? "",
            email: firebaseUser.email ?? "",
            photoUrl: firebaseUser.photoURL ?? "")
        : null;
  }

  Stream<UserAccount> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService().updateUserData(_userFromFirebaseUser(user));
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
      await DatabaseService().updateUserData(_userFromFirebaseUser(user));
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogleAuth() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;
      await DatabaseService().updateUserData(_userFromFirebaseUser(user));
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
      await DatabaseService().updateUserData(_userFromFirebaseUser(user));
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
//      bool googleIsSighnedIn = await _googleSignIn.isSignedIn();
//      if (googleIsSighnedIn == true) {
//        await _googleSignIn.signOut();
//      }
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
