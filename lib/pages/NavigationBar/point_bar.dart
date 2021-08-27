import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:Ponto_Riobranco/pages/home.dart';
import 'package:Ponto_Riobranco/values/preferences_keys.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Ponto_Riobranco/model/employ.dart' as employ_global;
import 'package:http/http.dart' as http;

class PointBar extends StatefulWidget {

  @override
  _PointBar createState() => _PointBar();
}

class _PointBar extends State<PointBar> {
  File _image;
  File uploadimage;
  String employ_id = '';
  String error_message = '';
  String
  latitudeData = "";
  String longitudeData = "";
  final imagePicker = ImagePicker();
  var status;
  int emoticons;
  bool _isInAsyncCall = false;
StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    if (!this.mounted) {
      setState(() {
        // Your state change code goes here
        this.employ_id = employ_global.employ_id.toString();
      });
      getCurrentLocation();
      super.initState();
    }
    if (employ_global.emoticons != 0)
      getImage();
    else
      showMenssage;

//Teste
    subscription = Connectivity().onConnectivityChanged.listen((event) {showMenssageOff;});

  }
// teste
  @override
  void dispose(){
    subscription.cancel();
    super.dispose();

  }

  Future getImage() async {
    if (employ_global.emoticons == 0) {
      return showAlertDialog1(context);
    }
    setState(() {
      _isInAsyncCall = true;
    });
    final image = await imagePicker.getImage(
        source: ImageSource.camera, maxWidth: 480, maxHeight: 640);
    if (this.mounted) {
      setState(() {
        _image = File(image.path);
        uploadimage = File(image.path);
      });
    }

    var url = Uri.http(PreferencesKeys.apiURL, "/api/validation/workload");
    List<int> imageBytes = uploadimage.readAsBytesSync();
    await this.getCurrentLocation();
    var response = await http.post(url, body: {
      'employ_id': employ_global.employ_id,
      'latitude': latitudeData,
      'longitude': longitudeData,
      'image_photo': base64Encode(imageBytes),
      'mood_day': employ_global.emoticons.toString(),
    });

    if (response.statusCode == 200) {
      log(response.body);
      setState(() {
        _isInAsyncCall = false;
      });

      if (jsonDecode(response.body)['sucess'].hashCode.toString() != '2011') {
        //2011 valor padrão para null
        showAlertDialogSucess(context);
      } else {
        setState(() {
          error_message = jsonDecode(response.body)['error'].toString();
        });
        showAlertDialogError(context);
      }
    } else {
      setState(() {
        error_message =
            'Ops, algo de errado aconteceu, entrar em contato com suporte.';
      });
      showAlertDialogError(context);
    }
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

  Widget buildView(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, condition) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Image.asset("assets/branca.png"),
            ),
          ),
        ];
      },
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 80,
            ),
            child: _image == null
                ? Center(
                    child: Card(
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'TIRE SUA FOTO PARA REGISTAR SEU PONTO',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  )
                : Image.file(
                    _image,
                    width: 350,
                    height: 250,
                  ),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: getImage,
            backgroundColor: Colors.black,
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  // MENSAGENS ERRO
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ModalProgressHUD(
        child: Container(
          child: buildView(context),
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
                  SizedBox(
                    height: 20,
                  ),
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




  Widget showMenssageOff(){
    // Overlay notification here!

    // mensagem de conectividade em off
}




  Widget showMenssage(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(employID: employ_global.employ_id)));
        });
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Não é possível continuar."),
      content: Text("Por favor entre em contato com suporte !"),
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

  showAlertDialog1(BuildContext context) {
    // configura o button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(employID: employ_global.employ_id)));
        });
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Não é possível continuar."),
      content: Text("Você precisa selecionar seu humor deste momento."),
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

  showAlertDialogSucess(BuildContext context) {
    // configura o button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(employID: employ_global.employ_id)));
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

  showAlertDialogError(BuildContext context) {
    // configura o button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(employID: employ_global.employ_id)));
        });
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Error"),
      content: Text(error_message),
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
}
