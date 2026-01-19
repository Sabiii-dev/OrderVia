import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalUrl(
  String url,
) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;

  final ok = await launchUrl(
    uri,
    mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
    webOnlyWindowName: kIsWeb ? '_self' : null,
  );

  if (!ok) {
    throw StateError('Could not launch $url');
  }
}
