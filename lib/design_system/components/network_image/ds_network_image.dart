import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Unified network image with a single "noimage" fallback that covers the
/// loading, error and null/empty-url states.
///
/// Dumb presentational component: no state, no provider subscriptions — every
/// input comes through props. Standardizes the app on [CachedNetworkImage] and
/// removes the per-call-site error/placeholder boilerplate.
class DSNetworkImage extends StatelessWidget {
  /// Bundled placeholder shown while loading, on load error, or when [imageUrl]
  /// is null/empty.
  static const String noImageAsset = 'assets/images/noimage.png';

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Optional corner radius. When set, the image is clipped with a [ClipRRect];
  /// when null, no clipping is applied (wrap externally if a different shape is
  /// needed, e.g. [ClipOval]).
  final double? borderRadius;

  /// Forwarded to [CachedNetworkImage] to cap the decoded bitmap size in
  /// memory. Useful for large artwork shown at small sizes.
  final int? memCacheWidth;
  final int? memCacheHeight;

  /// Optional lighter version of the same image (usually a thumbnail that is
  /// already in the cache from a list). It stays fully opaque underneath while
  /// [imageUrl] fades in on top, so the image sharpens instead of flashing; if
  /// [imageUrl] fails, the thumbnail remains. Ignored when null, empty or equal
  /// to [imageUrl].
  final String? placeholderUrl;

  const DSNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.memCacheWidth,
    this.memCacheHeight,
    this.placeholderUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = imageUrl != null && imageUrl!.isNotEmpty;
    final hasPlaceholderUrl =
        placeholderUrl != null &&
        placeholderUrl!.isNotEmpty &&
        placeholderUrl != imageUrl;

    final Widget image;
    if (!hasUrl) {
      image = _noImage();
    } else if (hasPlaceholderUrl) {
      // Layered, not swapped: CachedNetworkImage cross-fades placeholder out
      // and image in at the same time, and mid-way both are semi-transparent,
      // so the background flashes through. Keeping the thumbnail opaque below
      // the fading-in original removes that dip.
      image = Stack(
        fit: StackFit.passthrough,
        children: [
          _placeholderImage(),
          CachedNetworkImage(
            imageUrl: imageUrl!,
            width: width,
            height: height,
            fit: fit,
            memCacheWidth: memCacheWidth,
            memCacheHeight: memCacheHeight,
            placeholder: (_, __) => const SizedBox.shrink(),
            errorWidget: (_, __, ___) => const SizedBox.shrink(),
          ),
        ],
      );
    } else {
      image = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        placeholder: (_, __) => _noImage(),
        errorWidget: (_, __, ___) => _noImage(),
      );
    }

    if (borderRadius == null) return image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: image,
    );
  }

  Widget _placeholderImage() => CachedNetworkImage(
        imageUrl: placeholderUrl!,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        placeholder: (_, __) => _noImage(),
        errorWidget: (_, __, ___) => _noImage(),
      );

  Widget _noImage() => Image.asset(
        noImageAsset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
}
