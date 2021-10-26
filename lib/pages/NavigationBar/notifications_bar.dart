import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
class Notifications extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}
// PopupMenu menu;
// GlobalKey btnKey = GlobalKey();
//
// void onDismissOnlyBeCalledOnce() {
//   menu.show(widgetKey: btnKey);
// }
//
//
// void stateChanged(bool isShow) {
//   print('menu is ${isShow ? 'showing' : 'closed'}');
// }
//
// void onDismiss() {
//   print('Menu is dismiss');
// }
//
// void checkState(BuildContext context) {
//   final snackBar = new SnackBar(content: new Text('texto'));
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
//
// maxColumn() {
//   PopupMenu menu = PopupMenu(
//       backgroundColor: Colors.black,
//       lineColor: Colors.white,
//       maxColumn: 4,
//       items: [
//         MenuItem(title: 'Copy', image: Image.asset('assets/Image.png')),
//         MenuItem(
//             title: 'Registrar Ponto',
//             image: Icon(
//               Icons.camera_enhance_outlined,
//               color: Colors.white,
//               // key: ,
//             )),
//         MenuItem(
//             title: 'Setting',
//             image: Icon(
//               Icons.settings,
//               color: Colors.white,
//             )),
//         MenuItem(
//             title: 'PopupMenu',
//             image: Icon(
//               Icons.menu,
//               color: Colors.white,
//             ))
//       ],
//       stateChanged: stateChanged,
//       onDismiss: onDismiss);
//   menu.show(widgetKey: btnKey);
// }
// class _NotificationsState extends State<Notifications> {
//   @override
//   Widget build(BuildContext context) {
//     PopupMenu.context = context;
//     return
//       Container(
//         child: FloatingActionButton(
//           key: btnKey,
//           onPressed: maxColumn,
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//         ),
// //       );
//   }
// }
class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply demo"),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xff344955),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: 56.0,
          child: Row(children: <Widget>[
            IconButton(
              onPressed: showMenu,
              icon: Icon(Icons.menu),
              color: Colors.white,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              color: Colors.white,
            )
          ]),
        ),
      ),
    );
  }
  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(16.0),
                // topRight: Radius.circular(16.0),
              ),
              color: Color(0xff232f34),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 36,
                ),
                SizedBox(
                    height: (56 * 6).toDouble(),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: Color(0xff344955),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, alignment: Alignment(0, 0),
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: Color(0xff232f34), width: 10)),
                                child: Center(
                                  child: ClipOval(
                                    child: Image.network(
                                      "https://i.stack.imgur.com/S11YG.jpg?s=64&g=1",
                                      fit: BoxFit.cover,
                                      height: 36,
                                      width: 36,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      "Inbox",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.inbox,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Starred",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.star_border,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Sent",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Trash",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),

                                  ListTile(
                                    title: Text(
                                      "Drafts",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.mail_outline,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),

              ],
            ),
          );
        });
  }

}