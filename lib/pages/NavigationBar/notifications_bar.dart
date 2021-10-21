import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
class Notifications extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}


PopupMenu menu;
GlobalKey btnKey = GlobalKey();

void onDismissOnlyBeCalledOnce() {
  menu.show(widgetKey: btnKey);
}


void stateChanged(bool isShow) {
  print('menu is ${isShow ? 'showing' : 'closed'}');
}

void onDismiss() {
  print('Menu is dismiss');
}

void checkState(BuildContext context) {
  final snackBar = new SnackBar(content: new Text('texto'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

maxColumn() {
  PopupMenu menu = PopupMenu(
      backgroundColor: Colors.black,
      lineColor: Colors.white,
      maxColumn: 4,
      items: [
        MenuItem(title: 'Copy', image: Image.asset('assets/Image.png')),
        MenuItem(
            title: 'Registrar Ponto',
            image: Icon(
              Icons.camera_enhance_outlined,
              color: Colors.white,
              // key: ,
            )),
        MenuItem(
            title: 'Setting',
            image: Icon(
              Icons.settings,
              color: Colors.white,
            )),
        MenuItem(
            title: 'PopupMenu',
            image: Icon(
              Icons.menu,
              color: Colors.white,
            ))
      ],
      stateChanged: stateChanged,
      onDismiss: onDismiss);
  menu.show(widgetKey: btnKey);
}
class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return
      Container(
        child: FloatingActionButton(
          key: btnKey,
          onPressed: maxColumn,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
  }
}
