import 'dart:convert';

import 'package:Ponto_App/model/workDay.dart';
import 'package:Ponto_App/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Ponto_App/global/variables.dart' as variables_global;
import 'package:Ponto_App/model/employ.dart' as employ_global;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeBar extends StatefulWidget {
  @override
  _HomeBar createState() => _HomeBar();
}

class _HomeBar extends State<HomeBar> {
  WorkDay workDay;

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setState(() {
      variables_global.isInAsyncCall = false;
      _getWorkDay();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<Map> listWorkDay() async {
    var url = Uri.http(PreferencesKeys.apiURL, "/api/employ/workday");
    var response = await http.post(url, body: {
      'employ_id': employ_global.employ_id,
    });
    Map<String, dynamic> mapWorkDay = json.decode(response.body);
    return mapWorkDay;
  }

  void _getWorkDay() async {
    Map mapWorkDay = await listWorkDay();
    WorkDay workDayConvert = WorkDay.fromJson(mapWorkDay);
    setState(() {
      this.workDay = workDayConvert;
    });
  }

  void _getEmotion(int id) {
    setState(() {
      employ_global.emoticons = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, condition) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Image.asset("assets/branca.png"),
            ),
          )
        ];
      },
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Humor Neste Momento',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => _getEmotion(1),
                  heroTag: 'button1',
                  backgroundColor: Colors.green,
                  splashColor: Colors.white,
                  child: Image.asset("assets/icons/feliz.png",
                      width: 60, height: 50),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                FloatingActionButton(
                  onPressed: () => _getEmotion(2),
                  heroTag: 'button2',
                  backgroundColor: Colors.blue,
                  splashColor: Colors.white,
                  child: Image.asset('assets/icons/neutro.png',
                      width: 50, height: 50),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                FloatingActionButton(
                  onPressed: () => _getEmotion(3),
                  heroTag: 'button3',
                  backgroundColor: Colors.red[900],
                  splashColor: Colors.white,
                  child: Image.asset('assets/icons/raiva.png',
                      width: 55, height: 50),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                FloatingActionButton(
                  onPressed: () => _getEmotion(4),
                  heroTag: 'button4',
                  backgroundColor: Colors.black,
                  splashColor: Colors.white,
                  child: Image.asset('assets/icons/triste.png',
                      width: 55, height: 50),
                ),
                SizedBox(height: 20),
              ],
            ),
            SizedBox(height: 20),
            Text('Registro do Dia',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              child: _itemBuilder(context, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return this.workDay != null
        ? Column(
            children: [
              //entry
              Card(
                child: Row(
                  children: [
                    Image.asset('assets/icons/Ellipse 1.png',
                        width: 50, height: 50),
                    Text(this.workDay.entryDay != null
                        ? 'Entrada: ' +
                            inputFormat
                                .format(DateTime.parse(this.workDay.entryDay))
                        : 'Não a registro')
                  ],
                ),
              ),
              //output
              Card(
                child: Row(
                  children: [
                    Image.asset('assets/icons/Ellipse 1 (1).png',
                        width: 50, height: 50),
                    Text(this.workDay.dayOut != null
                        ? 'Saída: ' +
                            inputFormat
                                .format(DateTime.parse(this.workDay.dayOut))
                        : 'Não a registro')
                  ],
                ),
              ),
              //entry
              Card(
                child: Row(
                  children: [
                    Image.asset('assets/icons/Ellipse 1.png',
                        width: 50, height: 50),
                    Text(this.workDay.entryBack != null
                        ? 'Entrada: ' +
                            inputFormat
                                .format(DateTime.parse(this.workDay.entryBack))
                        : 'Não a registro')
                  ],
                ),
              ),
              //output
              Card(
                child: Row(
                  children: [
                    Image.asset('assets/icons/Ellipse 1 (1).png',
                        width: 50, height: 50),
                    Text(this.workDay.outOfTheDay != null
                        ? 'Saída: ' +
                            inputFormat.format(
                                DateTime.parse(this.workDay.outOfTheDay))
                        : 'Não a registro')
                  ],
                ),
              ),
            ],
          )
        : Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Image.asset('assets/icons/Ellipse 1.png',
                        width: 50, height: 50),
                    Text('Buscando registro, ou não existem registros.')
                  ],
                ),
              ),
            ],
          );
  }
}
