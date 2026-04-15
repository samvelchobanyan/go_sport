import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_typography.dart';

class GuestTimerBar extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const GuestTimerBar({super.key, required this.onRegisterTap});

  @override
  State<GuestTimerBar> createState() => _GuestTimerBarState();
}

class _GuestTimerBarState extends State<GuestTimerBar> {
  static const _guestDuration = Duration(minutes: 3);

  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = _guestDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining.inSeconds <= 0) {
        _timer?.cancel();
        // _showExpiredOverlay();
        context.go('/expired-guest');
        return;
      }
      setState(() {
        _remaining -= const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // void _showExpiredOverlay() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => PopScope(
  //       canPop: false,
  //       child: Scaffold(
  //         backgroundColor: DSColors.black.withValues(alpha: 0.9),
  //         body: Center(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 24),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const Icon(
  //                   Icons.timer_off,
  //                   color: DSColors.white,
  //                   size: 64,
  //                 ),
  //                 const SizedBox(height: 24),
  //                 Text(
  //                   'Guest session expired',
  //                   style: DSTypography.h2.copyWith(color: DSColors.white),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   'Register to continue using the app',
  //                   style: DSTypography.bodyL.copyWith(color: DSColors.gray50),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(height: 32),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   height: 48,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                       widget.onRegisterTap();
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: DSColors.blue,
  //                       foregroundColor: DSColors.white,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                     ),
  //                     child: const Text('Register'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 13,
        bottom: 13 + MediaQuery.of(context).padding.bottom,
      ),
      color: DSColors.black,
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(
              'The app guest usage\nwill end soon',
              style: DSTypography.textL.copyWith(color: DSColors.white),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 55,
                height: 33,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: DSColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _formatTime(_remaining),
                  style: DSTypography.textL.copyWith(color: DSColors.lime),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: DSColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 101,
                height: 33,
                child: ElevatedButton.icon(
                  onPressed: widget.onRegisterTap,
                  icon: const Icon(Icons.person, size: 18),
                  label: const Text('Register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DSColors.blue,
                    foregroundColor: DSColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    textStyle: DSTypography.fieldLabel.copyWith(color: DSColors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
