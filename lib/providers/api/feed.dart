part of '../api.dart';

@Riverpod(dependencies: <Object>[api])
class Feed extends _$Feed {
  String? _cursor;
  bool _isLoadingMore = false;

  @override
  Future<List<FeedItem>> build() async {
    final API api = ref.read(apiProvider);
    final FeedResponse response = await api.getFeed();
    _cursor = response.nextCursor;
    return response.items;
  }

  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadMore() async {
    if (_cursor == null || _isLoadingMore) {
      return;
    }

    _isLoadingMore = true;
    final API api = ref.read(apiProvider);
    final FeedResponse response = await api.getFeed(cursor: _cursor);
    _cursor = response.nextCursor;
    state = AsyncData<List<FeedItem>>(<FeedItem>[
      ...state.requireValue,
      ...response.items,
    ]);
    _isLoadingMore = false;
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<FeedItem>>();
    state = await AsyncValue.guard(() async {
      final API api = ref.read(apiProvider);
      final FeedResponse response = await api.getFeed();
      _cursor = response.nextCursor;
      return response.items;
    });
  }
}
