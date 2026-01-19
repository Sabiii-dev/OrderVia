import 'package:flutter/widgets.dart';

/// Non-web fallback: show a simple placeholder.
Widget buildWebIFrameView(String url) {
  return const Center(
    child: Text('Preview is available on web only.'),
  );
}

