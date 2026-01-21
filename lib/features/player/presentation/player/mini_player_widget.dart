import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_wave_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_bit_icon.dart';

const double _kMiniPlayerHeight = 72.0;
const double _kActivePanelWidthRatio = 0.8;
const double _kInactivePanelWidthRatio = 0.2;
const Duration _kAnimationDuration = Duration(milliseconds: 300);
const Curve _kAnimationCurve = Curves.easeInOut;

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({super.key});

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMusicMode = true; // Initial mode: Music
  bool _isPlaying = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );
  }

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
          borderRadius: BorderRadius.circular(8),
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
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=300&q=80',
                ),
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
                    'Good Feelings',
                    style: context.subtitleM?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DSColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Coldplay',
                    style: context.textL?.copyWith(
                      color: DSColors.gray70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
    setState(() {
      _isPlaying = !_isPlaying;
    });
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
      child: SvgPicture.asset(
        _isPlaying 
          ? 'assets/icons/pause.svg' 
          : 'assets/icons/play.svg',
        key: ValueKey(_isPlaying),
        colorFilter: ColorFilter.mode(
          DSColors.blue,
          BlendMode.srcIn,
        ),
        width: 32,
        height: 32,
      ),
    ),
  ),
),
        ],
      ),
    );
  }

  Widget _buildRadioContent() {
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
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80',
                ),
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
                    'Radio Sport FM',
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
                      color: DSColors.white.withOpacity(0.7),
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
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SvgPicture.asset(
                _isPlaying 
                  ? 'assets/icons/pause.svg' 
                  : 'assets/icons/play.svg',
                colorFilter: ColorFilter.mode(
                  DSColors.lime,
                  BlendMode.srcIn,
                ),
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
