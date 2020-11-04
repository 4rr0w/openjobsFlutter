import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openjobs/model/home_model.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final int maxlength;
  final bool typeNum;
  final bool box;
  final Color textColor;
  final bool enabled;
  final TextEditingController controller;
  final String errortext;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText: false,
    this.onChanged,
    this.maxlength,
    this.typeNum: false,
    this.box: false,
    this.enabled: true,
    this.textColor: Colors.white,
    this.controller,
    this.errortext,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    TextInputType Box() {
      if (box)
        return TextInputType.multiline;
      else if (typeNum)
        return TextInputType.number;
      else
        return TextInputType.text;
    }

    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: !obscureText && box ? null : 1,
      inputFormatters: [LengthLimitingTextInputFormatter(maxlength)],
      obscureText: box ? false : obscureText,
      keyboardType: Box(),
      cursorColor: textColor,
      decoration: InputDecoration(
        errorText: errortext,
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              model.isVisible = !model.isVisible;
            },
            child: Icon(
              suffixIconData,
              size: 18,
              color: enabled ? Colors.black : Colors.grey,
            )),
        labelStyle: TextStyle(color: textColor),
      ),
    );
  }
}
