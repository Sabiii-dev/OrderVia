// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

Widget buildWebIFrameView(String url) {
  final viewType = 'ordervia-iframe-${url.hashCode}';

  // Register the view type once per unique URL.
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final iframe = html.IFrameElement()
      ..src = url
      ..style.border = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true;

    return iframe;
  });

  return HtmlElementView(viewType: viewType);
}

