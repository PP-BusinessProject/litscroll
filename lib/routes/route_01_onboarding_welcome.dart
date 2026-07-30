import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';

import '../generated/assets.gen.dart';
import '../generated/i18n.g.dart';
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
    final I18N i18n = I18N.of(context);
    final I18N$onboarding$a01OnboardingWelcome$en_US pageI18n =
        i18n.onboarding.a01OnboardingWelcome;
    final $SourceAssetsOnboardingGen onboardingAssets =
        Assets.source.assets.onboarding;

    final BoxStyler canvasStyle = BoxStyler()
        .color($ComponentColors.onboardingCanvas())
        .paddingX($Spaces.lg())
        .alignment(.center);

    final TextStyler titleStyle = AppTypography.headline().textAlign(
      TextAlign.center,
    );
    final TextStyler descriptionStyle = AppTypography.bodyDescription()
        .textAlign(TextAlign.center);
    final TextStyler footerStyle = AppTypography.footerNote().textAlign(
      TextAlign.center,
    );

    final IconStyler swipeIconStyle = IconStyler()
        .size(13)
        .color($ComponentColors.swipeIndicator());

    final BoxStyler logoImageSize = BoxStyler().width(27).height(27);
    final BoxStyler heroImageSize = BoxStyler().width(280).height(280);

    return canvasStyle(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: FlexBoxStyler()
                .column()
                .mainAxisSize(.min)
                .crossAxisAlignment(.center)(
              children: <Widget>[
                BoxStyler().height($Spaces.md())(),

                // 1. Top Logo Box Container
                Box(
                  style: AppStyles.logoContainer(),
                  child: Box(
                    style: logoImageSize,
                    child: onboardingAssets.logoonboarding.image(),
                  ),
                ),

                BoxStyler().height(15)(),

                // 2. App Name Title
                StyledText(
                  pageI18n.appName,
                  style: AppTypography.appName(),
                ),

                BoxStyler().height(29)(),

                // 3. Central Hero Illustration
                Box(
                  style: heroImageSize,
                  child: onboardingAssets.groupslide.image(
                    fit: BoxFit.contain,
                  ),
                ),

                BoxStyler().height(2.5)(),

                // 4. Swipe Indicator Icon + Label
                StyledIcon(
                  icon: Icons.keyboard_arrow_up_rounded,
                  style: swipeIconStyle,
                ),
                BoxStyler().height(4)(),
                StyledText(
                  pageI18n.swipeToExplore,
                  style: AppTypography.indicator(),
                ),

                BoxStyler().height(39)(),

                // 5. Main Headline
                StyledText(
                  '${pageI18n.titleLine1}\n${pageI18n.titleLine2}',
                  style: titleStyle,
                ),

                BoxStyler().height(7.7)(),

                // 6. Body Description
                Box(
                  style: BoxStyler().width(312),
                  child: StyledText(
                    pageI18n.description,
                    style: descriptionStyle,
                  ),
                ),

                BoxStyler().height(18)(),

                // 7. Primary Action Button
                Box(
                  style: BoxStyler().width(312),
                  child: PressableBox(
                    style: onboardingPrimaryButtonStyle(context),
                    onPress: () => Routes.onboardingInformation.go(router),
                    child: StyledText(
                      pageI18n.startReading,
                      style: AppTypography.buttonLabel(),
                    ),
                  ),
                ),

                BoxStyler().height(14.9)(),

                // 8. Footer Info Text
                StyledText(pageI18n.footer, style: footerStyle),

                BoxStyler().height(15.3)(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
