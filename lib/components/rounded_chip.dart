import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RoundedChip extends StatelessWidget {
  final String content;
  final IconData iconData;
  final Color color;
  final EdgeInsets padding;
  RoundedChip(
      {Key key,
      this.iconData,
      this.color: Colors.white,
      this.content,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            color: color,
            size: 22,
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Text(
              this.content,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
