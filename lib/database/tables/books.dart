// not needed in database

part of '../database.dart';

/// Books catalog table.
///
/// Stores metadata about books including author, description,
/// and optional cover image.
///
/// This table is append-heavy and does not enforce singleton behavior.
class Books extends Table {
  @override
  String get tableName => 'books';
  @override
  bool get isStrict => true;
  @override
  bool get withoutRowId => true;
  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  /// Book identifier
  IntColumn get id => integer()();

  /// Book title
  TextColumn get title => text().withLength(max: 256)();

  /// Optional description
  TextColumn get description => text().nullable().withLength(max: 1024)();

  /// Author name
  TextColumn get authorName =>
      text().named('author_name').withLength(max: 128)();

  /// Publication year
  IntColumn get year => integer()();

  /// Total pages
  IntColumn get pageCount => integer().named('page_count')();

  /// Cover image (binary)
  BlobColumn get image => blob().nullable()();
}

extension DBBook on api.Book {
  Book toDatabase() => Book(
    id: id,
    title: title,
    description: description,
    authorName: authorName,
    year: year,
    pageCount: pageCount,
    image: image,
  );
}

extension APIBook on Book {
  api.Book toMappable() => api.Book(
    id: id,
    title: title,
    description: description,
    authorName: authorName,
    year: year,
    pageCount: pageCount,
    image: image,
    genres: <api.Genre>[],
  );
}
