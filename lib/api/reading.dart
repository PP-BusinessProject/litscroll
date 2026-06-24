part of 'api.dart';

mixin $Reading {
  @GET('/reading-session/{bookId}')
  Future<ReadingProgress> getReadingProgress(@Path('bookId') int bookId);

  @PUT('/reading-session/{bookId}')
  Future<void> saveReadingProgress(
    @Path('bookId') int bookId,
    @Body() $ReadingProgress request,
  );
}

@MappableClass()
class ReadingProgress with ReadingProgressMappable {
  const ReadingProgress({required this.bookId, required this.currentPassage});

  final int bookId;
  final int currentPassage;
}

@MappableClass()
class $ReadingProgress with $ReadingProgressMappable {
  const $ReadingProgress({required this.currentPassage});

  final int currentPassage;
}
