import 'package:RBPONTOAMAC/ui/shared/globals.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;

  ButtonWidget({
    this.title,
    this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Global.white : Global.mediumBlue,
          borderRadius: BorderRadius.circular(0),
          border: hasBorder
              ? Border.all(
                  color: Global.mediumBlue,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 20.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? Colors.black : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
