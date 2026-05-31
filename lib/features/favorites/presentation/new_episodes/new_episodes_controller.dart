import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'new_episodes_controller.freezed.dart';

@freezed
class NewEpisodesState with _$NewEpisodesState {
  const factory NewEpisodesState({
    @Default([]) List<Track> episodes,
  }) = _NewEpisodesState;
}

class NewEpisodesNotifier extends Notifier<NewEpisodesState> {
  @override
  NewEpisodesState build() {
    final episodes = ref.watch(
      likeRegistryProvider.select((s) => s.likedEpisodes),
    );
    return NewEpisodesState(episodes: episodes);
  }

  Future<void> refresh() async {
    await ref.read(likeRegistryProvider.notifier).initSession();
  }
}

final newEpisodesStateProvider =
    NotifierProvider<NewEpisodesNotifier, NewEpisodesState>(
  NewEpisodesNotifier.new,
);
