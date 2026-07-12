part of 'api.dart';

mixin $Quotes {
  @GET('/quotes/{id}')
  Future<BookQuote> getQuote(@Path('id') int id);

  @GET('/quotes/suggested')
  Future<List<UserSuggestedQuote>> getSuggestedQuotes({
    @Query('limit') int limit = 20,
  });
}

@MappableClass()
class BookQuote with BookQuoteMappable {
  const BookQuote({
    required this.id,
    required this.bookId,
    required this.likeCount,
    required this.paragraphs,
  });

  final int id;

  @MappableField(key: 'book_id')
  final int bookId;

  @MappableField(key: 'like_count')
  final int likeCount;

  final List<String> paragraphs;
}

@MappableClass()
class UserSuggestedQuote with UserSuggestedQuoteMappable {
  const UserSuggestedQuote({
    required this.userId,
    required this.quoteId,
    required this.score,
  });

  @MappableField(key: 'user_id')
  final int userId;

  @MappableField(key: 'quote_id')
  final int quoteId;

  final double score;
}

extension DBBookQuote on BookQuote {
  db.BookQuote toDatabase() => db.BookQuote(
    id: id,
    bookId: bookId,
    likeCount: likeCount,
    paragraphs: jsonEncode(paragraphs),
  );
}

extension APIBookQuote on db.BookQuote {
  BookQuote toMappable() => BookQuote(
    id: id,
    bookId: bookId,
    likeCount: likeCount,
    paragraphs: jsonDecode(paragraphs) as List<String>,
  );
}

extension BookQuotesDatabase on db.Database {
  Future<db.BookQuote?> getQuoteById(int id) =>
      (select(bookQuotes)
            ..where((db.$BookQuotesTable quote) => quote.id.equals(id)))
          .getSingleOrNull();
}
