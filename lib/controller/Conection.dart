import 'package:RBPONTOAMAC/pages/NavigationBar/options_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'package:flutter/material.dart';

//classe de teste conexão
class Conexao {
  internet(context) async {
    try {
      final result = await InternetAddress.lookup('apirbponto.amac.riobranco.ac.gov.br');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Options()
        ),
      );
    }
  }
}
