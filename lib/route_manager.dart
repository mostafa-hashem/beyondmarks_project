import 'package:beyondmarks/features/student_input_screen/cubit/student_input_cubit.dart';
import 'package:beyondmarks/features/student_input_screen/ui/student_input_screen.dart';
import 'package:beyondmarks/ui/onbording/onboarding_screen.dart';
import 'package:beyondmarks/ui/screens/settings_screen.dart';
import 'package:beyondmarks/ui/screens/splash_screen.dart';
import 'package:beyondmarks/ui/screens/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String updateScreen = "/updateScreen";
  static const String studentInputScreen = "/studentInputScreen";
  static const String splash = "/splashScreen";
  static const String settingsScreen = "/settingsScreen";
  static const String onboardingScreen = "/onboardingScreen";
}

Route? onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.updateScreen:
      return MaterialPageRoute(
        builder: (_) => const UpdateScreen(),
        settings: routeSettings,
      );
    case Routes.splash:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case Routes.studentInputScreen:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => StudentInputCubit(),
          child: const StudentInputScreen(),
        ),
        settings: routeSettings,
      );
    case Routes.settingsScreen:
      return MaterialPageRoute(
        builder: (_) => const SettingsScreen(),
        settings: routeSettings,
      );
    case Routes.onboardingScreen:
      return MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: routeSettings,
      );
    default:
      return null;
  }
}
