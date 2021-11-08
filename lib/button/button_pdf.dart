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
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          // onPrimary: Color(0xFF000000),
          // primary:  Color(0xFF000000) ,
          minimumSize: Size.fromRadius(5),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,


            )
        ),
        onPressed: onClicked,
      );
}
