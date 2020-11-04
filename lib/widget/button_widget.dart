import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Color textColor, background;

  ButtonWidget({
    this.title,
    this.hasBorder,
    this.textColor,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: this.background,
      elevation: 15.0,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        splashColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50.0,
          child: Center(
            child: Text(title,
                style: TextStyle(
                  color: this.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                )),
          ),
        ),
      ),
    );
  }
}
