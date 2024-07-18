import 'package:taxrun/enum/font_type.dart';
import 'package:flutter/material.dart';

///
/// This class contains
/// all UI related styles
///
class AppTheme extends StatefulWidget {
  final Widget? child;

  const AppTheme({
    super.key,
    @required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return AppThemeState();
  }

  static AppThemeState of(BuildContext context) {
    final _InheritedStateContainer? inheritedStateContainer =
        context.dependOnInheritedWidgetOfExactType();
    if (inheritedStateContainer == null) {
      return AppThemeState();
    } else {
      return inheritedStateContainer.data!;
    }
  }
}

class AppThemeState extends State<AppTheme> {
  ///
  /// Define All your colors here which are used in whole application
  ///

  //Color get primaryColor => const Color(0xffEF3B85);

  //Color get primaryColor => Platform.isAndroid ? const Color(0xffFF74B4) : const Color(0xffec407a);
  Color get primaryColor => const Color(0xffec407a);

  Color get dtBlackColor => const Color(0xff222222);

  Color get trainingCardBgColor => const Color(0xff404040);

  Color get trainingCardBorderColor => const Color(0xffBEBEBE);

  Color get trainingCardShadowColor => const Color(0xff6B6B6B);

  Color get trainingResultTextColor => const Color(0xff15B412);

  Color get trainingResultFailTextColor => const Color(0xffC60A0A);

  Color get trainingResultQueBgColor => const Color(0xff3e3e3e);

  Color get trainingResultQueBorderColor => const Color(0xff8c8c8c);

  Color get trainingResultAnsBgColor => const Color(0xff343434);

  Color get supportBorderColor => const Color(0xff3b3b3b);

  Color get myProfileSecondBgColor => const Color(0xff535151);

  Color get myProfileThirdBgBorderColor => const Color(0xff716f6f);

  Color get resendColor => const Color(0xff989191);

  Color get speedDialLabelBgLT => const Color(0xff7A6F6F);

  Color get speedDialLabelBgDT => const Color(0xff6A6A6A);

  Color get greyColor => const Color(0xffE5E5E5);

  Color get separatorColor => const Color(0xffDADADA);

  Color get dropdownSeparatorColor => const Color(0xffC2C2C2);

  Color get greyBorderColor => const Color(0xffA4A4A4);

  Color get greyBgColor => const Color(0xffe9e9e9);

  Color get supportFABBgColor => const Color(0xfff2f2f2);

  Color get bgCardColor => const Color(0xffAD8955);

  Color get whiteColor => const Color(0xFFFFFFFF);

  Color get blackFontColor => const Color(0xFF535353);

  Color get popupBgColor => const Color(0xFF000000).withOpacity(0.6);

  Color get shadowColor => const Color(0xFF000000).withOpacity(0.16);

  Color get greenColor => Colors.green;

  Color get greyColorShade3 => const Color(0xff616161);

  Color get greyColorShade4 => const Color(0xff434343);

  Color get greyColorShade5 => const Color(0xff3C3C3C);

  Color get greyColorShade6 => const Color(0xff434343);

  Color get greyColorShade7 => const Color(0xff3C3C3C);

  TextStyle customTextStyle(
      {double? fontSize,
      Color? color,
      FontWeightType? fontWeightType,
      FontFamilyType? fontFamilyType,
      double? height,
      TextDecoration? decoration,
      FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
        fontWeight: FontType.getFontWeightType(
            fontWeightType ?? FontWeightType.regular),
        fontFamily:
            FontType.getFontFamilyType(fontFamilyType ?? FontFamilyType.roboto),
        fontSize: fontSize,
        fontStyle: fontStyle,
        height: height ?? 1.5,
        decoration: decoration ?? TextDecoration.none,
        color: color);
  }

  ///
  /// List of your Text Styles which are used through this app.
  ///

  double get buttonTextSize => 20;

  double get textFieldTextSize => 18;

  double get titleTextSize => 20;

  double get subTitleTextSize => 18;

  double get subTitleItalicTextSize => 18;

  double get successToastTextSize => 14;

  double get textSize => 14;

  double get smallTextSize => 12;

  double get cardBorderRadius => 12;

  FontWeightType get buttonFontWeightType => FontWeightType.bold;

  FontWeightType get textFieldFontWeightType => FontWeightType.semiBold;

  FontWeightType get titleFontWeightType => FontWeightType.semiBold;

  FontWeightType get subTitleFontWeightType => FontWeightType.semiBold;

  FontWeightType get subTitleItalicFontWeightType => FontWeightType.semiBold;

  FontWeightType get lightWeightType => FontWeightType.light;

  FontWeightType get mediumWeightType => FontWeightType.medium;

  FontWeightType get regularWeightType => FontWeightType.regular;

  FontWeightType get semiBoldWeightType => FontWeightType.semiBold;

  FontWeightType get boldWeightType => FontWeightType.bold;

  List<BoxShadow> get cardBoxShadow => [
        BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 4,
            spreadRadius: 4)
      ];

  BoxDecoration get cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: cardBoxShadow,
      );

  TextStyle get headerTextStyle => customTextStyle(
      color: greyColorShade5, fontSize: 18, fontWeightType: boldWeightType);

  TextStyle get textFiledStyle => customTextStyle(
      color: greyColorShade5, fontWeightType: semiBoldWeightType);

  TextStyle get labelStyle => customTextStyle(
      height: 1,
      fontSize: 14,
      color: greyColorShade5,
      fontWeightType: boldWeightType);

  TextStyle get radioTextStyle =>
      customTextStyle(height: 1, fontSize: 14, color: greyColorShade5);

  InputDecoration textFieldDecoration(String hint) => InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(left: 8, top: 12, bottom: 8),
        labelText: hint,
        labelStyle: customTextStyle(color: greyColor),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 0.7),
            borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 0.7),
            borderRadius: BorderRadius.circular(4)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 1),
            borderRadius: BorderRadius.circular(4)),
      );

  InputDecoration textFieldSubmitDecoration(String hint) => InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        hintText: hint,
        labelStyle: customTextStyle(color: greyColor),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 0.7)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 0.7)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColorShade3, width: 1.4)),
      );

  ButtonStyle get btnStyle => ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      backgroundColor: primaryColor,
      textStyle: customTextStyle(
          fontSize: 20, fontWeightType: boldWeightType, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

  ButtonStyle get submitBtnStyle => ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      backgroundColor: primaryColor,
      textStyle: customTextStyle(
          fontSize: 16,
          fontWeightType: semiBoldWeightType,
          color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)));

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppThemeState? data;

  _InheritedStateContainer({
    @required this.data,
    @required Widget? child,
  }) : super(child: child!);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
