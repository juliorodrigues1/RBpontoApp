import 'dart:convert';
import 'package:RBPONTOAMAC/button/button_pdf.dart';
import 'package:RBPONTOAMAC/model/user.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:RBPONTOAMAC/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Point extends StatefulWidget {
  const Point({Key key}) : super(key: key);

  @override
  _PointState createState() => _PointState();
}

class _PointState extends State<Point> {
  String latitudeData = "";
  String longitudeData = "";
  List work_day = [];

  Future<User> _getSavedUserMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString(PreferencesKeys.activeUser);

    Map<String, dynamic> mapUser = json.decode(jsonUser);
    User user = User.fromJson(mapUser);
    return user;
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (this.mounted) {
      setState(() {
        latitudeData = '${geoposition.latitude}';
        longitudeData = '${geoposition.longitude}';
      });
    }

  }

  _salvar() async {
    Database db = await recuperarBancoDados();
    User user = await _getSavedUserMemory();
    getCurrentLocation();

    Map<String, dynamic> dados = {
      "employ_id" : int.tryParse(user.employ_id),
      "lat" : latitudeData,
      "long" : longitudeData,
      "point": DateTime.now().toString()
    };
    int id = await db.insert("work_days", dados);
    if(id >= 1){
      showAlertDialogSucess();
    }else{
      showAlertDialog1();
    }
  }

  showAlertDialog1() {
    // configura o button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
        child: Text("Fechar"),
        onPressed: () {
          Navigator.pop(context, 'Fechar');
        });
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("erro"),
      content: Text("Não foi possivel registrar seu ponto"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialogSucess() {
    // configura o button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, 'OK');
        });
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Sucesso"),
      content: Text("Seu ponto foi registrado com sucesso"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  _listar() async {
    Database db = await recuperarBancoDados();
    User user = await _getSavedUserMemory();
    String sql = "SELECT * FROM work_days WHERE employ_id = " + user.employ_id;
    List wor_day = await db.rawQuery(sql);
    return wor_day;
  }

  @override
  Widget build(BuildContext context) {
    _listar();
    return  Scaffold(appBar: PreferredSize(
      preferredSize: Size.fromHeight(200),
      child: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            )),
        backgroundColor: Color(0xff38c172),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo-amac.png'), scale: 2)),
        ),
      ),
    ),
        body: Column(
          children: [
            Card(
              color: Colors.white,
              child: Text('Registro do Dia',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 6
                      ..color = Colors.black,
                  )),
            ),
            Card(
              child: Row(
                children: [
                  Image.asset('assets/icons/Ellipse 1.png',
                      width: 50, height: 50),
                  Text('Não há registro')
                ],
              ),
            ),
            //output
            Card(
              child: Row(
                children: [
                  Image.asset('assets/icons/Ellipse 1 (1).png',
                      width: 50, height: 50),
                  Text( 'Não há registro')
                ],
              ),
            ),
            //entry
            Card(
              child: Row(
                children: [
                  Image.asset('assets/icons/Ellipse 1.png',
                      width: 50, height: 50),
                  Text('Não há registro')
                ],
              ),
            ),
            //output
            Card(
              child: Row(
                children: [
                  Image.asset('assets/icons/Ellipse 1 (1).png',
                      width: 50, height: 50),
                  Text('Não há registro')
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
                alignment:Alignment.center,
              child: ButtonWidget(
                text: 'Rgistrar Ponto Offline',
                onClicked: _salvar,
              ),
            )

          ]
        )
    );
  }
}
