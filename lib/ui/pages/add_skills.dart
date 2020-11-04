import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSkillsView extends StatefulWidget {
  AddSkillsView({Key key}) : super(key: key);

  @override
  AddSkillsViewState createState() => AddSkillsViewState();
}

class AddSkillsViewState extends State<AddSkillsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: RaisedButton.icon(
                        onPressed: () {},
                        elevation: 2.0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        color: const Color(0xFFFFB822),
                        icon: Icon(Icons.add),
                        label: Text(
                          "Add Skill",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
