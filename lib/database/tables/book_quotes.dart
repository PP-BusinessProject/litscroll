// not needed in database

part of '../database.dart';

/// Book quotes table.
///
/// Each quote belongs to a book and contains multiple paragraphs.
/// Like count is updated via backend triggers.
class BookQuotes extends Table {
  @override
  String get tableName => 'quotes';
  @override
  bool get isStrict => true;
  @override
  bool get withoutRowId => true;
  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  /// Quote ID
  IntColumn get id => integer()();

  /// Related book
  IntColumn get bookId => integer().named('book_id')();

  /// Total likes
  IntColumn get likeCount =>
      integer().named('like_count').withDefault(const Constant<int>(0))();

  /// Paragraphs stored as JSON string
  TextColumn get paragraphs => text()();
}

extension DBBookQuote on api.BookQuote {
  BookQuote toDatabase() => BookQuote(
    id: id,
    bookId: bookId,
    likeCount: likeCount,
    paragraphs: jsonEncode(paragraphs),
  );
}

extension APIBookQuote on BookQuote {
  api.BookQuote toMappable() => api.BookQuote(
    id: id,
    bookId: bookId,
    likeCount: likeCount,
    paragraphs: jsonDecode(paragraphs) as List<String>,
  );
}

extension BookQuotesDatabase on Database {
  Future<api.BookQuote?> getQuoteById(int id) => (select(
    bookQuotes,
  )..where(($BookQuotesTable quote) => quote.id.equals(id))).getSingleOrNull();
}
