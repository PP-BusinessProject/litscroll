import 'package:flutter_test/flutter_test.dart';
import 'package:litscroll/api/api.dart';
import 'package:litscroll/generated/env.g.dart';
import 'package:litscroll/providers/api.dart';
import 'package:litscroll/providers/preferences.dart';
import 'package:resilify/resilify_dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'fake_shared_preferences_async.dart';

Future<ProviderContainer> createContainer() async {
  final Dio dio = Dio();
  SharedPreferencesAsyncPlatform.instance = FakeSharedPreferencesAsync();
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      dioProvider.overrideWithValue(dio),
      apiProvider.overrideWithValue(API(dio, baseUrl: Config.apiUrl)),
      preferencesProvider.overrideWithValue(SharedPreferencesAsync()),
    ],
  );
  await Future.wait(<Future<Object>>[
    container.read(themeProvider.future),
    container.read(localeProvider.future),
  ]);

  expect(container.read(apiProvider), isNotNull);
  expect(container.read(dioProvider), isNotNull);

  return container;
}
