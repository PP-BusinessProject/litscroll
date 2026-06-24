part of 'api.dart';

mixin $Home {
  @GET('/home')
  Future<HomeResponse> getHome();
}

@MappableClass()
class HomeResponse with HomeResponseMappable {
  const HomeResponse({
    required this.recommendedQuotes,
    required this.popularBooks,
    required this.favoriteGenres,
    required this.continueReading,
  });

  @MappableField(key: 'recommended_quotes')
  final List<FeedItem> recommendedQuotes;

  @MappableField(key: 'popular_books')
  final List<Book> popularBooks;

  @MappableField(key: 'favorite_genres')
  final List<UserGenreAffinity> favoriteGenres;

  @MappableField(key: 'continue_reading')
  final List<BookQuoteUser> continueReading;
}
