part of 'api.dart';

mixin $Books {
  @GET('/books')
  Future<PaginatedBookResponse> getBooks({
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
    @Query('genre_id') int? genreId,
    @Query('query') String? query,
  });

  @GET('/books/popular')
  Future<List<Book>> getPopularBooks();

  @GET('/books/{id}')
  Future<Book> getBook(@Path('id') int id);

  @GET('/books/{id}/quotes')
  Future<List<BookQuote>> getBookQuotes(@Path('id') int id);
}

@MappableClass()
class PaginatedBookResponse with PaginatedBookResponseMappable {
  const PaginatedBookResponse({
    required this.items,
    required this.page,
    required this.total,
    required this.pages,
  });

  final List<Book> items;

  final int page;

  final int total;

  final int pages;
}

@MappableClass()
class Book with BookMappable {
  const Book({
    required this.id,
    required this.title,
    required this.authorName,
    required this.year,
    required this.pageCount,
    required this.genres,
    this.description,
    this.image,
  });

  final int id;

  final String title;

  final String? description;

  @MappableField(key: 'author_name')
  final String authorName;

  final int year;

  @MappableField(key: 'page_count')
  final int pageCount;

  final Uint8List? image;

  final List<Genre> genres;
}
