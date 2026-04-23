import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialMediaButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SizedBox(width: 24, height: 24, child: Center(child: icon)),
      ),
    );
  }
}
