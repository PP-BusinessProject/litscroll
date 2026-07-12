part of '../api.dart';

@Riverpod(dependencies: <Object>[api, database])
class Books extends _$Books {
  API get _api => ref.read(apiProvider);
  db.Database get _db => ref.read(databaseProvider);

  @override
  Future<List<Book>> build() async {
    final List<db.Book> cached = await _db.books.all().get();
    if (cached.isNotEmpty) {
      return cached.map((db.Book book) => book.toMappable()).toList();
    }

    final PaginatedBookResponse remote = await _api.getBooks();
    await _db.books.deleteAll();
    await _db.books.insertAll(
      remote.items.map((Book book) => book.toDatabase()),
    );
    return remote.items;
  }

  Future<void> refresh() async {
    final PaginatedBookResponse remote = await _api.getBooks();
    await _db.books.deleteAll();
    await _db.books.insertAll(
      remote.items.map((Book book) => book.toDatabase()),
    );
    state = AsyncData<List<Book>>(remote.items);
  }
}
