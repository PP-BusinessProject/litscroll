import 'package:drift/drift.dart';

part 'database.g.dart';
part 'tables/book_quote_users.dart';
part 'tables/book_quotes.dart';
part 'tables/books.dart';

@DriftDatabase(tables: <Type>[Books, BookQuotes, BookQuoteUsers])
class Database extends _$Database {
  Database(super.e);

  @override
  int get schemaVersion => 1;
}
