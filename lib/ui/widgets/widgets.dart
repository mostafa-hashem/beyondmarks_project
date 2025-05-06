
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Color color, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    ),
  );
}

// void showLanguageSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return LanguageBottomSheet();
//     },
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16.r),
//     ),
//   );
// }


Rect getWidgetPosition(GlobalKey key, {double spacing = 40.0}) {
  final RenderBox? renderBox =
      key.currentContext?.findRenderObject() as RenderBox?;
  final offset = renderBox!.localToGlobal(Offset.zero);
  return Rect.fromLTWH(
    offset.dx - spacing,
    offset.dy + spacing,
    renderBox.size.width + (spacing * 2),
    renderBox.size.height + (spacing * 2),
  );
}
