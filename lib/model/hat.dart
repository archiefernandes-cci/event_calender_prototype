import 'package:flutter/material.dart';

class Hat {
  String hatName;
  IconData hatIcon;
  Color hatColor;

  Hat({
    required this.hatName,
    required this.hatColor,
    required this.hatIcon,
  });
}

Color hatBackgroundColor(Color color, [double amount = 0.2]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
