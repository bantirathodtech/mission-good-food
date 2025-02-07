import 'package:flutter/material.dart';

class GlobalTextStyles {
  //TODO:Font families
  static const String interFont = 'Inter';
  static const String quicksandFont = 'Quicksand';
  static const String robotoFont = 'Roboto';
  static const String dmSansFont = 'DMSans';

  ////////////////////////////////////////////////////////////////
  //TODO:Base Text Styles
  static const TextStyle headline = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle subHeadline = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  //TODO: Quicksand Styles
  static TextStyle qsTitle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      fontFamily: GlobalTextStyles.quicksandFont,
      color: Colors.black);
  static TextStyle qs20w7black = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      fontFamily: GlobalTextStyles.quicksandFont,
      color: Colors.black);
  static TextStyle qs22w7black = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      fontFamily: GlobalTextStyles.quicksandFont,
      color: Colors.black);
  static TextStyle qs22w7Green = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      fontFamily: GlobalTextStyles.quicksandFont,
      color: Color.fromRGBO(79, 165, 111, 1));
  static TextStyle qs24w7Black = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: GlobalTextStyles.quicksandFont,
  );
  static TextStyle qs32w6Black = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: GlobalTextStyles.quicksandFont,
  );
  static TextStyle qs11w5Black = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: GlobalTextStyles.quicksandFont);
  static TextStyle qs11w5Grey = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(151, 152, 153, 1),
      fontFamily: GlobalTextStyles.quicksandFont);
  static TextStyle qs11w5Green = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(35, 170, 73, 1),
      fontFamily: GlobalTextStyles.quicksandFont);
  static TextStyle qs13w7Black = TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: GlobalTextStyles.quicksandFont);
  static TextStyle qs14w6Black = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: GlobalTextStyles.quicksandFont);
  static TextStyle qs16w7Black = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: GlobalTextStyles.quicksandFont);

  //TODO: DMSans Styles
  static TextStyle dms10w5Black = TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: GlobalTextStyles.dmSansFont);
  static TextStyle dms11w5Grey = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(151, 152, 153, 1),
      fontFamily: GlobalTextStyles.dmSansFont);
  static TextStyle dms11w5Green = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(35, 170, 73, 1),
      fontFamily: GlobalTextStyles.dmSansFont);
  static TextStyle dms11w6Green = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(35, 170, 73, 1),
      fontFamily: GlobalTextStyles.dmSansFont);

  //TODO: Roboto Styles
  static TextStyle roboto16w7White = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: GlobalTextStyles.robotoFont);

  //TODO: Default Styles
  //Size 10
  static const TextStyle tiny3Black = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static const TextStyle tiny4Black = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  //Size 12
  static const TextStyle small3Black = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static const TextStyle small4Black = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle small5Black = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const TextStyle small6Black = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const TextStyle small7Black = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  //Size 13
  static const TextStyle compact4Grey = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const TextStyle compact5Grey = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  //Size 14
  static const TextStyle regular4Black = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle regular5Black = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const TextStyle regular6Black = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const TextStyle regular7Black = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle regular4Grey = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const TextStyle regular4SlateGrey = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(138, 141, 159, 1),
  );
  //Size 15
  static const TextStyle medium4Black = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle medium4White = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  //Size 16
  static const TextStyle large4Black = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle large4White = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle large4Grey = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const TextStyle large5Black = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const TextStyle large5Red = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Colors.red,
  );
  static const TextStyle large7Red = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w700,
    color: Colors.red,
  );
  //Size 17
  static const TextStyle extraLarge4Black = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  //Size 18
  static const TextStyle huge5Black = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const TextStyle huge6Black = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
