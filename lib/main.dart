import 'package:beyondmarks/route_manager.dart';
import 'package:beyondmarks/ui/resources/my_theme.dart';
import 'package:beyondmarks/ui/widgets/loading_indicator.dart';
import 'package:beyondmarks/utils/bloc_observer.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_state.dart';
import 'package:beyondmarks/utils/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(
    BlocProvider(
      create: (_) => SettingsCubit(),
      lazy: false,
      child: const BeyondMarks(),
    ),
  );
}

class BeyondMarks extends StatefulWidget {
  const BeyondMarks({super.key});

  @override
  State<BeyondMarks> createState() => _BeyondMarksState();
}

class _BeyondMarksState extends State<BeyondMarks> {
  late SettingsCubit settingsCubit;
  final String requiredVersion = '1.0.0';
  String? appVersion;
  String routeName = Routes.splash;
  bool isLoading = true;

  @override
  void initState() {
    settingsCubit = SettingsCubit.get(context);
    getPreferences(settingsCubit);
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      if (isOutdatedVersion(appVersion!, requiredVersion)) {
        routeName = Routes.updateScreen;
      } else {
        routeName = Routes.splash;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(body: LoadingIndicator()),
      );
    }
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (_, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: settingsCubit.themeMode,
          initialRoute: routeName,
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}
