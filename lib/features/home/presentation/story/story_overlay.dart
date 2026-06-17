import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/domain/entities/story.dart';
import 'package:go_sport/domain/state/stories_state.dart';

import 'widgets/story_progress_bar.dart';

/// Duration each story is shown before auto-advancing to the next one.
const Duration _kStoryDuration = Duration(seconds: 7);

/// Left third of the screen is the "previous" tap zone, the rest is "next".
const double _kPrevZoneFraction = 1 / 3;

/// Full-screen story viewer with auto-advance, tap navigation and hold-to-pause.
///
/// Reads the story list from [storiesStateProvider] once on open and drives the
/// viewing session locally: current index + a single [AnimationController] that
/// both times the 7s auto-advance and fills the active progress segment. Marks
/// each shown story as viewed via the notifier (mirrors how the player carousel
/// reads/pushes its domain state). Navigation away is delegated via [onAction].
class StoryOverlay extends ConsumerStatefulWidget {
  const StoryOverlay({
    super.key,
    required this.initialIndex,
    required this.onClose,
    required this.onAction,
  });

  final int initialIndex;
  final VoidCallback onClose;
  final void Function(String targetType, String targetId) onAction;

  @override
  ConsumerState<StoryOverlay> createState() => _StoryOverlayState();
}

class _StoryOverlayState extends ConsumerState<StoryOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Story> _stories;
  late int _index;

  @override
  void initState() {
    super.initState();
    _stories = ref.read(storiesStateProvider).storiesList;
    _index = widget.initialIndex;

    _controller = AnimationController(vsync: this, duration: _kStoryDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _next();
      });

    // Мутация провайдера — после кадра, не в initState
    // (иначе Riverpod кинет "modify a provider while building").
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _markCurrentViewed();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _markCurrentViewed() {
    ref
        .read(storiesStateProvider.notifier)
        .markAsViewed(_stories[_index].id);
  }

  void _restartTimer() {
    _controller
      ..reset()
      ..forward();
  }

  void _next() {
    // Past the last story → close the viewer.
    if (_index >= _stories.length - 1) {
      widget.onClose();
      return;
    }
    setState(() => _index++);
    _markCurrentViewed();
    _restartTimer();
  }

  void _prev() {
    // On the first story tapping "back" does nothing — stay put.
    if (_index == 0) return;
    setState(() => _index--);
    _markCurrentViewed();
    _restartTimer();
  }

  void _pause() => _controller.stop();

  void _resume() {
    if (!_controller.isAnimating) _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    final width = MediaQuery.of(context).size.width;
    if (details.localPosition.dx < width * _kPrevZoneFraction) {
      _prev();
    } else {
      _next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = _stories[_index];
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: DSColors.transparent,
      body: Stack(
        children: [
          // Background image (full screen, including system areas)
          Positioned.fill(
            child: CachedNetworkImage(
              key: ValueKey(story.id),
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: DSColors.gray20,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: DSColors.gray20,
                child: const Icon(
                  Icons.broken_image,
                  size: 64,
                  color: DSColors.gray50,
                ),
              ),
            ),
          ),

          // Tap zones (left = prev, right = next) + hold-to-pause
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: _onTapUp,
              onLongPressStart: (_) => _pause(),
              onLongPressEnd: (_) => _resume(),
            ),
          ),

          // Top scrim so progress bar / close button read on any photo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: topInset + 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [DSColors.gray50, DSColors.transparent],
                  ),
                ),
              ),
            ),
          ),

          // Segmented progress bar
          Positioned(
            top: topInset + DSSpacing.s8,
            left: DSSpacing.m,
            right: DSSpacing.m,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => StoryProgressBar(
                count: _stories.length,
                currentIndex: _index,
                progress: _controller.value,
              ),
            ),
          ),

          // Close button (top-right, respecting safe area)
          Positioned(
            top: topInset + DSSpacing.l,
            right: DSSpacing.m,
            child: GestureDetector(
              onTap: widget.onClose,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: DSColors.white90,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: DSIconSize.s24,
                  color: DSColors.black,
                ),
              ),
            ),
          ),

          // Bottom content area with gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [DSColors.transparent, DSColors.gray80],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.l),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),

                      // Title
                      Text(
                        story.title,
                        style: context.h2?.copyWith(color: DSColors.white),
                      ),

                      const SizedBox(height: DSSpacing.s10),

                      // Description
                      Text(
                        story.text,
                        style: context.bodyL?.copyWith(color: DSColors.white80),
                      ),

                      const SizedBox(height: DSSpacing.l),

                      // CTA Button
                      Padding(
                        padding: const EdgeInsets.all(DSSpacing.l),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () => widget.onAction(
                              story.ctaTargetType,
                              story.ctaTargetId,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                color: DSColors.lime,
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.campaign,
                                    size: DSIconSize.s20,
                                    color: DSColors.black,
                                  ),
                                  const SizedBox(width: DSSpacing.s8),
                                  Text(
                                    story.ctaLabel,
                                    style: context.subtitleLBold?.copyWith(
                                      color: DSColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom +
                            DSSpacing.l,
                      ),
                    ],
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
