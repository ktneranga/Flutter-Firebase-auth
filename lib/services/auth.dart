import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // firebase instance
  // final means it's not gonna change in the future
  // _auth is a private property, private properties can only use withing this class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create a user from firebase user with userid
  UserModel? _userFromUserCredentials(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create the stream for checking the auth changes
  // in dart getters are denoted without paranthesis because getters doesn't take paranthesis
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromUserCredentials);
  }

  // sign in anonymous
  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      print("stream ${this.user}");
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // google sign in
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential result =
          await _auth.signInWithCredential(credential);
      final User? user = result.user;
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
