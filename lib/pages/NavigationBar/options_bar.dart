import 'dart:io';
import 'package:Ponto_Riobranco/button/button_pdf.dart';
import 'package:Ponto_Riobranco/controller/pdf.dart';
import 'package:Ponto_Riobranco/values/preferences_keys.dart';
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
          backgroundColor: Color(0xff09a7ff),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pmrb.png'), scale: 3)),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Card(
                margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
                child: InkWell(
                  onTap: () async {
                    final url = PreferencesKeys.apidemonstrativo;
                    final file = await Pdf.loadNetwork(url);
                    openPDF(context, file);
                  },
                  child: ButtonWidget(
                    text: 'Gerar Demonstrativo',
                    // onClicked: () async {
                    //   final url = PreferencesKeys.apidemonstrativo;
                    //   final file = await Pdf.loadNetwork(url);
                    //   openPDF(contcext, file);
                    // },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
