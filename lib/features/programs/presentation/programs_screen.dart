import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/state/episodes_state.dart';
import 'package:go_sport/domain/state/programs_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/episode_item_row.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/program_item_row.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showEpisodes = false; // Default to programs

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (_showEpisodes) {
        ref.read(episodesStateProvider.notifier).loadMore();
      } else {
        // ref.read(programsStateProvider.notifier).loadMore();
        // if will be paginated
      }
    }
  }

  // change this page to work with new provider style

  @override
  Widget build(BuildContext context) {
    final episodesState = ref.watch(episodesStateProvider);
    final programsState = ref.watch(programsStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background image (visible behind rounded list)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240,
            child: Image.asset(
              'assets/images/mine_cover.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Foreground content
          _buildBody(context, ref, episodesState, programsState),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    EpisodesState episodesState,
    ProgramsState programsState,
  ) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // 🔹 Content based on selection
        if (_showEpisodes)
          ..._buildEpisodesContent(context, ref, episodesState)
        else
          ..._buildProgramsContent(context, ref, programsState),
      ],
    );
  }

  Widget _buildToggleButton(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? DSColors.blue : DSColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? DSColors.blue : DSColors.gray20,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: context.fieldLabel?.copyWith(
                color: isActive ? DSColors.white : DSColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEpisodesContent(
    BuildContext context,
    WidgetRef ref,
    EpisodesState state,
  ) {
    // Initial loading
    if (state.isLoading && state.episodesList.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Episodes',
          subtitle: 'episodes',
          itemCount: 0,
          // onTapIcon: _playAll,
        ),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    // Error with no data
    if (state.error != null && state.episodesList.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Episodes',
          subtitle: 'episodes',
          itemCount: 0,
          // onTapIcon: _playAll,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading episodes', style: context.subtitleLSemi),
                const SizedBox(height: 8),
                Text(
                  state.error!,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(episodesStateProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    final episodes = state.episodesList;

    if (episodes.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Episodes',
          subtitle: 'episodes',
          itemCount: 0,
          // onTapIcon: _playAll,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text('No episodes yet', style: context.subtitleLBold),
          ),
        ),
      ];
    }

    return [
      MyCategoriesTop(
        iconPath: 'assets/icons/dynamic_bg.svg',
        title: 'Episodes',
        subtitle: 'episodes',
        itemCount: episodes.length,
        // onTapIcon: _playAll,
      ),

      // 🔹 Episodes list
      ..._buildEpisodesSliver(episodes),

      // 🔹 Loading indicator at the bottom
      if (state.isLoadingMore)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ];
  }

  void _playAll() {
    // TODO: Implement play-all episodes behavior
    debugPrint('Play all episodes pressed');
  }

  List<Widget> _buildEpisodesSliver(List<dynamic> episodes) {
    // Build children list: separators and items
    final children = <Widget>[];

    // Add toggle buttons first
    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            _buildToggleButton(
              context,
              label: 'Programs',
              isActive: !_showEpisodes,
              onTap: () => setState(() => _showEpisodes = false),
            ),
            const SizedBox(width: 12),
            _buildToggleButton(
              context,
              label: 'Episodes',
              isActive: _showEpisodes,
              onTap: () => setState(() => _showEpisodes = true),
            ),
          ],
        ),
      ),
    );

    for (int i = 0; i < episodes.length; i++) {
      if (i > 0) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          ),
        );
      }
      final episode = episodes[i];
      children.add(
        EpisodeItemRow(
          imageUrl: episode.imageUrl ?? '',
          title: episode.title,
          releaseDate: episode.releaseDate,
          duration: episode.duration,
          onTap: () => debugPrint('Episode tapped: ${episode.id}'),
          onIconTap: () => debugPrint('Episode icon tapped for: ${episode.id}'),
        ),
      );
    }

    // Wrap in a single column inside a container
    return [
      SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            color: DSColors.white,
            child: Column(children: children),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildProgramsContent(
    BuildContext context,
    WidgetRef ref,
    ProgramsState state,
  ) {
    // Initial loading
    if (state.isLoading && state.programsList.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Programs',
          subtitle: 'programs',
          itemCount: 0,
        ),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    // Error with no data
    if (state.error != null && state.programsList.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Programs',
          subtitle: 'programs',
          itemCount: 0,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading programs', style: context.subtitleLSemi),
                const SizedBox(height: 8),
                Text(
                  state.error!,
                  style: context.textL?.copyWith(color: DSColors.gray60),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(programsStateProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    final programs = state.programsList;

    if (programs.isEmpty) {
      return [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'Programs',
          subtitle: 'programs',
          itemCount: 0,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text('No programs yet', style: context.subtitleLBold),
          ),
        ),
      ];
    }

    return [
      MyCategoriesTop(
        iconPath: 'assets/icons/dynamic_bg.svg',
        title: 'Programs',
        subtitle: 'programs',
        itemCount: programs.length,
      ),

      // 🔹 Programs list
      ..._buildProgramsSliver(programs),

      // 🔹 Loading indicator at the bottom
      if (state.isLoadingMore)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ];
  }

  List<Widget> _buildProgramsSliver(List<dynamic> programs) {
    // Build children list: separators and items
    final children = <Widget>[];

    // Add toggle buttons first
    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            _buildToggleButton(
              context,
              label: 'Programs',
              isActive: !_showEpisodes,
              onTap: () => setState(() => _showEpisodes = false),
            ),
            const SizedBox(width: 12),
            _buildToggleButton(
              context,
              label: 'Episodes',
              isActive: _showEpisodes,
              onTap: () => setState(() => _showEpisodes = true),
            ),
          ],
        ),
      ),
    );

    for (int i = 0; i < programs.length; i++) {
      if (i > 0) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          ),
        );
      }
      final program = programs[i];
      children.add(
        ProgramItemRow(
          imageUrl: program.imageUrl ?? '',
          title: program.title,
          episodeCount: program.episodeCount,
          onTap: () => debugPrint('Program tapped: ${program.id}'),
          onIconTap: () => debugPrint('Program icon tapped for: ${program.id}'),
        ),
      );
    }

    // Wrap in a single column inside a container
    return [
      SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            color: DSColors.white,
            child: Column(children: children),
          ),
        ),
      ),
    ];
  }
}
