import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp_internship/utils/appcolors.dart';

class AppTextTheme {
  static TextStyle appBarTextStyle = GoogleFonts.kanit(
      fontWeight: FontWeight.bold, fontSize: 30, color: AppColor.headTextTheme);
  static TextStyle titleTextStyle = GoogleFonts.quicksand(
      fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.headTextTheme);
  static TextStyle subTitleTextStyle = GoogleFonts.quicksand(
      fontStyle: FontStyle.italic, fontSize: 15, color: AppColor.contentColor);

  static TextStyle bodyTextStyle = GoogleFonts.quicksand(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.bodyTextColor);
}
