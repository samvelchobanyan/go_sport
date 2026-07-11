import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/program_details/presentation/widgets/program_episode_tile.dart';
import 'package:go_sport/features/program_details/presentation/widgets/program_screen_skeleton.dart';
import 'package:go_sport/features/program_details/presentation/widgets/youtube_banner.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'program_details_controller.dart';
import '../widgets/program_hero.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

class ProgramDetailsScreen extends ConsumerStatefulWidget {
  /// Program id — the only thing required to open the screen. Navigations
  /// that already hold the full [Program] (lists, search) pass it as
  /// [programHint] for an instant first paint; the track options sheet
  /// passes only the id.
  final String programId;
  final Program? programHint;

  /// Episode to auto-play once episodes load (deep link / push).
  /// Null for regular navigation — the screen behaves exactly as before.
  final String? playEpisodeId;

  const ProgramDetailsScreen({
    super.key,
    required this.programId,
    this.programHint,
    this.playEpisodeId,
  });

  @override
  ConsumerState<ProgramDetailsScreen> createState() =>
      _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends ConsumerState<ProgramDetailsScreen> {
  /// Guards the push-triggered auto-play so it fires at most once.
  bool _autoPlayHandled = false;

  void _onTrackTap(Program program, List<Track> episodes, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.program(
            id: program.id,
            title: program.title,
            imageUrl: program.imageUrl,
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(int index) {
    debugPrint('Track menu tapped at index: $index');
  }

  void _onPlayTap(
    Program program,
    List<Track> episodes,
    bool isThisActiveSource,
  ) {
    if (isThisActiveSource) {
      ref.read(playerStateProvider.notifier).togglePlayPause();
      return;
    }
    if (episodes.isEmpty) return;

    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.program(
            id: program.id,
            title: program.title,
            imageUrl: program.imageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Auto-play the pushed episode once the episodes list arrives.
    if (widget.playEpisodeId != null) {
      ref.listen(programDetailsControllerProvider(widget.programId), (
        prev,
        next,
      ) {
        if (_autoPlayHandled) return;
        next.whenOrNull(
          data: (program, episodes) {
            _autoPlayHandled = true; // one attempt, whatever the outcome
            if (program == null) return;
            final index = episodes.indexWhere(
              (e) => e.id == widget.playEpisodeId,
            );
            if (index == -1) return; // episode gone — just show the program
            _onTrackTap(program, episodes, index);
          },
        );
      });
    }

    final episodesState = ref.watch(
      programDetailsControllerProvider(widget.programId),
    );
    final isLiked = ref.watch(
      likeRegistryProvider.select(
        (s) => s.likedPrograms.any((p) => p.id == widget.programId),
      ),
    );
    final isThisActiveSource = ref.watch(
      playerStateProvider.select(
        (s) => s.source?.id == widget.programId && !s.isRadioMode,
      ),
    );
    final isThisPlaying = ref.watch(
      playerStateProvider.select(
        (s) =>
            s.source?.id == widget.programId && s.isPlaying && !s.isRadioMode,
      ),
    );

    // Prefer the navigation hint for the hero — its cover URL is already
    // cached by the list we came from. The freshly loaded program is used
    // only for id-only opens (track options sheet). Null only while an
    // id-only load is still in flight.
    final loadedProgram = episodesState.whenOrNull(
      data: (program, episodes) => program,
    );
    final program = widget.programHint ?? loadedProgram;

    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;
    final youtubeUrl = program?.youtubeUrl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: expandedHeight,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: DSColors.black.withValues(alpha: 0.9),
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/arrow-Left.svg'),
                onPressed: () => context.pop(),
              ),
              actions: [
                // Share — functionality not implemented yet, hidden for now.
                // IconButton(
                //   icon: SvgPicture.asset('assets/icons/share_no_bg.svg'),
                //   onPressed: () {},
                // ),
                const SearchButton(iconColor: DSColors.white),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: program == null
                    // Id-only open: program not loaded yet — plain backdrop
                    // until the network fills it in.
                    ? const ColoredBox(color: DSColors.black)
                    : ProgramHero(
                        program: program,
                        isLiked: isLiked,
                        isPlaying: isThisPlaying,
                        onLikeTap: () => ref
                            .read(likeRegistryProvider.notifier)
                            .toggleProgramLike(program),
                        onPlayTap: () {
                          final episodes = episodesState.mapOrNull(
                            data: (data) => data.episodes,
                          );
                          if (episodes != null) {
                            _onPlayTap(program, episodes, isThisActiveSource);
                          }
                        },
                      ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Container(
                  height: 24,
                  decoration: const BoxDecoration(
                    color: DSColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(DSRadius.xl),
                    ),
                  ),
                ),
              ),
            ),

            // orange youtube banner — only when the program has a YouTube link
            if (youtubeUrl != null && youtubeUrl.isNotEmpty)
              YoutubeBanner(
                onTap: () => launchUrl(
                  Uri.parse(youtubeUrl),
                  mode: LaunchMode.externalApplication,
                ),
              ),

            episodesState.when(
              loading: () => const ProgramScreenSkeleton(),
              error: (message) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $message'),
                      const SizedBox(height: DSSpacing.m),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(
                              programDetailsControllerProvider(
                                widget.programId,
                              ).notifier,
                            )
                            .loadEpisodes(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (loadedProgram, episodes) {
                if (loadedProgram == null || episodes.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No episodes available')),
                  );
                }

                // Narrow selects: position ticks must not rebuild the list.
                final playingTrackId = ref.watch(
                  playerStateProvider.select((s) => s.currentTrack?.id),
                );
                final isPlaying = ref.watch(
                  playerStateProvider.select(
                    (s) => s.isPlaying && !s.isRadioMode,
                  ),
                );

                return SliverPadding(
                  padding: const EdgeInsets.only(
                    bottom: DSLayout.bottomBarClearance,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final episode = episodes[index];
                      final isCurrentTrack = episode.id == playingTrackId;
                      final bool? trackPlayingState = isCurrentTrack
                          ? isPlaying
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProgramEpisodeTile(
                            episode: episode,
                            index: index + 1,
                            isPlaying: trackPlayingState,
                            topPadding: index == 0 ? 20 : 8,
                            onTap: () =>
                                _onTrackTap(loadedProgram, episodes, index),
                            onMenuTap: () => _onTrackMenuTap(index),
                          ),
                          if (index < episodes.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: DSSpacing.m,
                              ),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    }, childCount: episodes.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
