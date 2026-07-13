import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/banner.dart'; // 👈 Points to pure 'Banner' entity now
import 'package:go_sport/domain/repositories/banner_repository.dart';

part 'hero_banner_controller.freezed.dart';

// 1. Unified Freezed State Layout
@freezed
class BannerState with _$BannerState {
  const factory BannerState({
    @Default(false) bool isLoading,
    String? error,
    HeroBanner? banner, // 👈 Updated type here
  }) = _BannerState;
}

// 2. Standalone Controller Management
class BannerController extends AutoDisposeNotifier<BannerState> {
  late final BannerRepository _bannerRepository;

  @override
  BannerState build() {
    _bannerRepository = ref.watch(bannerRepositoryProvider);
    Future.microtask(load);
    return const BannerState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Repository fetches DTO and calls .toDomain(), returning a pure Banner
      final HeroBanner bannerData = await _bannerRepository.getPodcastBanner();

      state = state.copyWith(isLoading: false, banner: bannerData);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Pull-to-refresh hook
  Future<void> refresh() => load();
}

// 3. Isolated Dedicated State Provider Access Instance
final bannerStateProvider =
    NotifierProvider.autoDispose<BannerController, BannerState>(
      BannerController.new,
    );
