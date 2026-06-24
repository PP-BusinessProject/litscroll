part of '../api.dart';

@Riverpod(dependencies: <Object>[api, database])
class Reader extends _$Reader {
  API get _api => ref.read(apiProvider);
  db.Database get _db => ref.read(databaseProvider);
  Future<String?> _getUserId() => ref.read(
    authorizationProvider.selectAsync((Session? session) => session?.user.id),
  );

  @override
  Future<BookQuote> build(int quoteId) async {
    final BookQuote? cached = await _db.getQuoteById(quoteId);
    if (cached != null) {
      return cached;
    }
    final BookQuote remote = await _api.getQuote(quoteId);
    await _db.bookQuotes.insertOne(remote.toDatabase());
    return remote;
  }

  Future<void> like() async {
    final String? userId = await _getUserId();
    if (userId != null) {
      await _db.bookQuoteUsers.insertOnConflictUpdate(
        db.BookQuoteUsersCompanion(
          quoteId: Value<int>(quoteId),
          likedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    }
    await _api.likeQuote(quoteId);
    ref.invalidateSelf();
  }

  Future<void> unlike() async {
    final String? userId = await _getUserId();
    if (userId != null) {
      await _db.bookQuoteUsers.insertOnConflictUpdate(
        db.BookQuoteUsersCompanion(
          quoteId: Value<int>(quoteId),
          likedAt: const Value<DateTime?>(null),
        ),
      );
    }
    await _api.unlikeQuote(quoteId);
    ref.invalidateSelf();
  }

  Future<void> finish() async {
    final String? userId = await _getUserId();
    if (userId != null) {
      await _db.bookQuoteUsers.insertOnConflictUpdate(
        db.BookQuoteUser(
          quoteId: quoteId,
          progress: 100,
          finishedAt: DateTime.now(),
        ),
      );
    }
    await _api.finishQuote(quoteId);
    ref.invalidateSelf();
  }

  Future<void> updateProgress(int progress) async {
    final String? userId = await _getUserId();
    if (userId != null) {
      await _db.bookQuoteUsers.insertOnConflictUpdate(
        db.BookQuoteUser(quoteId: quoteId, progress: progress),
      );
    }
    await _api.updateProgress(quoteId, $UpdateProgress(progress: progress));
  }
}
