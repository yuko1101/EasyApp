import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    required this.title,
    required this.appIcon,
    required this.items,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget appIcon;
  final List<SideMenuItem> items;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Drawer(
        child: Container(
          color: backgroundColor ?? Colors.transparent, // transparent traces the background color of drawer (ThemeData#drawerTheme#backgroundColor).
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                DrawerHeader(
                  child: Center(
                    child: ListTile(leading: appIcon, title: title),
                  ),
                ),
                ...items
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Icon icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent, // transparent traces the background color of SideBar.
      child: InkWell(
        child: ListTile(
          onTap: onPressed,
          horizontalTitleGap: 0.0,
          leading: icon,
          title: title,
        ),
      ),
    );
  }
}
