// lib/core/routes/routes.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/authentication/forget_password.dart';
import '../../presentation/screens/authentication/forget_password_otp.dart';
import '../../presentation/screens/authentication/login.dart';
import '../../presentation/screens/authentication/reset_password.dart';
import '../../presentation/screens/authentication/reset_password_success.dart';
import '../../presentation/screens/documents_screen/documents.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/legal_entry_basic/destination.dart';
import '../../presentation/screens/massage_screen/massage_screen.dart';
import '../../presentation/screens/settings/settings.dart';
import '../../presentation/screens/splash/splash.dart';
import 'route_observer.dart';
import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splash.addBasePath,
    debugLogDiagnostics: true,
    routes: [

      // ================== OnBoarding ==================
      GoRoute(
        name: RoutePath.splash,
        path: RoutePath.splash.addBasePath,
        builder: (context, state) => const SplashScreen(),
      ),

      // ================== Authentication ==================
      GoRoute(
        name: RoutePath.login,
        path: RoutePath.login.addBasePath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: RoutePath.forgetPassword,
        path: RoutePath.forgetPassword.addBasePath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        name: RoutePath.forgetPasswordOtp,
        path: RoutePath.forgetPasswordOtp.addBasePath,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        name: RoutePath.resetPassword,
        path: RoutePath.resetPassword.addBasePath,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        name: RoutePath.resetPasswordSuccess,
        path: RoutePath.resetPasswordSuccess.addBasePath,
        builder: (context, state) => const PasswordResetSuccessScreen(),
      ),

      // ================== Home ==================
      GoRoute(
        name: RoutePath.home,
        path: RoutePath.home.addBasePath,
        builder: (context, state) => const HomeScreen(),
      ),

      // ================== Legal Entry Basic ==================
      GoRoute(
        name: RoutePath.destination,
        path: RoutePath.destination.addBasePath,
        builder: (context, state) => const DestinationScreen(),
      ),

      // ================== Documents ==================
      GoRoute(
        name: RoutePath.documents,
        path: RoutePath.documents.addBasePath,
        builder: (context, state) => const DocumentsScreen(),
      ),
      GoRoute(
        name: RoutePath.preliminary,
        path: RoutePath.preliminary.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.student,
        path: RoutePath.student.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.country,
        path: RoutePath.country.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.passport,
        path: RoutePath.passport.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.scanner,
        path: RoutePath.scanner.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.edit,
        path: RoutePath.edit.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      // ================== Massage ==================
      GoRoute(
        name: RoutePath.massageScreen,
        path: RoutePath.massageScreen.addBasePath,
        builder: (context, state) => const MessageScreen(),
      ),

      // ================== Settings ==================
      GoRoute(
        name: RoutePath.settings,
        path: RoutePath.settings.addBasePath,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: RoutePath.myInformation,
        path: RoutePath.myInformation.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.studentInformation,
        path: RoutePath.studentInformation.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.address,
        path: RoutePath.address.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.addAddress,
        path: RoutePath.addAddress.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.email,
        path: RoutePath.email.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.addEmail,
        path: RoutePath.addEmail.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.phone,
        path: RoutePath.phone.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.addPhone,
        path: RoutePath.addPhone.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.changePassword,
        path: RoutePath.changePassword.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.technicalSupport,
        path: RoutePath.technicalSupport.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        name: RoutePath.privacyPolicy,
        path: RoutePath.privacyPolicy.addBasePath,
        builder: (context, state) => const Placeholder(),
      ),

      // ================== Notification ==================
      GoRoute(
        name: RoutePath.notification,
        path: RoutePath.notification.addBasePath,
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
