import 'dart:convert';
import 'package:RBPONTOAMAC/model/workDay.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RBPONTOAMAC/global/variables.dart' as variables_global;
import 'package:RBPONTOAMAC/model/employ.dart' as employ_global;
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
    var url = Uri.https(PreferencesKeys.apiURL, "/api/employ/workday");
    // var url = Uri.http(PreferencesKeys.apihomologa, "/api/validation/workload");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
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
        body: Container(
            child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              child: _itemBuilder(context, 1),
            ),
          ],
        )));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return this.workDay != null
        ? Column(
            children: [
              SizedBox(height: 10),


              SizedBox(height: 10),
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
                        : 'Não há registro')
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
                        : 'Não há registro')
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
                        ? 'Entrada:  ' +
                            inputFormat
                                .format(DateTime.parse(this.workDay.entryBack))
                        : 'Não há registro')
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
                        : 'Não há registro')
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
