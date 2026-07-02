import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_wave_icon.dart';
import 'package:go_sport/design_system/components/icons/ds_bit_icon.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/domain/state/player_state_selectors.dart';


const double _kMiniPlayerHeight = 55.0;
const double _kInactivePanelWidth = 48.0;
const Duration _kAnimationDuration = Duration(milliseconds: 300);
const double _kProgressBarHeight = 2.0;
const double _kProgressBarInset = 8.0;

class MiniPlayerWidget extends ConsumerStatefulWidget {
  final VoidCallback onOpenFullPlayer;
  final VoidCallback onOpenRadioPlayer;

  const MiniPlayerWidget({
    super.key,
    required this.onOpenFullPlayer,
    required this.onOpenRadioPlayer,
  });

  @override
  ConsumerState<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends ConsumerState<MiniPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final PageController _pageController; 

  bool _isMusicMode = true; // UI mode: which panel is expanded

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );
    _pageController = PageController(initialPage: 1); 
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Auto-align the expanded panel with actual playback mode when it changes
    // (e.g. music started from another screen while the radio panel was open).
    // One-directional reaction on mode transition — panels remain independent
    // between transitions, so manual toggling is preserved.
    ref.listen(playerStateProvider.select((s) => s.mode), (_, next) {
      final shouldBeMusic = next == PlaybackMode.music;
      if (_isMusicMode != shouldBeMusic) {
        _toggleMode();
      }
    });

    return Container(
      height: _kMiniPlayerHeight,
      padding: const EdgeInsets.only(left: DSSpacing.m, right: DSSpacing.m, top: DSSpacing.s8),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              // Left panel (Radio)
              _buildPanel(
                isMusicPanel: false,
                isActive: !_isMusicMode,
                onTap: !_isMusicMode ? widget.onOpenRadioPlayer : _toggleMode,
              ),
              const SizedBox(width: DSSpacing.s8),
              // Right panel (Music)
              _buildPanel(
                isMusicPanel: true,
                isActive: _isMusicMode,
                onTap: _isMusicMode ? widget.onOpenFullPlayer : _toggleMode,
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

    final activeWidth = availableWidth - _kInactivePanelWidth;
    const inactiveWidth = _kInactivePanelWidth;

    final animatedWidth = isMusicPanel
        ? lerpDouble(activeWidth, inactiveWidth, _animationController.value)!
        : lerpDouble(inactiveWidth, activeWidth, _animationController.value)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: animatedWidth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isMusicPanel ? DSColors.lime : DSColors.blue,
          borderRadius: BorderRadius.circular(DSRadius.s),
        ),
        child: isActive
            ? (isMusicPanel ? _buildSwipableMusicContent() : _buildRadioContent())
            : Center(
                child: isMusicPanel
                    ? const DSBitIcon(
                        color: DSColors.white,
                        size: DSIconSize.s24,
                        isAnimated: true,
                      )
                    : const DSWaveIcon(
                        // color: DSColors.white,
                        // size: DSIconSize.s24,
                        isAnimated: true,
                      ),
              ),
      ),
    );
  }

  Widget _buildSwipableMusicContent(){

    final info = ref.watch(playerInfoProvider);
    // final track = info.track;
    final isRadioMode = info.isRadioMode;
    final isMusicPlaying = !isRadioMode && info.isPlaying;
    final isMusicLoading = !isRadioMode && info.status == PlayerStatus.loading;
    // final imageUrl = info.displayImageUrl;

    

    final swipeData = ref.watch(
      playerStateProvider.select((s) =>(
        currentTrack: s.currentTrack,
        prevTrack: s.prevTrack,
        nextTrack: s.nextTrack,

        sourceImageUrl: s.source?.when(
          album: (_, __, img) => img,
          playlist: (_, __, img) => img,
          program: (_, __, img) => img,
          favorites: (_, __, img) => img,
          episodes: (_, __, img) => img,
        ),
    )));

    return Stack(
      children: [
        NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            final page = _pageController.page?.round();
            if (page == null || page == 1) return false;

            if(page == 2) {
              ref.read(playerStateProvider.notifier).next();
            } else if (page == 0) {
              ref.read(playerStateProvider.notifier).previous();
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && _pageController.hasClients) {
                _pageController.jumpToPage(1);
              }
            });

            return false;
          },
          child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (contect, index){
                final track = switch(index) {
                  0 => swipeData.prevTrack,
                  1 => swipeData.currentTrack,
                  2 => swipeData.nextTrack,
                  _ => null,
                };  
                final trackTitle = track?.title ?? 'No track';
                final artistName = track?.artistName ?? '';
                final imageUrl = track?.imageUrl ?? swipeData.sourceImageUrl;
                
                return Padding(
                  padding: const EdgeInsets.only(left: DSSpacing.s8, right: DSSpacing.s8),
                  child: Row(
                    children: [
                      // Album cover
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: DSColors.white,
                          borderRadius: BorderRadius.circular(DSRadius.xs),
                          image: imageUrl != null
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl == null
                            ? const Icon(Icons.music_note, color: DSColors.gray40)
                            : null,
                      ),
                      const SizedBox(width: DSSpacing.s8),
                      // Text block
                      Expanded(
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
                      const SizedBox(width: DSSpacing.s8),
                      // Like icon
                      Consumer(
                        builder: (context, ref, _) {
                          final track = swipeData.currentTrack;
                          final isLiked = track == null
                              ? false
                              : ref.watch(
                                  likeRegistryProvider.select((s) =>
                                      track.releaseDate != null
                                          ? s.likedEpisodes.any((e) => e.id == track.id)
                                          : s.likedTracks.any((t) => t.id == track.id)),
                                );
                          return GestureDetector(
                            onTap: () {
                              if (track == null) return;
                              final registry =
                                  ref.read(likeRegistryProvider.notifier);
                              if (track.releaseDate != null) {
                                registry.toggleEpisodeLike(track);
                              } else {
                                registry.toggleTrackLike(track);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: DSSpacing.s8),
                              child: DSHeartIcon(
                                color: DSColors.blue,
                                size: DSIconSize.s32,
                                isFilled: isLiked,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: DSSpacing.s8),
                      // Play/Pause icon
                      GestureDetector(
                        onTap: () {
                          if (isRadioMode) {
                            ref.read(playerStateProvider.notifier).resumeMusic();
                          } else {
                            ref.read(playerStateProvider.notifier).togglePlayPause();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: DSSpacing.s8),
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
                                      padding: const EdgeInsets.all(DSSpacing.s8),
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
              },
          ),
        ),
        Positioned(
          bottom: 0,
          left: _kProgressBarInset,
          right: _kProgressBarInset,
          child: Consumer(builder: (context, ref, _) {
            final progress = ref.watch(playerProgressProvider);
            return LinearProgressIndicator(
              value: progress,
              minHeight: _kProgressBarHeight,
              backgroundColor: DSColors.lime,
              valueColor: const AlwaysStoppedAnimation(DSColors.blue),
            );
          }),
        ),
      ]
        
    );

  }

  Widget _buildRadioContent() {
    final info = ref.watch(playerInfoProvider);
    final isRadioMode = info.isRadioMode;
    final isRadioPlaying = isRadioMode && info.isPlaying;
    final isRadioLoading = isRadioMode && info.status == PlayerStatus.loading;

    final radioTitle = info.radioTitle ?? 'Go Sport Radio';
    final radioImageUrl = info.radioImageUrl ??
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80';

    return Padding(
      padding: const EdgeInsets.only(left: DSSpacing.s8, right: DSSpacing.s8),
      child: Row(
        children: [
          // Station cover
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: DSColors.white,
              borderRadius: BorderRadius.circular(DSRadius.xs),
              image: DecorationImage(
                image: CachedNetworkImageProvider(radioImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: DSSpacing.s8),
          // Text block
          Expanded(
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
                  Text(
                    info.radioNowPlaying ?? 'Live broadcast',
                    style: context.textL?.copyWith(
                      color: DSColors.white.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
            ),
          ),
          const SizedBox(width: DSSpacing.s8),
          // Play/Pause icon
          GestureDetector(
            onTap: () {
              if (isRadioMode) {
                ref.read(playerStateProvider.notifier).togglePlayPause();
              } else {
                ref.read(playerStateProvider.notifier).playRadio();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: DSSpacing.s8),
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
                          padding: const EdgeInsets.all(DSSpacing.s6),
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