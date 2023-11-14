import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:rare_crew_test/shared_resources/color_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

class FlashHelper {
  static showMsgFlash(context,msg) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          position: FlashPosition.top,
          child: FlashBar(
            controller: controller,
            backgroundColor: ColorManager.hoverDarkColor,
            position: FlashPosition.top,
            behavior: FlashBehavior.fixed,
            content: Center(
              child: Text(msg,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(fontSize: 12,color: ColorManager.primaryTextDark)),
            ),
            showProgressIndicator: false,
            primaryAction: null,
          ),
        );
      },
    );
  }
}