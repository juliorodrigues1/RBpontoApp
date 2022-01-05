import 'dart:io';
import 'package:RBPONTOAMAC/button/button_pdf.dart';
import 'package:RBPONTOAMAC/controller/pdf.dart';
import 'package:RBPONTOAMAC/pages/abono.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../pdf_viewer.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

void openPDF(BuildContext context, File file) => Navigator.of(context)
    .push(MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));

class _OptionsState extends State<Options> {
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
        child: ListView(
          children: [
            Card(
                margin: EdgeInsets.fromLTRB(50, 30, 50, 20),
                child: InkWell(
                  onTap: () async {
                    final url = PreferencesKeys.apidemonstrativo;
                    final file = await Pdf.loadNetwork(url);
                    openPDF(context, file);
                  },
                  child: ButtonWidget(
                    text: 'Gerar Demonstrativo',
                    onClicked: () async {
                      final url = PreferencesKeys.apidemonstrativo;
                      final file = await Pdf.loadNetwork(url);
                      openPDF(context, file);
                    },
                  ),
                )),
            Card(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: InkWell(
                  child: ButtonWidget(
                    text: 'Solicitação de Abono Falta/Pendência',
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Abono()),
                      );
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
