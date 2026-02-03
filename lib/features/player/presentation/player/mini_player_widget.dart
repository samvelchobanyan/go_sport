import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_wave_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_bit_icon.dart';
import 'package:go_sport/domain/state/player_state.dart';

const double _kMiniPlayerHeight = 72.0;
const double _kActivePanelWidthRatio = 0.8;
const double _kInactivePanelWidthRatio = 0.2;
const Duration _kAnimationDuration = Duration(milliseconds: 300);
const Curve _kAnimationCurve = Curves.easeInOut;

class MiniPlayerWidget extends ConsumerStatefulWidget {
  const MiniPlayerWidget({super.key});

  @override
  ConsumerState<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends ConsumerState<MiniPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMusicMode = true; // UI mode: which panel is expanded
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );
  }

  /// Toggle between music and radio UI panels (does NOT affect playback)
  void _toggleMode() {
    setState(() {
      _isMusicMode = !_isMusicMode;
    });
    if (_isMusicMode) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kMiniPlayerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              // Left panel (Radio)
              _buildPanel(
                isMusicPanel: false,
                isActive: !_isMusicMode,
                onTap: !_isMusicMode ? null : _toggleMode,
              ),
              const SizedBox(width: 8),
              // Right panel (Music)
              _buildPanel(
                isMusicPanel: true,
                isActive: _isMusicMode,
                onTap: _isMusicMode ? null : _toggleMode,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPanel({
    required bool isMusicPanel,
    required bool isActive,
    required VoidCallback? onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 32 - 8; // minus horizontal padding (16*2) and gap (8)

    // Calculate target widths
    final activeWidth = availableWidth * _kActivePanelWidthRatio;
    final inactiveWidth = availableWidth * _kInactivePanelWidthRatio;

    // Interpolate width based on animation
    // For Music panel: lerp from active (80%) to inactive (20%) as animation goes 0.0 -> 1.0
    // For Radio panel: lerp from inactive (20%) to active (80%) as animation goes 0.0 -> 1.0
    final animatedWidth = isMusicPanel
        ? lerpDouble(activeWidth, inactiveWidth, _animationController.value)!
        : lerpDouble(inactiveWidth, activeWidth, _animationController.value)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: animatedWidth,
        decoration: BoxDecoration(
          color: isMusicPanel ? DSColors.lime : DSColors.blue,
          borderRadius: BorderRadius.circular(DSRadius.s),
        ),
        child: isActive
            ? (isMusicPanel ? _buildMusicContent() : _buildRadioContent())
            : Center(
                child: isMusicPanel
                    ? const DSBitIcon(
                        color: DSColors.white,
                        size: 24,
                        isAnimated: true,
                      )
                    : const DSWaveIcon(
                        color: DSColors.white,
                        size: 24,
                        isAnimated: true,
                      ),
              ),
      ),
    );
  }

  Widget _buildMusicContent() {
    final playerState = ref.watch(playerStateProvider);
    final track = playerState.currentTrack;
    final isRadioMode = playerState.isRadioMode;
    // Music is playing only if NOT in radio mode AND status is playing
    final isMusicPlaying = !isRadioMode && playerState.isPlaying;
    final isMusicLoading = !isRadioMode && playerState.status == PlayerStatus.loading;
    final imageUrl = playerState.displayImageUrl;

    // Show placeholder if no track is playing
    final trackTitle = track?.title ?? 'No track';
    final artistName = track?.artistName ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 6),
      child: Row(
        children: [
          // Album cover
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DSColors.white,
              borderRadius: BorderRadius.circular(4.25),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null
                ? const Icon(Icons.music_note, color: DSColors.gray40)
                : null,
          ),
          const SizedBox(width: 7),
          // Text block
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    trackTitle,
                    style: context.subtitleM?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DSColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (artistName.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      artistName,
                      style: context.textL?.copyWith(
                        color: DSColors.gray70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Like icon
          GestureDetector(
            onTap: () {
              setState(() {
                _isLiked = !_isLiked;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: DSHeartIcon(
                color: DSColors.blue,
                size: 32,
                isFilled: _isLiked,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Play/Pause icon
          GestureDetector(
            onTap: () {
              if (isRadioMode) {
                // Currently playing radio - switch to music
                ref.read(playerStateProvider.notifier).resumeMusic();
              } else {
                // Already in music mode - toggle play/pause
                ref.read(playerStateProvider.notifier).togglePlayPause();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: isMusicLoading
                    ? SizedBox(
                        key: const ValueKey('music-loading'),
                        width: 32,
                        height: 32,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            color: DSColors.blue,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 32,
                        height: 32,
                        child: SvgPicture.asset(
                          isMusicPlaying 
                            ? 'assets/icons/pause.svg' 
                            : 'assets/icons/play.svg',
                          key: ValueKey(isMusicPlaying),
                          colorFilter: const ColorFilter.mode(
                            DSColors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioContent() {
    final playerState = ref.watch(playerStateProvider);
    final isRadioMode = playerState.isRadioMode;
    final isRadioPlaying = isRadioMode && playerState.isPlaying;
    final isRadioLoading = isRadioMode && playerState.status == PlayerStatus.loading;
    
    // Get radio info from source if available
    final radioSource = playerState.source;
    final String radioTitle;
    final String radioImageUrl;
    
    if (radioSource is QueueSourceRadio) {
      radioTitle = radioSource.title;
      radioImageUrl = radioSource.imageUrl;
    } else {
      radioTitle = 'Go Sport Radio';
      radioImageUrl = 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 6),
      child: Row(
        children: [
          // Station cover
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DSColors.white,
              borderRadius: BorderRadius.circular(4.25),
              image: DecorationImage(
                image: NetworkImage(radioImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 7),
          // Text block
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    radioTitle,
                    style: context.subtitleM?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DSColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Live broadcast',
                    style: context.textL?.copyWith(
                      color: DSColors.white.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Play/Pause icon
          GestureDetector(
            onTap: () {
              if (isRadioMode) {
                // Already in radio mode - toggle play/pause
                ref.read(playerStateProvider.notifier).togglePlayPause();
              } else {
                // Not in radio mode - start radio (stops music)
                ref.read(playerStateProvider.notifier).playRadio();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: isRadioLoading
                    ? SizedBox(
                        key: const ValueKey('radio-loading'),
                        width: 32,
                        height: 32,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: CircularProgressIndicator(
                            color: DSColors.lime,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 32,
                        height: 32,
                        child: SvgPicture.asset(
                          isRadioPlaying 
                            ? 'assets/icons/pause.svg' 
                            : 'assets/icons/play.svg',
                          key: ValueKey(isRadioPlaying),
                          colorFilter: const ColorFilter.mode(
                            DSColors.lime,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
