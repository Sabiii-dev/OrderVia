class SocialConfig {
  const SocialConfig({
    required this.facebookPageUrl,
    required this.instagramProfileUrl,
  });

  /// Example: https://www.facebook.com/yourpage or https://m.me/yourpage
  final String facebookPageUrl;

  /// Example: https://instagram.com/yourhandle
  final String instagramProfileUrl;

  /// Best-effort DM link (works for Facebook pages with messaging enabled).
  String get facebookDmUrl {
    // If user already provided an m.me link, use it.
    if (facebookPageUrl.contains('m.me/')) return facebookPageUrl;

    // Attempt to derive m.me/<slug> from a facebook.com/<slug> URL.
    final uri = Uri.tryParse(facebookPageUrl);
    final seg = uri?.pathSegments.where((s) => s.isNotEmpty).toList() ?? const [];
    if (seg.isNotEmpty) {
      return 'https://m.me/${seg.first}';
    }

    return facebookPageUrl;
  }
}

/// TODO: Update these.
const socialConfig = SocialConfig(
  facebookPageUrl: 'https://web.facebook.com/OrderVia/',
  instagramProfileUrl: 'https://www.instagram.com/orderviaa/',
);
