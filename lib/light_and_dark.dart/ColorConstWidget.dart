import 'package:flutter/material.dart';

class ColorConst {
  static const Color colorPrimary = Color(0xFF170937);
  static const Color colorPrimary30 = Color(0x305127AF);
  static const Color colorPrimary50 = Color(0x505127AF);
  static const Color colorPrimary80 = Color(0x805127AF);
  static const Color colorPrimary120 = Color(0xBB5127AF);
  static const Color colorSecondary = Color(0xFF5127AF);
  static const Color colorTertiary = Color(0xFF2F1370);
  static const Color colorQuaternary = Color(0xFF5127AF);
  static const Color colorBottombar = Color(0xFF693E9F);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorGray = Color.fromARGB(255, 72, 72, 72);
  static const Color colorBackgroundSecondary = Color(0xFFE6E9EF);
  static const Color colorBackgroundTertiary = Color(0xFF669999);
  static const Color backgroundScaffoldColor = Color(0xFFF3F3F3);
  static const Color colorPrimaryText = Color(0xFFFFFFFF);
  static const Color colorPrimaryTextDark = Color(0xFFF5F5F5);
  static const Color colorBackgroundGray = Color(0xffE6EBEE);
  static const Color colorGrey = Color(0xff999999);
  static const Color colorConfigButtonBackground = Color(0xff183153);
  static const Color colorDanger = Color(0xffdc3545);
  static const Color colorSuccess = Color(0xff67c23a);
  static const Color colorWarning = Color(0xffe6a23c);
  static const Color colorFail = Color(0xfff56c6c);
  static const Color colorButtonSnackBarLoginColor = Color(0xff669999);
  static const Color colorButtonCategory1 = Color(0xffff0049);
  static const Color colorPrimaryTextLight = Color(0xff515356);
  static const Color colorPrimaryTextLight1 = Color(0xff183153);
  static const Color colorTextStory = Color(0xff515356);
  static const Color colorTextStory1 = Color(0xff183153);
  static const Color colorTextVip = Color(0xffEBC05C);
  static const Color colorTextVip2 = Color(0xffF2C740);
  static const Color colorVipBackground = Color(0xff050028);
  static const Color colorReadStoryBackground = Color(0xffbfe2fd);
  static const Color colorVipBackground2 = Color(0xff515356);
  static const Color colorBackgroundStory = Color(0xffF6F6F6);
  static const Color colorRedFreeBackground = Color(0xffB51C2C);
  static const Color colorRedFreeBackground1 = Color(0xffD00E17);
  static const Color colorOrange = Color(0xffFA7935);
  static const Color colorBorderLogin = Color(0xff6d470e);
  static const Color colorGradientPalaceHolderBackgroundBegin =
      Color(0xffFEE5E6);
  static const Color colorGradientPalaceHolderBackgroundEnd = Color(0xffD5D5D5);
  static const Color colorBgButtonRadio = Color(0xff3B3B4F);
  static const Color colorBgNovelGray = Color(0xffdcdcdc);
  static const Color colorBgNovelBlack = Color(0xff111111);
  static const Color colorBgNovelYellow = Color(0xffF1EDA9);
  static const Color colorDotColor = Color(0xFFFF5A93);
  static const Color colorBgElevatedButtonColor = Color(0xFF1A65C7);
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorConst.colorPrimary, ColorConst.colorSecondary]);

  static const Gradient vipGradientBackground = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topCenter,
      colors: [ColorConst.colorVipBackground, ColorConst.colorVipBackground2]);

  static Gradient placeHolderGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorConst.colorGradientPalaceHolderBackgroundBegin.withOpacity(1.0),
        ColorConst.colorGradientPalaceHolderBackgroundEnd.withOpacity(1.0)
      ]);

  static Gradient fourButtonsGradientBackground = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        // Color(0xFF30A0CE),
        // Color(0xFFAD5C96),
        Color(0xFF398DBF),
        Color(0xFFE04086),
      ]);
  static LinearGradient shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
