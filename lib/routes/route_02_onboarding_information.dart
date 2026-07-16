import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';

import '../generated/assets.gen.dart';
import '../generated/i18n.g.dart';
import '../routes.dart';
import '../styles.dart';
import '../styles/glass.dart';

part 'route_02_onboarding_information.g.dart';

/// The route definition for the onboarding information screen.
@TypedGoRoute<OnboardingInformationRoute>(path: '/onboarding/02_information')
class OnboardingInformationRoute extends GoRouteData
    with $OnboardingInformationRoute {
  /// Creates an [OnboardingInformationRoute].
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

/// The onboarding information screen displaying core features with PNG assets.
class OnboardingInformationScreen extends HookConsumerWidget {
  /// Creates an [OnboardingInformationScreen].
  const OnboardingInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = I18N.of(context);
    final pageI18n = i18n.onboarding.a02OnboardingInformation;

    // Access the generated PNG assets from Assets.source.assets.route_02
    final route02Assets = Assets.source.assets.route02;

    // Outer page container with animated background gradient
    final backgroundStyle = futuristicBackground(
      context,
    ).alignment(.center).paddingX($Spaces.lg()).paddingY($Spaces.xl());

    // Logo layout styles (сжимаем по ширине и центрируем логотип)
    final headerLogoStyle = FlexBoxStyler()
        .row()
        .spacing($Spaces.xs())
        .mainAxisAlignment(.center)
        .mainAxisSize(.min)
        .crossAxisAlignment(.center);

    final logoTextStyle = TextStyler()
        .style($TextStyles.h2())
        .color($Colors.textPrimary());

    final subtitleStyle = TextStyler()
        .style($TextStyles.bodyLarge())
        .color($GlassColors.neonPurple.resolve(context));

    // Styles for the main interactive button
    final buttonStyle = BoxStyler()
        .color($GlassColors.neonPurple())
        .borderRadius(.all($Radius.medium()))
        .padding(.symmetric(horizontal: $Spaces.xl(), vertical: $Spaces.md()))
        .width(double.infinity)
        .alignment(.center)
        .onHovered(
          BoxStyler()
              .scale(1.03)
              .shadow(
                .color(
                  $GlassColors.neonPurple().withValues(alpha: 0.5),
                ).blurRadius($BlurRadius.small()).offset(x: 0, y: 0),
              ),
        )
        .onPressed(BoxStyler().scale(0.97))
        .animate(.easeOut(const Duration(milliseconds: 180)));

    final buttonTextStyle = TextStyler()
        .style($TextStyles.labelButton())
        .color($Colors.textPrimary());

    final linkTextStyle = TextStyler()
        .style($TextStyles.bodyMedium())
        .color($Colors.textSecondary())
        .decoration(TextDecoration.underline);

    // List of card configurations with precise Figma dimensions and PNG assets
    final List<_FeatureCardData> cardList = <_FeatureCardData>[
      _FeatureCardData(
        icon: route02Assets.scroll,
        iconSize: 23.0, // Sized precisely at 18x18 for balance
        title: pageI18n.card1Title,
        description: pageI18n.card1Description,
        accentColor: $GlassColors.neonPurple.resolve(context),
      ),
      _FeatureCardData(
        icon: route02Assets.compass, // Card 2 is Compass
        iconSize: 23.0,
        title: pageI18n.card2Title,
        description: pageI18n.card2Description,
        accentColor: $GlassColors.neonBlue.resolve(context),
      ),
      _FeatureCardData(
        icon: route02Assets.heart, // Card 3 is Heart
        iconSize: 23.0,
        title: pageI18n.card3Title,
        description: pageI18n.card3Description,
        // Premium pink color accent
        accentColor: const Color(0xFFEC4899),
      ),
    ];

    return backgroundStyle(
      child: SafeArea(
        child: SingleChildScrollView(
          child:
              FlexBoxStyler()
                  .column()
                  .spacing($Spaces.lg())
                  .crossAxisAlignment(.center)(
                children: <Widget>[
                  // Header logo book image + Title (27x27 size and centered)
                  headerLogoStyle(
                    children: <Widget>[
                      route02Assets.book.image(
                        width: 27,
                        height: 27,
                        color: $GlassColors.neonPurple.resolve(context),
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      StyledText(pageI18n.appName, style: logoTextStyle),
                    ],
                  ),
                  // Reimagined Subtitle
                  StyledText(pageI18n.subtitle, style: subtitleStyle),
                  // Feature Cards List
                  FlexBoxStyler().column().spacing($Spaces.md())(
                    children: cardList
                        .map(
                          (data) => _FeatureCard(
                            icon: data.icon,
                            iconSize: data.iconSize,
                            title: data.title,
                            description: data.description,
                            accentColor: data.accentColor,
                          ),
                        )
                        .toList(),
                  ),
                  // Action Button
                  PressableBox(
                    style: buttonStyle,
                    onPress: () => Routes.home.go(GoRouter.of(context)),
                    child: StyledText(
                      pageI18n.beginReading,
                      style: buttonTextStyle,
                    ),
                  ),
                  // Back Link
                  Pressable(
                    onPress: () =>
                        Routes.onboardingWelcome.go(GoRouter.of(context)),
                    child: StyledText(
                      pageI18n.backToWelcome,
                      style: linkTextStyle,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

/// A private reusable component to display a feature introduction card.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  /// The PNG image asset from FlutterGen.
  final AssetGenImage icon;

  /// The specific layout size of the icon.
  final double iconSize;
  final String title;
  final String description;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    // Customizes global glassStyle with local neon border and shadow glow
    final cardStyle = glassStyle(context)
        .border(.all(.color(accentColor.withValues(alpha: 0.35)).width(1.5)))
        .shadow(
          .color(
            accentColor.withValues(alpha: 0.15),
          ).blurRadius($BlurRadius.large()).offset(x: 0, y: 4),
        )
        .padding(.all($Spaces.md()));

    final iconContainerStyle = BoxStyler()
        .color(accentColor.withValues(alpha: 0.15))
        .borderRadius(.all($Radius.small()))
        .padding(.all($Spaces.sm()));

    final titleStyle = TextStyler()
        .style($TextStyles.h3())
        .color($Colors.textPrimary());

    final descriptionStyle = TextStyler()
        .style($TextStyles.bodyMedium())
        .color($Colors.textSecondary())
        .textAlign(TextAlign.left);

    return Box(
      style: cardStyle,
      child: FlexBoxStyler().column().spacing($Spaces.sm())(
        children: <Widget>[
          // Header: PNG Icon Box + Card Title
          FlexBoxStyler()
              .row()
              .spacing($Spaces.md())
              .crossAxisAlignment(.center)(
            children: <Widget>[
              Box(
                style: iconContainerStyle,
                child: icon.image(
                  width: iconSize,
                  height: iconSize,
                  color: accentColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              StyledText(title, style: titleStyle),
            ],
          ),
          // Expanse Description Text
          StyledText(description, style: descriptionStyle),
        ],
      ),
    );
  }
}

/// Simple model representing specific feature card configurations with PNG.
class _FeatureCardData {
  const _FeatureCardData({
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  final AssetGenImage icon;
  final double iconSize;
  final String title;
  final String description;
  final Color accentColor;
}
