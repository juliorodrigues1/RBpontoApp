import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        icon: Icon(Icons.list),
        style: OutlinedButton.styleFrom(
          primary: Color(0xFF000000),
          minimumSize: Size.fromRadius(24),
          side: BorderSide(color: Color(0xff38c172))
        ),
        onPressed: onClicked,
        label: Text(text,
          style: TextStyle(
              fontSize: 15,
              color: Colors.black,
          ),
        ),
      );
}
