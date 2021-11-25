import 'dart:convert';
import 'package:RBPONTOAMAC/model/user.dart';
import 'package:RBPONTOAMAC/pages/home.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Uplogin {
  String _login;
  String _password;
  String employId;

  String get login => _login;

  set login(String value) {
    _login = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  void _saveUserMemory(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.activeUser, json.encode(user.toJson()));
  }

  Future Login(_login, _password, context) async {
    try {

      var url = Uri.https(PreferencesKeys.apiURL, '/api/login');
      // var url = Uri.http(PreferencesKeys.apihomologa, '/api/login');
      var response = await http
          .post(url, body: {'email': this._login, 'password': this._password});
      print(jsonDecode(response.body));
      if (jsonDecode(response.body) ==
          'Usuário/Email e senha estão incorretos.') {
        return false;
      }

      String employId = jsonDecode(response.body)['user']['people']
              ['people_employ']['employ_id'].toString();
      if (employId != null) {
        User user = User(user: this._login, password: this._password, employ_id: employId);
        _saveUserMemory(user);
      }
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    employID: employId,
                  )));
    } catch (e) {
      return e.toString();
    }
  }
}
