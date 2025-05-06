import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:beyondmarks/ui/resources/text_style.dart';
import 'package:beyondmarks/ui/widgets/default_text_button.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:beyondmarks/utils/path.dart';
import 'package:flutter/material.dart' hide Path;
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please update ${Path.appName} app to continue",
                  style: font14W600(settingsCubit: settingsCubit),
                ),
                const SizedBox(
                  height: 18,
                ),
                DefaultTextButton(
                  backgroundColor: AppColors.appBarColor,
                  function: () {
                    _launchURL();
                  },
                  text: 'Update',
                  textStyle: font14W600(settingsCubit: settingsCubit)
                      .copyWith(color: Colors.white),
                  width: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    const String url = '';
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $uri';
    }
  }
}
