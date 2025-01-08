import 'package:dio/dio.dart';
import 'package:flt_template/components/toast.dart';
import 'package:flt_template/router/router.dart';
import 'package:flutter/material.dart';

class CommonHandler extends Interceptor {
  BuildContext get context => NavigationService.navigatorKey.currentContext!;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) {
      // 具体的业务逻辑类网络错误，由各音乐 API 实现类处理
    } else {
      final message = err.displayMessage;
      context.toastError(message, position: ToastPosition.top);
    }

    super.onError(err, handler);
  }
}

extension DioExceptionExt on DioException {
  String get displayMessage {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return "网络连接超时，请检查网络设置";
      case DioExceptionType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioExceptionType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioExceptionType.badResponse:
        return "服务器异常";
      case DioExceptionType.cancel:
        return "请求已被取消，请重新请求";
      case DioExceptionType.unknown:
        return "网络异常，请稍后重试！";
      case DioExceptionType.badCertificate:
        return "证书异常，请检查网络设置";
      default:
        return "网络异常，请稍后重试！";
    }
  }
}
