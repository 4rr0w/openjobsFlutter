import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openjobs/model/home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openjobs/model/user_management.dart';
import 'package:openjobs/ui/pages/add_skills.dart';
import 'package:openjobs/widget/button_widget.dart';
import 'package:openjobs/widget/loader_widget.dart';
import 'package:openjobs/widget/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _name = TextEditingController();
  final _pincode = TextEditingController();
  // ignore: deprecated_member_use
  final databaseReference = Firestore.instance;
  FlutterToast flutterToast;

  bool loading = false;
  bool _invalidName = false;
  bool _invalidPinCode = false;
  var pinlocation;

  @override
  void dispose() {
//   _phone.dispose();

    _name.dispose();
    _pincode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.toString());

    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    debugPrint("${first.postalCode}");

    _pincode.text = first.postalCode;
  }

  Future<void> signUp() async {
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      String id = firebaseUser.uid;
      var addresses =
          await Geocoder.local.findAddressesFromQuery('India,' + _pincode.text);
      var address = addresses.first;
      String locality = address.locality;
      String postalCode = address.postalCode;

      await databaseReference.collection("Users").document(id).setData({
        'Name': _name.text.toString(),
        'PinCode': _pincode.text.toString(),
        'Address': "${address.addressLine}, ${address.subAdminArea}",
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddSkillsView()),
      );
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextFieldWidget(
                          controller: _name,
                          hintText: 'Full Name',
                          textColor: Colors.black,
                          obscureText: false,
                          prefixIconData: Icons.person,
                          errortext: _invalidName ? "Invalid Name!" : null,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldWidget(
                          controller: _pincode,
                          hintText: 'Area Pin Code',
                          textColor: Colors.black,
                          obscureText: false,
                          prefixIconData: Icons.location_city_outlined,
                          maxlength: 6,
                          errortext:
                              _invalidPinCode ? "Invalid Pincode!" : null,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              getLocation();
                            },
                            child: Text(
                              "Detect Location",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Column(
                          children: [
                            Material(
                              elevation: 15.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    _invalidName = !RegExp(r"^[a-zA-Z ]{4,}$")
                                        .hasMatch(_name.text);
                                    _invalidPinCode = !RegExp(r"^[0-9]{6}$")
                                        .hasMatch(_pincode.text);
                                  });

                                  try {
                                    pinlocation = await Geocoder.local
                                        .findAddressesFromQuery(
                                            'India,' + _pincode.text);
                                  } on Exception catch (e) {
                                    print(e);
                                    setState(() {
                                      _invalidPinCode = true;
                                    });
                                  }

                                  if (!_invalidName) {
                                    setState(() {
                                      loading = true;
                                    });
                                    signUp();
                                  }
                                },
                                child: ButtonWidget(
                                  title: 'Next',
                                  hasBorder: false,
                                  background: Colors.green,
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
