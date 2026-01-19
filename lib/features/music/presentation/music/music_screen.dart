import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music',
          style: context.subtitleLBold,
        ),
      ),
      body: Center(
        child: Text(
          'Music Screen',
          style: context.h2,
        ),
      ),
    );
  }
}
