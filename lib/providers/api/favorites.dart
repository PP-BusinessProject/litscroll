part of '../api.dart';

@Riverpod(dependencies: <Object>[api])
class Favorites extends _$Favorites {
  API get _api => ref.read(apiProvider);

  @override
  Future<List<FavoriteQuoteResponse>> build() => _api.getFavorites();

  Future<void> refresh() async {
    state = const AsyncLoading<List<FavoriteQuoteResponse>>();
    state = await AsyncValue.guard(() => _api.getFavorites());
  }

  Future<void> unlike(int quoteId) async {
    await _api.unlikeQuote(quoteId);
    final List<FavoriteQuoteResponse> current = state.requireValue;
    state = AsyncData<List<FavoriteQuoteResponse>>(
      current
          .where((FavoriteQuoteResponse e) => e.quote.id != quoteId)
          .toList(),
    );
  }

  Future<void> like(int quoteId) async {
    await _api.likeQuote(quoteId);
    await refresh();
  }

  bool isFavorite(int quoteId) =>
      state.value?.any((FavoriteQuoteResponse e) => e.quote.id == quoteId) ??
      false;
}
