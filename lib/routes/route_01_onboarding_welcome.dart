import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';

import '../generated/i18n.g.dart';
import '../providers/preferences.dart';
import '../routes.dart';
import '../styles.dart';
import '../styles/glass.dart';

part 'route_01_onboarding_welcome.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<OnboardingWelcomeRoute>(path: '/onboarding/01_welcome')
class OnboardingWelcomeRoute extends GoRouteData with $OnboardingWelcomeRoute {
  /// The welcome screen of the onboarding flow.
  const OnboardingWelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      state.extra is OnboardingWelcomeScreen
      ? state.extra! as OnboardingWelcomeScreen
      : const OnboardingWelcomeScreen();

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

/// The welcome screen of the onboarding flow.
class OnboardingWelcomeScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = GoRouter.of(context);
    final I18N$onboarding$a00Splash$en_US i18n = I18N
        .of(context)
        .onboarding
        .a00Splash;

    return futuristicBackground(context).alignment(.center)(
      child:
          FlexBoxStyler()
              .column()
              .mainAxisSize(.min)
              .wrap(
                .box(
                  glassStyle(context).width(360).padding(.all($Spaces.xl())),
                ),
              )(
            children: <Widget>[
              /// Theme Button
              BoxStyler().alignment(.topRight)(
                child: PressableBox(
                  onPress: () => ref.read(themeProvider.notifier).toggle(),
                  style: glassIconButtonStyle(context),
                  child: IconStyler().size(18).color($Colors.textPrimary())(
                    icon: Icons.dark_mode,
                  ),
                ),
              ),

              IconStyler().size(64).color($GlassColors.neonBlue())(
                icon: Icons.auto_awesome,
              ),
              BoxStyler().height($Spaces.lg())(),
              TextStyler()
                  .fontSize(28)
                  .fontWeight(FontWeight.w700)
                  .color($Colors.textPrimary())
                  .textAlign(TextAlign.center)('Welcome to the Future'),
              BoxStyler().height($Spaces.sm())(),
              TextStyler()
                  .fontSize(14)
                  .color($Colors.textSecondary())
                  .textAlign(TextAlign.center)(
                'Glassmorphism AI Interface built with Mix',
              ),
              BoxStyler().height($Spaces.xl())(child: const SizedBox.shrink()),
              PressableBox(
                style: glassButtonStyle(context),
                onPress: () => Routes.onboardingInformation.go(router),
                child: TextStyler()
                    .fontSize(16)
                    .fontWeight(FontWeight.w600)
                    .color($Colors.textPrimary())('Get Started'),
              ),
              BoxStyler().height($Spaces.md())(),
              TextStyler().fontSize(12).color($Colors.textSecondary())(
                'v1.0 • Neural Interface',
              ),
            ],
          ),
    );
  } // }
}
