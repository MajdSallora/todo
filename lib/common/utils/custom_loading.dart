import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomLoading {
  static void showLoading() {
    BotToast.showLoading(wrapToastAnimation: (_, a, b) {
      return const  Center(child: CircularProgressIndicator());
    });
  }

  static closeAllLoading() {
    BotToast.closeAllLoading();
  }
}
