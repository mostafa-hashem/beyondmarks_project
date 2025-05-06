import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:beyondmarks/ui/resources/text_style.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:beyondmarks/utils/cubit/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mostafahashem319@gmail.com',
    );
    await launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Settings",
              style: font20W500(settingsCubit: settingsCubit).copyWith(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.appBarColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: colorScheme.surface,
                  child: ListTile(
                    leading: const Icon(Icons.color_lens,
                        color: AppColors.iconColor),
                    title: Text(
                      "Theme",
                      style: font14W600(settingsCubit: settingsCubit).copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    trailing: DropdownButton<ThemeMode>(
                      value: settingsCubit.themeMode,
                      dropdownColor: colorScheme.surface,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: colorScheme.onSurface,
                      ),
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(
                            "System",
                            style: font14W600(settingsCubit: settingsCubit)
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(
                            "Dark",
                            style: font14W600(settingsCubit: settingsCubit)
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(
                            "Light",
                            style: font14W600(settingsCubit: settingsCubit)
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                      ],
                      onChanged: (ThemeMode? newTheme) {
                        if (newTheme != null) {
                          settingsCubit.changeTheme(newTheme);
                        }
                      },
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: _launchEmail,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.iconColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail, color: AppColors.iconColor),
                        const SizedBox(width: 10),
                        Text(
                          settingsCubit.language == 'en'
                              ? 'Contact us'
                              : 'تواصل معنا',
                          style:
                              font14W600(settingsCubit: settingsCubit).copyWith(
                            color: AppColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
