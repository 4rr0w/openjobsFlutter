import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:openjobs/HomeScreen.dart';
import 'package:openjobs/ui/pages/add_details.dart';
import 'package:openjobs/widget/loader_widget.dart';
import '../LoginScreen.dart';

class UserManagement {
  Widget handleAuth() {
    return new StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
//            FirebaseAuth.instance.signOut();
            return Loading();
          }
          if (snapshot.hasData) {
            return SignupView();
          }
          return LoginScreen();
        });
  }
}
