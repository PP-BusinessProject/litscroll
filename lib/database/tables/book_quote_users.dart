// not needed in database

part of '../database.dart';

/// Reading progress table.
///
/// Tracks user progress per quote.
/// Acts as local mirror of backend [BookQuoteUser].
class BookQuoteUsers extends Table {
  @override
  String get tableName => 'quote_progress';
  @override
  bool get isStrict => true;
  @override
  bool get withoutRowId => true;
  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{quoteId};

  /// Quote ID
  IntColumn get quoteId => integer().named('quote_id')();

  /// Progress 0-100
  IntColumn get progress => integer().withDefault(const Constant<int>(0))();

  /// Finished timestamp
  DateTimeColumn get finishedAt =>
      dateTime().named('finished_at').nullable()();

  /// Finished timestamp
  DateTimeColumn get likedAt => dateTime().named('finished_at').nullable()();
}
