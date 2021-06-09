import 'package:Ponto_App/ui/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginModel extends ChangeNotifier {
  //LoginModel(BuildContext context);


  get isVisible => _isVisible;
  bool _isVisible = false;
  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;
  void isValidEmail(String input){
    if(input == Global.validEmail.first){
      _isValid = true ;
    }else{
      _isValid = false;
    }
    notifyListeners();
  }
}
