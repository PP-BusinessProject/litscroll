import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';
import 'package:portal_labs/portal_labs.dart';

import 'generated/i18n.g.dart';
import 'providers/preferences.dart';
import 'providers/supabase/authorization.dart';
import 'routes/route_00_splash.dart';
import 'routes/route_01_onboarding_welcome.dart';
import 'routes/route_02_onboarding_information.dart';
import 'routes/route_03_home.dart';
import 'routes/route_04_book.dart';
import 'routes/route_05_reader.dart';
import 'routes/route_06_favorites.dart';
import 'styles.dart';

/// The route in the app.
enum Routes<Extra extends Object?> {
  /// The splash screen.
  splash<SplashScreen?>(SplashRoute()),

  /// The welcome screen.
  onboardingWelcome<OnboardingWelcomeScreen?>(OnboardingWelcomeRoute()),

  /// The information screen.
  onboardingInformation<OnboardingInformationScreen?>(
    OnboardingInformationRoute(),
  ),

  /// The home screen.
  home<HomeScreen?>(HomeRoute()),

  /// The book screen.
  book<BookScreen?>(BookRoute(0)),

  /// The reader screen.
  reader<ReaderScreen?>(ReaderRoute(0)),

  /// The favorites screen.
  favorites<FavoritesScreen?>(FavoritesRoute());

  /// The route in the app.
  const Routes(this._route, {this.key});

  /// The internal value of this route.
  GoRouteData get route => _route!;
  final GoRouteData? _route;

  /// The key for this route.
  final Key? key;

  /// The router to use in app.
  static final List<RouteBase> routes = <RouteBase>[
    $splashRoute,
    $onboardingWelcomeRoute,
    $onboardingInformationRoute,
    $homeRoute,
    $bookRoute,
    $readerRoute,
    $favoritesRoute,
  ];

  /// Return the current route depending on app's state.
  static Future<Routes<Object?>> current(ProviderContainer container) async {
    await container.read(authorizationProvider.future);
    return onboardingWelcome;
  }

  /// The route location as specified in [route].
  String get location => route.location;

  /// The wrapper method on [GoRouter.go].
  void go(GoRouter router, {Extra? extra}) =>
      router.go(location, extra: extra);

  /// The wrapper method on [GoRouter.push].
  Future<T?> push<T extends Object?>(GoRouter router, {Extra? extra}) =>
      router.push<T>(location, extra: extra);

  /// The wrapper method on [GoRouter.pushReplacement].
  Future<T?> pushReplacement<T extends Object?>(
    GoRouter router, {
    Extra? extra,
  }) => router.pushReplacement<T>(location, extra: extra);

  /// The wrapper method on [GoRouter.replace].
  Future<T?> replace<T extends Object?>(GoRouter router, {Extra? extra}) =>
      router.replace<T>(location, extra: extra);
}

/// The wrapper around [MaterialApp] to support hot reload.
@immutable
class RoutesApp extends HookConsumerWidget {
  /// The wrapper around [MaterialApp] to support hot reload.
  const RoutesApp(this.router, {super.key});

  /// The router to use in the app.
  final GoRouter router;

  /// Navigator key used for testing.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final I18N i18n = I18N.of(context);
    final AppTheme appTheme = ref.watch(themeProvider).requireValue.instance;
    final Locale appLocale = ref.watch(localeProvider).requireValue;
    return MixScope(
      colors: appTheme.colors,
      spaces: appTheme.spaces,
      radii: appTheme.radii,
      textStyles: appTheme.textStyles,
      doubles: appTheme.blurRadii,
      child: PortalTheme(
        data: PortalThemeData(
          colors: appTheme.portalColors,
          typography: appTheme.portalTypography,
        ),
        child: MaterialApp.router(
          title: i18n.appName,
          debugShowCheckedModeBanner: false,
          locale: appLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          routerConfig: router,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          builder: (BuildContext context, Widget? child) {
            final ThemeData theme = Theme.of(context);
            final MediaQueryData mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
              child: DefaultTextStyle(
                style: theme.textTheme.titleMedium ?? const TextStyle(),
                textAlign: TextAlign.center,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarIconBrightness: Brightness.dark,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(mediaQuery.size),
                    child: Material(child: child),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties..add(DiagnosticsProperty<GoRouter>('router', router)),
      );
}
