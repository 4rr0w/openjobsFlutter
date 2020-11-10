import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openjobs/widget/CustomAlertDialog.dart';
import 'package:openjobs/widget/loader_widget.dart';
import 'package:openjobs/widget/textfield_widget.dart';

class AddSkillsView extends StatefulWidget {
  final String id;
  AddSkillsView({Key key, this.id}) : super(key: key);

  @override
  AddSkillsViewState createState() => AddSkillsViewState(id);
}

class AddSkillsViewState extends State<AddSkillsView> {
  final _skill = TextEditingController();
  final String id;
  Stream dataList;
  final databaseReference = FirebaseFirestore.instance;
  bool _invalidskill = false;

  AddSkillsViewState(this.id);

  @override
  void dispose() {
    _skill.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void showAddSkillDialog(BuildContext context) {
    _skill.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Your Skill"),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _skill,
                  hintText: "Enter Here",
                  obscureText: false,
                  prefixIconData: Icons.person,
                  textColor: Colors.black,
                  errortext: _invalidskill ? "Invalid!" : null,
                  maxlength: 30,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        elevation: 10,
                        splashColor: Colors.black,
                        color: Colors.green[900],
                        disabledColor: Colors.red[300],
                        onPressed: () async {
                          setState(() {
                            _invalidskill = !RegExp(r"^[a-zA-Z ]{4,}$")
                                .hasMatch(_skill.text);
                          });

                          if (!_invalidskill) {
                            AddSkill();
                            Navigator.of(context).pop();
                          }
                        }),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> AddSkill() async {
    await databaseReference
        .collection("Skills")
        .doc()
        .set({"Id": id, "Skill": _skill.text.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseReference
            .collection("Skills")
            .where("Id", isEqualTo: id.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null)
            return Card(
              child: Center(
                child: Text("PLEASE ADD SKILLS",
                    style: TextStyle(color: Colors.blue[800], fontSize: 40.0)),
              ),
            );
          if (snapshot.hasData)
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(document["Skill"],
                                    style: TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ]),
                          SizedBox(
                            height: 3.0,
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          else
            return Loading(color: Colors.black);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton.icon(
                onPressed: () async {
                  await showAddSkillDialog(context);
                },
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
              MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  elevation: 10,
                  splashColor: Colors.black,
                  color: Colors.green[900],
                  disabledColor: Colors.red[300],
                  onPressed: () async {}),
            ],
          ),
        ),
      ),
    );
  }
}
