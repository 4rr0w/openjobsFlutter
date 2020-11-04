import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:openjobs/model/user_management.dart';
import 'package:openjobs/widget/loader_widget.dart';
import '../LoginScreen.dart';

class FirebaseInit {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Widget initFirebase() {
    return new FutureBuilder(

        // ignore: deprecated_member_user
        future: _initialization,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //FirebaseAuth.instance.signOut();
            return Loading();
          }
          if (snapshot.hasData) {
            return UserManagement().handleAuth();
          }
          return LoginScreen();
        });
  }
}
