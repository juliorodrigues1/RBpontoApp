
import 'package:RBPONTOAMAC/pages/NavigationBar/home_bar.dart';
import 'package:RBPONTOAMAC/viewmodels/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SplashScreen/Splash.dart';
import 'pages/login.dart';
import 'pages/home.dart';



void main() => runApp(PontoMain());
class PontoMain extends StatelessWidget{
  final appTitle = 'Ponto RB';
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      initialRoute: '/Splash',
      routes: {
        '/Splash': (context) => Splash(),
        '/login':(context) => ChangeNotifierProvider(create: (context) => LoginModel(), child: MaterialApp(home: Login(),),),
        '/home':(context) => Home(),
        'homebar':(context) => HomeBar(),
      }

    );
  }
}