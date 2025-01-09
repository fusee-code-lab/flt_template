// 为 flutter context 提供 toast 方法

// required packages:
//   cherry_toast: ^1.11.0

import 'dart:async';
import 'dart:collection';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart' as cherry_toast;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _toastDuration = Duration(seconds: 2);

enum ToastPosition {
  top,
  bottom,
}

// TODO: 实现多个toast排队显示

class _ToastManager {
  static final _ToastManager _instance = _ToastManager._internal();

  final Queue<(CherryToast, GlobalKey)> _toastQueue = Queue();

  factory _ToastManager() {
    return _instance;
  }

  _ToastManager._internal();

  (CherryToast, GlobalKey) _show(BuildContext context, ToastType toastType, String title, ToastPosition position) {
    // if ios, vibrate
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      HapticFeedback.mediumImpact();
    }

    final key = GlobalKey();
    final toast = toastType.fn(
      key: key,
      title: Text(title),
      animationDuration: const Duration(milliseconds: 150),
      toastDuration: _toastDuration,
      animationCurve: Curves.easeInOut,
      enableIconAnimation: true,
      animationType:
          position == ToastPosition.bottom ? cherry_toast.AnimationType.fromBottom : cherry_toast.AnimationType.fromTop,
      toastPosition: position == ToastPosition.bottom ? cherry_toast.Position.bottom : cherry_toast.Position.top,
      displayCloseButton: false,
      onToastClosed: () {
        _toastQueue.removeFirst();

        // wait animation done
        Timer(const Duration(milliseconds: 150), () {
          _showNext(context);
        });
      },

      // theme
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      shadowColor: Theme.of(context).colorScheme.shadow.withAlpha(51),
    );

    return (toast, key);
  }

  void _showNext(BuildContext context) {
    if (_toastQueue.isEmpty) {
      return;
    }

    final (toast, _) = _toastQueue.first;
    toast.show(context);
  }

  void planShow(BuildContext context, ToastType toastType, String title, ToastPosition position) {
    final toast = _show(context, toastType, title, position);
    _toastQueue.add(toast);

    if (_toastQueue.length == 1) {
      _showNext(context);
    }
  }
}

enum ToastType {
  success,
  error,
  warning,
  info,
}

extension ToastTypeExt on ToastType {
  get fn {
    switch (this) {
      case ToastType.success:
        return CherryToast.success;
      case ToastType.error:
        return CherryToast.error;
      case ToastType.warning:
        return CherryToast.warning;
      case ToastType.info:
        return CherryToast.info;
    }
  }
}

Future<void> _showToast(
  BuildContext context,
  ToastType toastType,
  String title, {
  ToastPosition? position,
}) async {
  _ToastManager().planShow(context, toastType, title, position ?? ToastPosition.bottom);
}

// ext on ctx
extension BuildContextToastExt on BuildContext {
  void toastSuccess(String title, {ToastPosition? position}) {
    _showToast(this, ToastType.success, title, position: position);
  }

  void toastError(String title, {ToastPosition? position}) {
    _showToast(this, ToastType.error, title, position: position);
  }

  void toastWarning(String title, {ToastPosition? position}) {
    _showToast(this, ToastType.warning, title, position: position);
  }

  void toastInfo(String title, {ToastPosition? position}) {
    _showToast(this, ToastType.info, title, position: position);
  }
}
