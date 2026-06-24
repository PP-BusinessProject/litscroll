import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'route_05_reader.g.dart';

@TypedGoRoute<ReaderRoute>(path: '/reader/:bookId')
class ReaderRoute extends GoRouteData with $ReaderRoute {
  const ReaderRoute(this.bookId);

  /// The id of the [Book] to read in this route.
  final int bookId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      state.extra is ReaderScreen
      ? state.extra! as ReaderScreen
      : ReaderScreen(bookId);

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: build(context, state),
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => FadeTransition(opacity: animation, child: child),
  );
}

class ReaderScreen extends HookConsumerWidget {
  const ReaderScreen(this.bookId, {super.key});

  /// The id of the [Book] to read on this screen.
  final int bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super
      .debugFillProperties(properties..add(IntProperty('bookId', bookId)));
}
