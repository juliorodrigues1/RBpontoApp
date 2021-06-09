import 'package:Ponto_App/pages/NavigationBar/home_bar.dart';
import 'package:Ponto_App/pages/NavigationBar/notifications_bar.dart';
import 'package:Ponto_App/pages/NavigationBar/point_bar.dart';
import 'package:Ponto_App/pages/NavigationBar/profile_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ponto_App/model/employ.dart' as employ_global;

class Home extends StatefulWidget {
  String employID;

  Home({this.employID});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _indexNavigation = 0;
  int emoticons = 0;

  //
  getEmotion(emoticons) async {
    setState(() {
      this.emoticons = emoticons;
      employ_global.emoticons = emoticons;
    });
  }

  final pages = [
    HomeBar(),
    PointBar(),
    Profile(),
    Notifications(),
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
        backgroundColor: Color(0xDDE7E7E7),
        iconSize: 25,
        selectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined, color: Colors.blue),
            title: Text(' Ponto'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: Colors.blue),
            title: Text('Perfil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined, color: Colors.blue),
            title: Text('Notificações'),
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
