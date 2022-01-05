import 'dart:convert';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:http/http.dart' as http;
import 'package:RBPONTOAMAC/controller/Conection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RBPONTOAMAC/SplashScreen/style.dart' as Theme;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Conexao().internet(context);
    getVersion();
    // Timer(Duration(seconds: 5), () {
    //   Navigator.pop(context);
    //   Navigator.pushNamed(context, '/login');
    // });
  }

  Future getVersion() async{
    PackageInfo _packageInfo = PackageInfo(appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',);

    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
    var url = Uri.http(PreferencesKeys.apihomologa, '/api/listar/versao/app');
    var response = await http.get(url);
    if(jsonDecode(response.body)['version'] == _packageInfo.version){
      Navigator.pop(context);
      Navigator.pushNamed(context, '/login');
    }else{
      showmensage('Seu aplicativo está desatualizada, clique no batão para atualizar.');
    }


  }

  showmensage(String mensagem) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aviso'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              launch('https://play.google.com/store/apps/details?id=com.riobranco.ac.Ponto_Riobranco');
            },
            child: const Text('Atualizar'),
          ),
        ],
      ),
    );
  }

  ModalRoute<dynamic> _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    super.dispose();
  }

  Future<bool> _onWillPop() => Future.value(false);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 90.0),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/logo-amac.png",
                        height: 200.0,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SpinKitDualRing(color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
