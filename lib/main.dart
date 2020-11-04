import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'model/firebase_init.dart';
import 'package:provider/provider.dart';
import 'model/home_model.dart';
import 'model/user_management.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => FirebaseInit().initFirebase(),
        },
      ),
    );
  }
}
