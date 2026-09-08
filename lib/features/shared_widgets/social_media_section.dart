import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaSection extends StatelessWidget {
  final dynamic socialLinks;

  const SocialMediaSection({super.key, required this.socialLinks});

  Future<void> _openUrl(String? urlString) async {
    if (urlString == null || urlString.trim().isEmpty) return;

    String formattedUrl = urlString.trim();
    if (!formattedUrl.startsWith('http://') &&
        !formattedUrl.startsWith('https://')) {
      formattedUrl = 'https://$formattedUrl';
    }

    final Uri? uri = Uri.tryParse(formattedUrl);
    if (uri == null) return;

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch URL $formattedUrl: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (socialLinks == null) return const SizedBox.shrink();

    final buttons = <Widget>[
      if (_hasUrl(socialLinks.facebookUrl))
        _buildButton(
          icon: const Icon(Icons.facebook, color: DSColors.blue),
          url: socialLinks.facebookUrl,
        ),
      if (_hasUrl(socialLinks.youtubeUrl))
        _buildButton(
          icon: SvgPicture.asset('assets/icons/youtube_blue.svg'),
          url: socialLinks.youtubeUrl,
        ),
      if (_hasUrl(socialLinks.instagramUrl))
        _buildButton(
          icon: SvgPicture.asset('assets/icons/inst.svg'),
          url: socialLinks.instagramUrl,
        ),
    ];

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Wrap(spacing: DSSpacing.s10, children: buttons);
  }

  bool _hasUrl(String? url) => url != null && url.trim().isNotEmpty;

  Widget _buildButton({required Widget icon, required String? url}) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.s12),
        decoration: const BoxDecoration(
          color: DSColors.white,
          shape: BoxShape.circle,
        ),
        child: SizedBox(width: 24, height: 24, child: Center(child: icon)),
      ),
    );
  }
}
