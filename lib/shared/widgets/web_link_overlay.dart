import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deprecated: the in-app iframe overlay has been removed.
///
/// This is intentionally a no-op to keep the API stable for any old call sites.
@Deprecated('In-app iframe overlay removed; use launchExternalUrl for navigation.')
Future<void> showWebLinkOverlay(
  BuildContext context, {
  required String url,
  String title = 'Preview',
}) async {
  // No overlay. Intentionally does nothing.
}
