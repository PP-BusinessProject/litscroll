import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'route_06_favorites.g.dart';

@TypedGoRoute<FavoritesRoute>(path: '/favorites')
class FavoritesRoute extends GoRouteData with $FavoritesRoute {
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      state.extra is FavoritesScreen
      ? state.extra! as FavoritesScreen
      : const FavoritesScreen();

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

class FavoritesScreen extends HookConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();
}
