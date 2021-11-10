
import 'package:Ponto_Riobranco/pages/NavigationBar/home_bar.dart';
import 'package:Ponto_Riobranco/pages/NavigationBar/options_bar.dart';
import 'package:Ponto_Riobranco/pages/NavigationBar/point_bar.dart';
import 'package:Ponto_Riobranco/pages/NavigationBar/profile_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ponto_Riobranco/model/employ.dart' as employ_global;

class Home extends StatefulWidget {
  String employID;

  Home({this.employID});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _indexNavigation = 0;
  String home = "home";
  String point = "Ponto";
  String perfil = "Perfil";
  String opcoes = "Opções";

  final pages = [
    HomeBar(),
    PointBar(),
    Profile(),
    Options(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      employ_global.employ_id = widget.employID.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_indexNavigation],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexNavigation,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff38c172),
        iconSize: 30,
        selectedFontSize: 16,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                // color: Colors.white,
              ),
              label: home,
              // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              // color: Colors.black
            ),
            label: point,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              // color: Colors.black
            ),
            label: perfil,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_open_rounded,
              // color: Colors.black
            ),
            label: opcoes,
          ),
        ],
        onTap: (index) {
          setState(() {
            _indexNavigation = index;
          });
        },
      ),
    );
  }
}
