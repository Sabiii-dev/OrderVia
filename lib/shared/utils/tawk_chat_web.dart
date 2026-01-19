// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

Future<bool> openTawkChatInternal() async {
  final result = js.context.callMethod('openTawkChat');
  return result == true;
}
