import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/player_state.dart';

class RadioScreen extends ConsumerWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final isRadioMode = playerState.isRadioMode;
    final isPlaying = isRadioMode && playerState.isPlaying;
    final isLoading = isRadioMode && playerState.status == PlayerStatus.loading;

    final radioTitle = playerState.radioTitle ?? 'Go Sport Radio';
    final radioImageUrl = playerState.radioImageUrl ??
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80';

    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        title: Text(
          'Radio',
          style: context.subtitleLBold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Station cover
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DSRadius.m),
                boxShadow: [
                  BoxShadow(
                    color: DSColors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(radioImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Station name
            Text(
              radioTitle,
              style: context.h2,
            ),
            const SizedBox(height: 8),
            
            // Now Playing (from ICY metadata) or "Live broadcast"
            Text(
              playerState.radioNowPlaying ?? 'Live broadcast',
              style: context.bodyL?.copyWith(
                color: DSColors.gray60,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Live indicator
            if (isPlaying)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: DSColors.errorColor,
                  borderRadius: BorderRadius.circular(DSRadius.xs),
                ),
                child: Text(
                  'LIVE',
                  style: context.fieldLabel?.copyWith(color: DSColors.white),
                ),
              ),
            
            const SizedBox(height: 48),
            
            // Play/Pause button
            GestureDetector(
              onTap: () {
                if (isRadioMode) {
                  ref.read(playerStateProvider.notifier).togglePlayPause();
                } else {
                  ref.read(playerStateProvider.notifier).playRadio();
                }
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: DSColors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: DSColors.blue.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: DSColors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : SvgPicture.asset(
                          isPlaying
                              ? 'assets/icons/pause.svg'
                              : 'assets/icons/play.svg',
                          colorFilter: const ColorFilter.mode(
                            DSColors.white,
                            BlendMode.srcIn,
                          ),
                          width: 40,
                          height: 40,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
