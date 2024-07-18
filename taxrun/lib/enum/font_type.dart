import 'package:flutter/material.dart';

enum FontWeightType { light, regular, medium, semiBold, bold }

enum FontFamilyType { roboto }

class FontType {
  static getFontFamilyType(FontFamilyType fontFamilyType) {
    switch (fontFamilyType) {
      case FontFamilyType.roboto:
        return 'Roboto';
    }
  }

  static getFontWeightType(FontWeightType fontWeightType) {
    switch (fontWeightType) {
      case FontWeightType.light:
        return FontWeight.w300;
      case FontWeightType.regular:
        return FontWeight.w400;
      case FontWeightType.medium:
        return FontWeight.w500;
      case FontWeightType.semiBold:
        return FontWeight.w600;
      case FontWeightType.bold:
        return FontWeight.w700;
    }
  }
}
