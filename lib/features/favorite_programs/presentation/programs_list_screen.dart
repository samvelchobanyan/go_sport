import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/features/favorite_programs/presentation/programs_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/program_item_row.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class FavoriteProgramsListScreen extends ConsumerStatefulWidget {
  const FavoriteProgramsListScreen({super.key});

  @override
  ConsumerState<FavoriteProgramsListScreen> createState() =>
      _FavoriteProgramsListScreenState();
}

class _FavoriteProgramsListScreenState
    extends ConsumerState<FavoriteProgramsListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(programsStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(programsStateProvider.notifier).loadMore();
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
    final state = ref.watch(programsStateProvider);
    final programs = state.programsList;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            // 🔹 Background image
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
            Column(
              children: [
                MyCategoriesHeader(
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'Programs',
                  subtitle: 'programs',
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
                            ) //todo add skeleton loading later
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

    return ListView.separated(
      controller: _scrollController,
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
        return ProgramItemRow(
          imageUrl: program.imageUrl ?? '',
          title: program.title,
          episodeCount: program.episodeCount,
          onTap: () => debugPrint('Program tapped: ${program.id}'),
          onIconTap: () => debugPrint('Program icon tapped for: ${program.id}'),
        );
      },
    );
  }

  Widget _buildErrorWidget(ProgramsState state) {
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
            onPressed: () => ref.read(programsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
