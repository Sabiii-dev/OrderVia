import 'package:flutter/foundation.dart';

import 'tawk_chat_stub.dart'
    if (dart.library.js) 'tawk_chat_web.dart';

/// Attempts to open the embedded Tawk.to chat (web only).
///
/// Returns `true` if chat was opened, otherwise `false`.
Future<bool> openTawkChat() async {
  if (!kIsWeb) return false;

  final result = openTawkChatInternal();
  return result == true;
}
