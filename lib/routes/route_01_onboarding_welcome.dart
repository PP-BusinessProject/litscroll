import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';

import '../generated/i18n.g.dart';
import '../routes.dart';
import '../styles.dart';

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
    final I18N i18n = I18N.of(context);
    final I18N$onboarding$a01OnboardingWelcome$en_US pageI18n =
        i18n.onboarding.a01OnboardingWelcome;

    // Dark solid canvas background matching Figma (#0A0E1A)
    final BoxStyler canvasStyle = BoxStyler().color(const Color(0xFF0A0E1A));

    // Logo Icon Box (#10172F container, 60x60, 16px radius, border #2A3A6A)
    final BoxStyler logoContainerStyle = BoxStyler()
        .color(const Color(0xFF10172F))
        .borderRadius(.all($Radius.small()))
        .border(.all(.color(const Color(0xFF2A3A6A)).width(1.5)))
        .width(60)
        .height(60)
        .alignment(.center);

    final TextStyler logoTextStyle = TextStyler()
        .fontSize(20)
        .fontWeight(FontWeight.w700)
        .color(const Color(0xFFE8ECFF))
        .height(1.21);

    final TextStyler titleStyle = TextStyler()
        .fontSize(24)
        .fontWeight(FontWeight.w700)
        .color(Colors.white)
        .height(1.21)
        .textAlign(TextAlign.center);

    final TextStyler descriptionStyle = TextStyler()
        .fontSize(14)
        .fontWeight(FontWeight.w400)
        .color(const Color(0xFF7E90BF))
        .height(1.21)
        .textAlign(TextAlign.center);

    final TextStyler swipeTextStyle = TextStyler()
        .fontSize(12)
        .fontWeight(FontWeight.w400)
        .color(const Color(0xFF4C5D8B))
        .height(1.21);

    // Primary Action Button (#3F63C6 blue fill, 56px height, 16px radius)
    final BoxStyler buttonStyle = BoxStyler()
        .color(const Color(0xFF3F63C6))
        .borderRadius(.all($Radius.medium()))
        .height(56)
        .width(double.infinity)
        .alignment(.center)
        .onHovered(
          BoxStyler()
              .scale(1.02)
              .color(const Color(0xFF486FE0))
              .shadow(
                .color(const Color(0x663F63C6))
                    .blurRadius($BlurRadius.small())
                    .offset(x: 0, y: 4),
              ),
        )
        .onPressed(BoxStyler().scale(0.97))
        .animate(.easeOut(const Duration(milliseconds: 180)));

    final TextStyler buttonTextStyle = TextStyler()
        .fontSize(16)
        .fontWeight(FontWeight.w700)
        .color(Colors.white)
        .height(1.21);

    final TextStyler footerTextStyle = TextStyler()
        .fontSize(12)
        .fontWeight(FontWeight.w400)
        .color(const Color(0xFF485984))
        .height(1.21)
        .textAlign(TextAlign.center);

    return canvasStyle(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 16),

                    // 1. Top Logo Box (60x60, 16px radius, border #2A3A6A)
                    Box(
                      style: logoContainerStyle,
                      child: Image.asset(
                        'source/assets/onboarding/logoonboarding.png',
                        width: 27,
                        height: 27,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 2. App Name (LitScroll, Inter 700 20px, #E8ECFF)
                    StyledText(pageI18n.appName, style: logoTextStyle),

                    const SizedBox(height: 29),

                    // 3. Central Illustration (Groupslide.png 280x280)
                    Image.asset(
                      'source/assets/onboarding/Groupslide.png',
                      width: 280,
                      height: 280,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 2.5),

                    // 4. Swipe Indicator (^ Icon 13px + Swipe to explore Inter 400 12px)
                    const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 13,
                      color: Color(0xFF4C5D8B),
                    ),
                    const SizedBox(height: 4),
                    StyledText(
                      pageI18n.swipeToExplore,
                      style: swipeTextStyle,
                    ),

                    const SizedBox(height: 39),

                    // 5. Headline (Discover Literature in Immersive Passages, Inter 700 24px)
                    StyledText(
                      '${pageI18n.titleLine1}\n${pageI18n.titleLine2}',
                      style: titleStyle,
                    ),

                    const SizedBox(height: 7.7),

                    // 6. Description Body (Inter 400 14px, #7E90BF)
                    SizedBox(
                      width: 312,
                      child: StyledText(
                        pageI18n.description,
                        style: descriptionStyle,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 7. Primary Action Button (Start Reading, 312x56, #3F63C6, Inter 700 16px)
                    SizedBox(
                      width: 312,
                      child: PressableBox(
                        style: buttonStyle,
                        onPress: () => Routes.onboardingInformation.go(router),
                        child: StyledText(
                          pageI18n.startReading,
                          style: buttonTextStyle,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14.9),

                    // 8. Footer Info Text (Inter 400 12px, #485984)
                    StyledText(pageI18n.footer, style: footerTextStyle),

                    const SizedBox(height: 15.3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
