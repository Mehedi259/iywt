
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'core/routes/routes.dart';

late final List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "IYWT",

          routeInformationParser: AppRouter.route.routeInformationParser,
          routerDelegate: AppRouter.route.routerDelegate,
          routeInformationProvider: AppRouter.route.routeInformationProvider,
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:camera/camera.dart';
// import 'package:device_preview/device_preview.dart';
//
// import 'core/routes/routes.dart';
//
// late final List<CameraDescription> cameras;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   cameras = await availableCameras();
//
//   runApp(
//     DevicePreview(
//       enabled: true,   // debug version: always true
//       builder: (context) => const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, __) {
//         return GetMaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           title: "IYWT",
//
//           // DevicePreview bindings
//           useInheritedMediaQuery: true,
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//
//           // GoRouter
//           routeInformationParser: AppRouter.route.routeInformationParser,
//           routerDelegate: AppRouter.route.routerDelegate,
//           routeInformationProvider: AppRouter.route.routeInformationProvider,
//         );
//       },
//     );
//   }
// }
