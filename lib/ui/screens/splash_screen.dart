import 'package:beyondmarks/route_manager.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SettingsCubit settingsCubit;

  @override
  void initState() {
    settingsCubit = SettingsCubit.get(context);
    super.initState();
    _initStart();
  }

  Future<void> _initStart() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    settingsCubit.onboardingDone
        ? Navigator.pushReplacementNamed(context, Routes.studentInputScreen)
        : Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    final logoWidth =
        isPortrait ? screenSize.width * 0.5 : screenSize.width * 0.3;

    return Scaffold(
      backgroundColor: const Color(0xFF0175C2),
      body: Center(
        child: SizedBox(
          width: logoWidth,
          height: logoWidth,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
