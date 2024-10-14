import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuIstems = <MenuItem>[
  MenuItem(
    title: 'Button',
    subTitle: 'Flutter da birkaç buton',
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),
  MenuItem(
    title: 'Cards',
    subTitle: 'Container',
    link: '/cards',
    icon: Icons.credit_card,
  )
];
