import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart' hide Field;

import '../database/database.dart' as db;

part 'api.g.dart';
part 'api.mapper.dart';
part 'books.dart';
part 'feed.dart';
part 'genres.dart';
part 'home.dart';
part 'onboarding.dart';
part 'quotes.dart';
part 'reading.dart';
part 'user_quotes.dart';

@RestApi(parser: Parser.DartMappable)
abstract class API
    with
        $Books,
        $Feed,
        $Genres,
        $Home,
        $Onboarding,
        $Quotes,
        $Reading,
        $UserQuotes {
  factory API(Dio dio, {String? baseUrl}) = _API;
}
