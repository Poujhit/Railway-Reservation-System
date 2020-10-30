import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  String userName;
  String profileUrl;
  String userid; //this is the email
  String token; //this is the token generated.
  String userId;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool get isAuth {
    print(userId);
    return userId != null;
  }

  Future<bool> autoLogin() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    if (!s.containsKey('user') && !s.containsKey('pu')) {
      var p = s.getString('user');
      print('1:$p');
      return false;
    }
    userId = s.getString('user');
    profileUrl = s.getString('pu');
    userName = s.getString('name');
    print(s.getString('user'));
    print(s.getString('pu'));
    notifyListeners();
    return true;
  }

  Future<void> authenticate() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication gs = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: gs.idToken,
        accessToken: gs.accessToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      User user = _auth.currentUser;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user', user.uid.toString());
      userId = pref.getString('user');

      userid = user.email;
      pref.setString('pu', user.photoURL.toString());
      profileUrl = pref.getString('pu');
      pref.setString('name', user.displayName);
      userName = pref.getString('name');
      token = user.uid;

      print(user);
      notifyListeners();
    } else
      Fluttertoast.showToast(msg: 'Login to use!', toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> signOut() async {
    //await googleSignIn.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checklogout = await pref.clear();
    checklogout ? Fluttertoast.showToast(msg: 'User Credentials cleared') : Fluttertoast.showToast(msg: 'error');

    await googleSignIn.disconnect();
  }
}
