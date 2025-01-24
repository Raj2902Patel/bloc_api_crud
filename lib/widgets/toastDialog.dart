import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

void toastDialog({
  required BuildContext context,
  required Widget message,
  required Widget leadingIcon,
  required Duration animationDuration,
  required Duration displayDuration,
}) {
  InteractiveToast.slide(
    context,
    leading: leadingIcon,
    title: message,
    toastSetting: SlidingToastSetting(
      animationDuration: animationDuration,
      displayDuration: displayDuration,
      toastStartPosition: ToastPosition.top,
      toastAlignment: Alignment.topCenter,
    ),
  );
}
