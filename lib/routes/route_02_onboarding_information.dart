import 'package:flutter/foundation.dart';
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
    final GoRouter router = GoRouter.of(context);
    final I18N i18n = I18N.of(context);
    final I18N$onboarding$a02OnboardingInformation$en_US pageI18n =
        i18n.onboarding.a02OnboardingInformation;

    // Access generated PNG assets from Assets.source.assets.route02
    final $SourceAssetsRoute02Gen route02Assets = Assets.source.assets.route02;

    // Outer page container with animated background gradient
    final BoxStyler backgroundStyle = futuristicBackground(
      context,
    ).alignment(.center).paddingX($Spaces.lg()).paddingY($Spaces.xl());

    // Logo layout styles
    final FlexBoxStyler headerLogoStyle = FlexBoxStyler()
        .row()
        .spacing($Spaces.xs())
        .mainAxisAlignment(.center)
        .mainAxisSize(.min)
        .crossAxisAlignment(.center);

    // Feature cards list with exact tokenized color palette
    final List<Widget> featureCards = <Widget>[
      _FeatureCard(
        icon: route02Assets.scroll,
        iconSize: 23,
        title: pageI18n.card1Title,
        description: pageI18n.card1Description,
        accentColor: $ComponentColors.infoCardPurple.resolve(context),
      ),
      _FeatureCard(
        icon: route02Assets.compass,
        iconSize: 23,
        title: pageI18n.card2Title,
        description: pageI18n.card2Description,
        accentColor: $ComponentColors.infoCardBlue.resolve(context),
      ),
      _FeatureCard(
        icon: route02Assets.heart,
        iconSize: 23,
        title: pageI18n.card3Title,
        description: pageI18n.card3Description,
        accentColor: $ComponentColors.infoCardPink.resolve(context),
      ),
    ];

    final BoxStyler headerIconSize = BoxStyler().width(27).height(27);

    return backgroundStyle(
      child: SafeArea(
        child: SingleChildScrollView(
          child:
              FlexBoxStyler()
                  .column()
                  .spacing($Spaces.lg())
                  .crossAxisAlignment(.center)(
                children: <Widget>[
                  // Header logo book image + Title
                  headerLogoStyle(
                    children: <Widget>[
                      Box(
                        style: AppStyles.bookIconContainer(),
                        child: Box(
                          style: headerIconSize,
                          child: route02Assets.book.image(
                            color: $ComponentColors.infoSubtitle.resolve(
                              context,
                            ),
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                      ),
                      AppTypography.headline()(pageI18n.appName),
                    ],
                  ),
                  // Reimagined Subtitle
                  AppTypography.subtitle()(pageI18n.subtitle),
                  // Feature Cards List
                  FlexBoxStyler()
                      .column()
                      .spacing($Spaces.md())(children: featureCards),
                  // Primary Action Button
                  PressableBox(
                    style: onboardingPrimaryButtonStyle(context),
                    onPress: () => Routes.home.go(router),
                    child: AppTypography.buttonLabel()(pageI18n.beginReading),
                  ),
                  // Back Link
                  Pressable(
                    onPress: () => Routes.onboardingWelcome.go(router),
                    child: AppTypography.linkText()(pageI18n.backToWelcome),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

/// A private reusable component to display a feature introduction card
/// matching exact Figma 1:1 specs (Node 275:2058 / 2102 / 2145).
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
    // Figma 1:1 Specs: 8% accent fill background, 2px 100% accent border
    final BoxStyler cardStyle = BoxStyler()
        .color(accentColor.withValues(alpha: 0.08))
        .border(.all(.color(accentColor).width(2)))
        .borderRadius(.all($Radius.medium()))
        .shadow(
          .color(
            accentColor.withValues(alpha: 0.08),
          ).blurRadius($BlurRadius.large()).offset(x: 0, y: 4),
        )
        .padding(.all($Spaces.md()));

    // Figma 1:1 Specs: 15% accent fill icon box container
    final BoxStyler iconContainerStyle = BoxStyler()
        .color(accentColor.withValues(alpha: 0.15))
        .borderRadius(.all($Radius.small()))
        .padding(.all($Spaces.sm()));

    final TextStyler titleStyle = AppTypography.cardTitle();
    final TextStyler descriptionStyle = AppTypography.cardDescription()
        .textAlign(TextAlign.left);

    final BoxStyler iconBoxStyle = BoxStyler()
        .width(iconSize)
        .height(iconSize);

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
                child: Box(
                  style: iconBoxStyle,
                  child: icon.image(
                    color: accentColor,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
              titleStyle(title),
            ],
          ),
          // Expanse Description Text (#94A3B8)
          descriptionStyle(description),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(DiagnosticsProperty<AssetGenImage>('icon', icon))
          ..add(DoubleProperty('iconSize', iconSize))
          ..add(StringProperty('title', title))
          ..add(StringProperty('description', description))
          ..add(ColorProperty('accentColor', accentColor)),
      );
}
