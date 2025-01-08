// usage should be like const [{ loading, error, data }, fetch] = useRequest(getFooApi) in js react
// but our version is flutter_hook

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef FunctionExt<R> = R Function();
typedef FunctionExt1<R, T> = R Function(T arg);

typedef FunctionFutureExt<R> = FunctionExt<Future<R>>;
typedef FunctionFutureExt1<R, T> = FunctionExt1<Future<R>, T>;

typedef UseRequest<T, Fetch extends Function> = ({
  bool loading,
  Error? error,
  ValueNotifier<T?> data,
  Fetch fetch,
});

UseRequest<T, Function> _useRequest<T>(
  Future<T> Function(List args) api, {
  void Function(T data)? onSuccess,
  void Function(Error error)? onError,
  void Function()? onLoading,
}) {
  final loading = useState(false);
  final error = useState<Error?>(null);
  final data = useState<T?>(null);

  final fetch = useCallback((List args) async {
    try {
      if (onLoading != null) {
        onLoading();
      }
      loading.value = true;
      final res = await api(args);
      data.value = res;
      if (onSuccess != null) {
        onSuccess(res);
      }
    } on DioException catch (e) {
      if (e.error is Error) {
        final err = e.error as Error;
        error.value = err;
        if (onError != null) {
          onError(err);
        }
      }
    } catch (e) {
      if (e is Error) {
        error.value = e;
        if (onError != null) {
          onError(e);
        }
      }
    } finally {
      loading.value = false;
    }
  }, [api]);

  return (
    loading: loading.value,
    error: error.value,
    data: data,
    fetch: fetch,
  );
}

UseRequest<T, FunctionFutureExt<void>> _useRequestVoid<T>(
  Future<T> Function() api, {
  void Function(T data)? onSuccess,
  void Function(Error error)? onError,
  void Function()? onLoading,
}) {
  final r = _useRequest<T>((_) => api(), onSuccess: onSuccess, onError: onError, onLoading: onLoading);

  final fetch = useCallback<FunctionFutureExt<void>>(() => r.fetch([]), []);

  return (
    loading: r.loading,
    error: r.error,
    data: r.data,
    fetch: fetch,
  );
}

UseRequest<T, FunctionFutureExt1<void, A>> _useRequestVoid1<T, A>(
  Future<T> Function(A arg) api, {
  void Function(T data)? onSuccess,
  void Function(Error error)? onError,
  void Function()? onLoading,
}) {
  final r = _useRequest<T>((List args) => api(args[0] as A), onSuccess: onSuccess, onError: onError, onLoading: onLoading);

  final fetch = useCallback<FunctionFutureExt1<void, A>>((A arg) => r.fetch([arg]), []);

  return (
    loading: r.loading,
    error: r.error,
    data: r.data,
    fetch: fetch,
  );
}


class _UseRequestCallVoid1 {
  UseRequest<T, FunctionFutureExt<void>> call<T>(
    Future<T> Function() api, {
    void Function(T data)? onSuccess,
    void Function(Error error)? onError,
    void Function()? onLoading,
  }) {
    return _useRequestVoid(api, onSuccess: onSuccess, onError: onError, onLoading: onLoading);
  }

  final withArg = _useRequestVoid1;
}

/// useRequest hook
///
/// Basic Usage:
/// ```dart
/// final loginRequest = useRequest(() {
///   return login(username: "admin", password: "admin");
/// });
/// ```
///
/// Or with arguments:
/// ```dart
/// final checkUsernameRequest = useRequest.withArg((String username) {
///   return checkUsername(username);
/// });
/// ```
final useRequest = _UseRequestCallVoid1();
