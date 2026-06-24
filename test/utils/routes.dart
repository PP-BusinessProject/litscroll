import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:litscroll/generated/i18n.g.dart';
import 'package:litscroll/routes.dart';

import 'riverpod.dart';

extension PumpRoute on Routes<Object?> {
  Future<void> pump(WidgetTester tester) async {
    final ProviderContainer container = await createContainer();
    final GoRouter router = GoRouter(routes: Routes.routes);
    go(router);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(child: RoutesApp(router)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  }
}
