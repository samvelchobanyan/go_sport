import 'package:go_sport/domain/entities/social_media.dart';

abstract interface class SocialLinksRepository {
  /// Fetches the live advertisement banner data.
  ///
  /// Returns a pure [Banner] entity if successful, or null if no
  /// active banner exists on the server.
  Future<SocialLinks> getSocialLinks();
}
