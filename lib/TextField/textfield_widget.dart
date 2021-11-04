import 'package:Ponto_Riobranco/SplashScreen/style.dart';
import 'package:Ponto_Riobranco/ui/shared/globals.dart';
import 'package:Ponto_Riobranco/viewmodels/login_model.dart';
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
        color: Color(0xff09a7ff),
        fontSize: 18.0,
      ),
      cursorColor: Color(0xff09a7ff),
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 28,
          color: Color(0xff09a7ff),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff09a7ff)),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 22,
            color: Color(0xff09a7ff),
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xff09a7ff),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
