import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Gradient gradient;
  final Icon icon;
  final Text text;
  final Function onPressed;

  AppButton({this.icon, this.text, this.gradient, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
        decoration: BoxDecoration(
            gradient: this.gradient ??
                LinearGradient(
                  colors: <Color>[
                    Colors.orange[500],
                    Colors.orange[400],
                    Colors.orange[700],
                  ],
                ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusDirectional.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.icon,
            SizedBox(
              width: 5,
            ),
            this.text
          ],
        ),
      ),
    );
  }
}
