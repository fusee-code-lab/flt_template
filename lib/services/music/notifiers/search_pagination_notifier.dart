import 'dart:async';

import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/services/music/music_providers.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: implementation_imports
import 'package:dart_music_api/src/response_pack.dart';

typedef SearchCursorBuilder<Q, T> = ResultCursor<Q, ListResponsePack<T>> Function(MusicApi, String);

class SearchPaginationNotifier<Q, T> extends AutoDisposeFamilyAsyncNotifier<List<T>, String> {
  final int _pageSize;
  final SearchCursorBuilder<Q, T> _buildCursor;
  late ResultCursor<Q, ListResponsePack<T>> _cursor;

  SearchPaginationNotifier({
    required int pageSize,
    required SearchCursorBuilder<Q, T> buildCursor,
  })  : _pageSize = pageSize,
        _buildCursor = buildCursor;

  @override
  FutureOr<List<T>> build(String arg) {
    final api = ref.watch(musicApiProvider);
    _cursor = _buildCursor(api, arg);
    return _cursor.limit(_pageSize).nextPage().then((value) => value?.data ?? []);
  }

  Future<void> loadMore() async {
    talker.debug("triggered load more");
    final data = await _cursor.nextPage();
    final original = state.value ?? [];
    state = AsyncValue.data(original..addAll(data?.data ?? []));
  }
}
