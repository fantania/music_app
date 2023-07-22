import 'package:flutter/material.dart';
import 'package:fantania_music_app/consts/colors.dart';
import 'package:fantania_music_app/consts/strings.dart';

getTextStyle(
    {family = fontFamily, double? textSize = 14, textColor = whiteColor}) {
  return TextStyle(
    fontSize: textSize,
    color: textColor,
    fontFamily: family,
  );
}
