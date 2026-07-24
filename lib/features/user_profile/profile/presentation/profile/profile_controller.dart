import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/social_media.dart';
import 'package:go_sport/domain/repositories/social_media_repository.dart';

class SocialLinksState {
  final bool isLoading;
  final SocialLinks? socialLinks;
  final String? error;

  const SocialLinksState({
    this.isLoading = false,
    this.socialLinks,
    this.error,
  });

  SocialLinksState copyWith({
    bool? isLoading,
    SocialLinks? socialLinks,
    String? error,
  }) {
    return SocialLinksState(
      isLoading: isLoading ?? this.isLoading,
      socialLinks: socialLinks ?? this.socialLinks,
      error: error,
    );
  }
}

class SocialLinksController extends StateNotifier<SocialLinksState> {
  final SocialLinksRepository _repository;

  SocialLinksController(this._repository) : super(const SocialLinksState());

  Future<void> getSocialLinks() async {
    // Prevent refetching if already loaded or loading
    if (state.isLoading || state.socialLinks != null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final socialLinks = await _repository.getSocialLinks();
      
      state = state.copyWith(isLoading: false, socialLinks: socialLinks);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final socialLinksControllerProvider =
    StateNotifierProvider<SocialLinksController, SocialLinksState>((ref) {
      final repository = ref.watch(socialLinksRepositoryProvider);
      return SocialLinksController(repository);
    });
