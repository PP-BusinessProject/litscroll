part of 'api.dart';

mixin $Genres {
  @GET('/genres')
  Future<List<Genre>> getGenres();

  @GET('/me/genres')
  Future<List<UserGenreAffinity>> getUserGenres();
}

@MappableClass()
class Genre with GenreMappable {
  const Genre({required this.id, required this.name});

  final int id;

  final String name;
}

@MappableClass()
class UserGenreAffinity with UserGenreAffinityMappable {
  const UserGenreAffinity({required this.genreId, required this.score});

  @MappableField(key: 'genre_id')
  final int genreId;

  final double score;
}
