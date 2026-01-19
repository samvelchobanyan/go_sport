import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Radio',
          style: context.subtitleLBold,
        ),
      ),
      body: Center(
        child: Text(
          'Radio Screen',
          style: context.h2,
        ),
      ),
    );
  }
}
