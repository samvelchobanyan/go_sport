import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class BlobSdfSet {
  final ui.Image shape1;
  final ui.Image shape2;

  const BlobSdfSet({
    required this.shape1,
    required this.shape2,
  });
}

class BlobSdfLoader {
  BlobSdfLoader._();

  static Future<ui.Image> _loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Expected:
  /// assets/blobs/sdf/blob0_shape1.png ... blob5_shape2.png
  static Future<List<BlobSdfSet>> loadAll() async {
    final result = <BlobSdfSet>[];

    for (int i = 0; i < 6; i++) {
      final shape1 =
          await _loadImage('assets/blobs/sdf/blob${i}_shape1.png');
      final shape2 =
          await _loadImage('assets/blobs/sdf/blob${i}_shape2.png');

      result.add(BlobSdfSet(
        shape1: shape1,
        shape2: shape2,
      ));
    }

    return result;
  }
}
