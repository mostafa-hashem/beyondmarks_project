// import 'package:Talksy/i10n/app_localizations.dart';
// import 'package:Talksy/utils/cubit/settings/settings_cubit.dart';
// import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LanguageBottomSheet extends StatelessWidget {
//   const LanguageBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final settingsCubit = SettingsCubit.get(context);
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.4,
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 settingsCubit.changeLanguage("ar");
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!.arabic,
//                     style: settingsCubit.language == "en"
//                         ? GoogleFonts.novaSquare()
//                         : GoogleFonts.cairo(),
//                   ),
//                   const Spacer(),
//                   Icon(
//                     settingsCubit.language == "ar"
//                         ? Icons.check_circle_outline
//                         : Icons.circle_outlined,
//                     size: 35,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             InkWell(
//               onTap: () {
//                 settingsCubit.changeLanguage("en");
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!.english,
//                     style: settingsCubit.language == "en"
//                         ? GoogleFonts.novaSquare()
//                         : GoogleFonts.cairo(),
//                   ),
//                   const Spacer(),
//                   Icon(
//                     settingsCubit.language == "en"
//                         ? Icons.check_circle_outline
//                         : Icons.circle_outlined,
//                     size: 35,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget getUnSelectedItemWidget(String text, BuildContext context) {
//     return Text(
//       text,
//       style: Theme.of(context).textTheme.titleMedium,
//     );
//   }
// }
