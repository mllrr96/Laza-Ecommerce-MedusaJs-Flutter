import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  // text styles

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get bodyLargeW500 => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMediumW500 => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmallW500 => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyExtraSmallW500 => bodySmallW500?.copyWith(fontSize: 11);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodyExtraSmall => bodySmallW500?.copyWith(fontSize: 11, fontWeight: FontWeight.normal);

  // theme
  ThemeData get theme => Theme.of(this);

  // media query
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  double get bottomViewPadding => MediaQuery.of(this).viewPadding.bottom;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension TextStyleColor on TextStyle {
  TextStyle dark() {
    return copyWith(color: Colors.white);
  }
}
