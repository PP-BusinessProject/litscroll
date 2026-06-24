import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'route_02_onboarding_information.g.dart';

@TypedGoRoute<OnboardingInformationRoute>(path: '/onboarding/02_information')
class OnboardingInformationRoute extends GoRouteData
    with $OnboardingInformationRoute {
  const OnboardingInformationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      state.extra is OnboardingInformationScreen
      ? state.extra! as OnboardingInformationScreen
      : const OnboardingInformationScreen();

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

class OnboardingInformationScreen extends HookConsumerWidget {
  const OnboardingInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();
}
