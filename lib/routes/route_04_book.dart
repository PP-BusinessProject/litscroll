import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'route_04_book.g.dart';

@TypedGoRoute<BookRoute>(path: '/book/:bookId')
class BookRoute extends GoRouteData with $BookRoute {
  const BookRoute(this.bookId);

  /// The id of the [Book] to show in this route.
  final int bookId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      state.extra is BookScreen
      ? state.extra! as BookScreen
      : BookScreen(bookId);

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

class BookScreen extends HookConsumerWidget {
  const BookScreen(this.bookId, {super.key});

  /// The id of the [Book] to show on this screen.
  final int bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super
      .debugFillProperties(properties..add(IntProperty('bookId', bookId)));
}
