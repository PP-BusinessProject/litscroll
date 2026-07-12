part of 'api.dart';

mixin $UserQuotes {
  @GET('/me/quotes')
  Future<List<BookQuoteUser>> getUserQuotes();

  @GET('/me/quotes/{quoteId}')
  Future<BookQuoteUser> getUserQuote(@Path('quoteId') int quoteId);

  @PUT('/me/quotes/{quoteId}/progress')
  Future<BookQuoteUser> updateProgress(
    @Path('quoteId') int quoteId,
    @Body() $UpdateProgress request,
  );

  @POST('/me/quotes/{quoteId}/finish')
  Future<void> finishQuote(@Path('quoteId') int quoteId);

  @POST('/me/quotes/{quoteId}/like')
  Future<void> likeQuote(@Path('quoteId') int quoteId);

  @DELETE('/me/quotes/{quoteId}/like')
  Future<void> unlikeQuote(@Path('quoteId') int quoteId);

  @GET('/me/favorites')
  Future<List<FavoriteQuoteResponse>> getFavorites();
}

@MappableClass()
class BookQuoteUser with BookQuoteUserMappable {
  const BookQuoteUser({
    required this.quoteId,
    required this.userId,
    required this.progress,
    this.finishedAt,
    this.likedAt,
  });

  @MappableField(key: 'quote_id')
  final int quoteId;

  @MappableField(key: 'user_id')
  final int userId;

  final int progress;

  @MappableField(key: 'finished_at')
  final DateTime? finishedAt;

  @MappableField(key: 'liked_at')
  final DateTime? likedAt;
}

@MappableClass()
class FavoriteQuoteResponse with FavoriteQuoteResponseMappable {
  const FavoriteQuoteResponse({required this.book, required this.quote});

  final Book book;

  final BookQuote quote;
}

@MappableClass()
class $UpdateProgress with $UpdateProgressMappable {
  const $UpdateProgress({required this.progress});

  final int progress;
}

extension DBBookQuoteUser on BookQuoteUser {
  db.BookQuoteUser toDatabase() => db.BookQuoteUser(
    quoteId: quoteId,
    progress: progress,
    finishedAt: finishedAt,
    likedAt: likedAt,
  );
}

extension APIBookQuoteUser on db.BookQuoteUser {
  BookQuoteUser toMappable() => BookQuoteUser(
    userId: 0,
    quoteId: quoteId,
    progress: progress,
    finishedAt: finishedAt,
    likedAt: likedAt,
  );
}
