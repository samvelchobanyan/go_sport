import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

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
      height: 59,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: _NavIcon(asset: 'assets/icons/home.svg', color: DSColors.gray50),
          selectedIcon:
              _NavIcon(asset: 'assets/icons/home_active.svg', color: DSColors.black),
          label: 'Home',
        ),
        NavigationDestination(
          icon: _NavIcon(asset: 'assets/icons/music.svg', color: DSColors.gray50),
          selectedIcon:
              _NavIcon(asset: 'assets/icons/music_active.svg', color: DSColors.black),
          label: 'Music',
        ),
        NavigationDestination(
          icon: _NavIcon(asset: 'assets/icons/radio.svg', color: DSColors.gray50),
          selectedIcon:
              _NavIcon(asset: 'assets/icons/radio_active.svg', color: DSColors.black),
          label: 'Radio',
        ),
      ],
    );
  }
}

class _NavIcon extends StatelessWidget {
  final String asset;
  final Color color;

  const _NavIcon({required this.asset, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: 25,
      height: 25,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
