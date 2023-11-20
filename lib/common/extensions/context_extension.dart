import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

extension BuildContextEntension<T> on BuildContext {
  // text styles

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyExtraSmall => bodySmallW500?.copyWith(fontSize: 11);

  TextStyle? get bodyLargeW500 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500);
  TextStyle? get bodyMediumW500 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500);
  TextStyle? get bodySmallW500 => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500);
  TextStyle? get bodyExtraSmallW500 => bodySmallW500?.copyWith(fontSize: 11, fontWeight: FontWeight.w500);

  TextStyle? get bodyLargeW600 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600);
  TextStyle? get bodyMediumW600 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

  // theme
  ThemeData get theme => Theme.of(this);

  // media query
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  double get bottomViewPadding => MediaQuery.of(this).viewPadding.bottom;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get padding => MediaQuery.of(this).padding;


  // Directionality
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

}

extension TextStyleColor on TextStyle {
  TextStyle dark() {
    return copyWith(color: Colors.white);
  }
}
extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension FormatPrice on num? {
  String formatAsPrice(String? currencyCode, {bool includeSymbol = true, bool space = true, bool symbolAtEnd = false}) {
    if (this == null || currencyCode == null) {
      return this?.toString() ?? '';
    }
    num value = this!;
    final formatter = NumberFormat.simpleCurrency(name: currencyCode.toUpperCase());
    if (formatter.decimalDigits! > 0) {
      value /= pow(10, formatter.decimalDigits!);
    }
    final currencySymbol = formatter.currencySymbol;

    if (includeSymbol) {
      return (!symbolAtEnd ? currencySymbol : '') +
          (space && !symbolAtEnd ? ' ' : '') +
          formatter.format(value).replaceAll(currencySymbol, '') +
          (space && symbolAtEnd ? ' ' : '') +
          (symbolAtEnd ? currencySymbol : '');
    }
    return formatter.format(value).replaceAll(currencySymbol, '');
  }
}