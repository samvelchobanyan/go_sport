import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/programs_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/program_item_row.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> {
  final ScrollController _scrollController = ScrollController();

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
    final state = ref.read(programsStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(programsStateProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final programsState = ref.watch(programsStateProvider);
    final programs = programsState.programsList;

    return Scaffold(
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
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount:
                          programs.length +
                          (programsState.isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: DottedDivider(),
                      ),
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
                          onTap: () =>
                              debugPrint('Program tapped: ${program.id}'),
                          onIconTap: () => debugPrint(
                            'Program icon tapped for: ${program.id}',
                          ),
                        );
                      },
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
