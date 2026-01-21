import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'dart:ui';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      indicatorColor: DSColors.transparent,
      backgroundColor: DSColors.white,
      elevation: 0,
      shadowColor: DSColors.transparent,
      surfaceTintColor: DSColors.transparent,
      height: 69,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? DSColors.black : DSColors.grey50,
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/music.svg',
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? DSColors.black : DSColors.grey50,
              BlendMode.srcIn,
            ),
          ),
          label: 'Music',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/radio.svg',
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? DSColors.black : DSColors.grey50,
              BlendMode.srcIn,
            ),
          ),
          label: 'Radio',
        ),
      ],
    );
  }
}
