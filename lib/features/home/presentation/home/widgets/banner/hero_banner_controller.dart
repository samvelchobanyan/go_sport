// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:go_sport/core/di/repository_providers.dart';
// import 'package:go_sport/domain/entities/banner.dart'; // 👈 Points to pure 'Banner' entity now
// import 'package:go_sport/domain/repositories/banner_repository.dart';

// part 'podcast_banner_controller.freezed.dart';

// // 1. Unified Freezed State Layout
// @freezed
// class PodcastBannerState with _$PodcastBannerState {
//   const factory PodcastBannerState({
//     @Default(false) bool isLoading,
//     String? error,
//     Banner? banner, // 👈 Updated type here
//   }) = _PodcastBannerState;
// }

// // 2. Standalone Controller Management
// class PodcastBannerController extends AutoDisposeNotifier<PodcastBannerState> {
//   late final BannerRepository _bannerRepository;

//   @override
//   PodcastBannerState build() {
//     _bannerRepository = ref.watch(bannerRepositoryProvider);
//     Future.microtask(load);
//     return const PodcastBannerState();
//   }

//   Future<void> load() async {
//     state = state.copyWith(isLoading: true, error: null);

//     try {
//       // Repository fetches DTO and calls .toDomain(), returning a pure Banner
//       final Banner bannerData = await _bannerRepository.getPodcastBanner();

//       state = state.copyWith(isLoading: false, banner: bannerData);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   /// Pull-to-refresh hook
//   Future<void> refresh() => load();
// }

// // 3. Isolated Dedicated State Provider Access Instance
// final podcastBannerStateProvider =
//     NotifierProvider.autoDispose<PodcastBannerController, PodcastBannerState>(
//       PodcastBannerController.new,
//     );
