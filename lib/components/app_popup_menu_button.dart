import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPopupMenuItem {
  String label;
  IconData icon;
  String key;

  AppPopupMenuItem({this.label, this.icon, this.key});
}

class AppPopupMenuButton extends StatelessWidget {
  final List<AppPopupMenuItem> customPopupMenuItems;
  final Color color;
  final double size;
  final Function(String) onAction;

  AppPopupMenuButton(
      {this.customPopupMenuItems, this.color, this.size, this.onAction});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: this.onAction,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: 24,
      ),
      elevation: 5.0,
      itemBuilder: (_) {
        return this
            .customPopupMenuItems
            .map((customPopupMenuItem) => PopupMenuItem(
                  value: customPopupMenuItem.key,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        customPopupMenuItem.icon,
                        color: this.color,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(customPopupMenuItem.label,
                          style: Get.theme.textTheme.bodyText1
                              .copyWith(color: this.color))
                    ],
                  ),
                ))
            .toList();
      },
    );
  }
}
