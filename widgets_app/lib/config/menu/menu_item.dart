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
  ),
  MenuItem(
    title: 'ProgressIndicator',
    subTitle: 'Genel ve Denetimli',
    link: '/progress_screen',
    icon: Icons.refresh_rounded,
  ),
  MenuItem(
    title: 'Snackbar',
    subTitle: 'Flutter Widgets',
    link: '/snackbar_screen',
    icon: Icons.info_outline,
  ),
  MenuItem(
    title: 'Animated',
    subTitle: 'Flutter Widgets',
    link: '/animated_screen',
    icon: Icons.check_box_outline_blank_rounded,
  ),
  MenuItem(
      title: 'UI Controls + Tile',
      subTitle: 'A series of Flutter controls',
      link: '/ui-controls',
      icon: Icons.car_rental_outlined),
  MenuItem(
      title: 'Introduction to the application',
      subTitle: 'Small introductory tutorial',
      link: '/tutorial',
      icon: Icons.accessible_rounded),
  MenuItem(
      title: 'InfiniteScroll and Pull',
      subTitle: 'Infinite lists and pull to refresh',
      link: '/infinite',
      icon: Icons.list_alt_rounded),
];
