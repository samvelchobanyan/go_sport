import 'package:go_sport/domain/entities/banner.dart';

abstract interface class BannerRepository {
  /// Fetches the live advertisement banner data.
  ///
  /// Returns a pure [Banner] entity if successful, or null if no
  /// active banner exists on the server.
  Future<HeroBanner> getPodcastBanner();
}
