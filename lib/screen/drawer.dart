import 'package:easy_app/screen/page_manager.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    required this.title,
    required this.appIcon,
    required this.items,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget appIcon;
  final List<DrawerListTile> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 210,
        child: Row(
            children: [
              Expanded(
                  child: Drawer(
                      child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: SingleChildScrollView(
                              child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    DrawerHeader(
                                      child: Center(
                                        child: ListTile(
                                          leading: appIcon,
                                          title: title
                                        ),
                                      ),
                                    ),
                                    ...items
                                  ]
                              )
                          )
                      )
                  )
              )
            ]
        )
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {required this.title, required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  final Widget title;
  final Icon icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        child: ListTile(
          onTap: onPressed,
          horizontalTitleGap: 0.0,
          leading: icon,
          title: title
        ),
      ),
    );
  }
}
