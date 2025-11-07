import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

enum Navigation {
  home(filledIcon: Icons.home_sharp, outlinedIcon: Icons.home_outlined),
  saved(
    filledIcon: TablerIcons.bookmark_filled,
    outlinedIcon: TablerIcons.bookmark,
  );

  final IconData filledIcon;
  final IconData outlinedIcon;

  const Navigation({required this.filledIcon, required this.outlinedIcon});
}
