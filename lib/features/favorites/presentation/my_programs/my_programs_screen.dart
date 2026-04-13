import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/features/favorites/presentation/my_programs/my_programs_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/program_tile.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class MyProgramsScreen extends ConsumerStatefulWidget {
  const MyProgramsScreen({super.key});

  @override
  ConsumerState<MyProgramsScreen> createState() => _MyProgramsScreenState();
}

class _MyProgramsScreenState extends ConsumerState<MyProgramsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(myProgramsStateProvider);
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(myProgramsStateProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myProgramsStateProvider);
    final programs = state.programs;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
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
            Column(
              children: [
                MyCategoriesHeader(
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'My Programs',
                  subtitle: 'Programs',
                  itemCount: programs.length,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: state.isLoading && programs.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.error != null && programs.isEmpty
                          ? _buildErrorWidget(state)
                          : _buildProgramsList(
                              ref,
                              programs,
                              state.isLoadingMore,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramsList(
    WidgetRef ref,
    List<Program> programs,
    bool isLoadingMore,
  ) {
    if (programs.isEmpty) {
      return Center(
        child: Text('No favorite programs yet', style: context.subtitleLBold),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(myProgramsStateProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        itemCount: programs.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) {
          if (index >= programs.length - 1) {
            return const SizedBox.shrink();
          }

          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          );
        },
        itemBuilder: (context, index) {
          if (index >= programs.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final program = programs[index];
          return ProgramTile(
            imageUrl: program.imageUrl,
            title: program.title,
            episodeCount: program.episodeCount,
            onTap: () => context.push(
              '/music/program/${program.id}',
              extra: program,
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(MyProgramsState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Failed to load favorite programs',
            style: context.subtitleLBold,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                ref.read(myProgramsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
