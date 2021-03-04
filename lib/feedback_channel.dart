import 'dart:async';

import 'package:flutter/services.dart';

class FeedbackChannel {
  static const String feedback = "com.ai.marki/feedback";

  static const _platform = const MethodChannel(feedback);

  static const String _gotoFeedback = "gotoFeedback"; // 跳转反馈页面
  static const String _openWechat = "openWechat"; // 打开微信

  static void gotoFeedback() {
    _platform.invokeMethod(_gotoFeedback);
  }

  static Future<bool> openWechat(String clipboardText) async {
    Completer completer = new Completer<bool>();
    try {
      final bool result =
          await _platform.invokeMethod(_openWechat, clipboardText ?? "");
      completer.complete(result);
    } on PlatformException catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
