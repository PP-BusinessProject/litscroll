part of 'api.dart';

mixin $Feed {
  @GET('/feed')
  Future<FeedResponse> getFeed({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });
}

@MappableClass()
class FeedResponse with FeedResponseMappable {
  const FeedResponse({required this.items, this.nextCursor});

  final List<FeedItem> items;

  @MappableField(key: 'next_cursor')
  final String? nextCursor;
}

@MappableClass()
class FeedItem with FeedItemMappable {
  const FeedItem({
    required this.book,
    required this.quote,
    required this.score,
  });

  final Book book;
  final BookQuote quote;
  final double score;
}
