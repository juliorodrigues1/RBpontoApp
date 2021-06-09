import 'dart:convert';
import 'dart:developer';

import 'package:Ponto_App/TextField/textfield_widget.dart';
import 'package:Ponto_App/button/button_widget.dart';
import 'package:Ponto_App/controller/Uplogin.dart';
import 'package:Ponto_App/model/user.dart';
import 'package:Ponto_App/ui/shared/globals.dart';
import 'package:Ponto_App/values/preferences_keys.dart';
import 'package:Ponto_App/viewmodels/login_model.dart';
import 'package:Ponto_App/viewmodels/wave_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:Ponto_App/model/employ.dart' as employ_global;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String login = '';
  String senha = '';
  String error = '';

  bool _isInAsyncCall = false;

  TextEditingController loginInputController = TextEditingController();
  TextEditingController senhaInputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _setLogin();
    super.initState();
  }

  void _setLogin() async {
    User user = await _getSavedUserMemory();
    this.loginInputController.text = user.user;
    this.senhaInputController.text = user.password;

    employ_global.user = user.user;
    employ_global.password = user.password;
  }

  Future<User> _getSavedUserMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString(PreferencesKeys.activeUser);
    print(jsonUser);

    Map<String, dynamic> mapUser = json.decode(jsonUser);
    User user = User.fromJson(mapUser);
    return user;
  }

  up() {
    Uplogin logar = new Uplogin();
    logar.login = employ_global.user;
    logar.password = employ_global.password;
    logar.Login(logar.password, logar.login, this.context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: ModalProgressHUD(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: buildFormLogin(context),
        ),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.7,
        progressIndicator: SizedBox(
          height: 300.0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.cyanAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Aguarde enquanto estamos validando.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormLogin(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    // final model = Navigator.push(context, MaterialPageRoute(builder: (context) => LoginModel()));
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    var senha2 = senha;
    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 200),
            // width: double.infinity,
            height: size.height - 200,
            color: Global.mediumBlue,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 2.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/branca.png',
                  width: 200,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  controller: loginInputController,
                  hintText: 'Usuário',
                  obscureText: false,
                  prefixIconData: Icons.account_circle_outlined,
                  suffixIconData: model.isValid ? Icons.check : null,
                  onChanged: (value) {
                    model.isValidEmail(value);
                    employ_global.user = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFieldWidget(
                  controller: senhaInputController,
                  hintText: 'Senha',
                  obscureText: model.isVisible ? false : true,
                  prefixIconData: Icons.lock_outline,
                  suffixIconData:
                      model.isVisible ? Icons.visibility : Icons.visibility_off,
                  onChanged: (value) {
                    employ_global.password = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                    onPressed: up,
                    child: ButtonWidget(
                      title: 'Entrar',
                      hasBorder: false,
                    ))
                // ButtonWidget(
                //   title: 'Entrar',
                //   hasBorder: false,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
