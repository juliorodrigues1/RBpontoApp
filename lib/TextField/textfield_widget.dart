import 'package:RBPONTOAMAC/SplashScreen/style.dart';
import 'package:RBPONTOAMAC/ui/shared/globals.dart';
import 'package:RBPONTOAMAC/viewmodels/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final TextEditingController controller;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    // final model = new LoginModel(context);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        color: Color(0xff38c172),
        fontSize: 18.0,
      ),
      cursorColor: Color(0xff38c172),
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 28,
          color: Color(0xff38c172),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff38c172)),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 22,
            color: Color(0xff38c172),
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xff38c172),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
