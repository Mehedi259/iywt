// lib/core/routes/routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_observer.dart';
import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    debugLogDiagnostics: true,
    routes: [

      /// Onboarding
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.onBoarding1,
        path: RoutePath.onBoarding1.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.onBoarding2,
        path: RoutePath.onBoarding2.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Authentication
      GoRoute(
        name: RoutePath.enterEmail,
        path: RoutePath.enterEmail.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.verifyCode,
        path: RoutePath.verifyCode.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.privacyPolicyAuth,
        path: RoutePath.privacyPolicyAuth.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.termsAndConditionAuth,
        path: RoutePath.termsAndConditionAuth.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Profile Setup
      GoRoute(
        name: RoutePath.profileSetup1,
        path: RoutePath.profileSetup1.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.profileSetup2,
        path: RoutePath.profileSetup2.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.profileSetup3,
        path: RoutePath.profileSetup3.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.profileSetup4,
        path: RoutePath.profileSetup4.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.profileSetup5,
        path: RoutePath.profileSetup5.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.profileSetup6,
        path: RoutePath.profileSetup6.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.privacyPolicyPs,
        path: RoutePath.privacyPolicyPs.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Home
      GoRoute(
        name: RoutePath.home,
        path: RoutePath.home.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.favourites,
        path: RoutePath.favourites.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.activity,
        path: RoutePath.activity.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Scan Menu
      GoRoute(
        name: RoutePath.scanMenu,
        path: RoutePath.scanMenu.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.body,
        path: RoutePath.body.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultAll,
        path: RoutePath.scanResultAll.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultSafe,
        path: RoutePath.scanResultSafe.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultModify,
        path: RoutePath.scanResultModify.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultAvoid,
        path: RoutePath.scanResultAvoid.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultBuildMyPlate,
        path: RoutePath.scanResultBuildMyPlate.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultOrderingTips,
        path: RoutePath.scanResultOrderingTips.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanResultSaveYourMeals,
        path: RoutePath.scanResultSaveYourMeals.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.myQrCode,
        path: RoutePath.myQrCode.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Chat Bot
      GoRoute(
        name: RoutePath.askChatBot,
        path: RoutePath.askChatBot.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Profile & Settings
      GoRoute(
        name: RoutePath.myProfile,
        path: RoutePath.myProfile.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.switchProfile,
        path: RoutePath.switchProfile.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.editProfile,
        path: RoutePath.editProfile.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.notification,
        path: RoutePath.notification.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.helpAndSupport,
        path: RoutePath.helpAndSupport.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.accountSettings,
        path: RoutePath.accountSettings.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.changePassword,
        path: RoutePath.changePassword.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.termsAndCondition,
        path: RoutePath.termsAndCondition.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.privacyPolicy,
        path: RoutePath.privacyPolicy.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.aboutUs,
        path: RoutePath.aboutUs.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      /// Subscription
      GoRoute(
        name: RoutePath.subscription,
        path: RoutePath.subscription.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
    ],
    observers: [routeObserver],
  );

  static GoRouter get route => initRoute;
}

extension BasePathExtension on String {
  String get addBasePath => '/$this';
}
