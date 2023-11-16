import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PreferenceRepository {
  PreferenceRepository(this._prefs);
  final SharedPreferences _prefs;

  void init() {
    if (_prefs.getString(_countryKey) != null) {
      _country = Country.fromJson(jsonDecode(_prefs.getString(_countryKey)!));
    }

    if (_prefs.getString(_regionKey) != null) {
      _region = Region.fromJson(jsonDecode(_prefs.getString(_regionKey)!));
    }
  }

  static const String _guestKey = 'guest';
  static const String _cartKey = 'cart';
  static const String _regionKey = 'region';
  static const String _countryKey = 'country';

  bool get isGuest => _prefs.getBool(_guestKey) ?? false;
  String? get cartId => _prefs.getString(_cartKey);
  Country? _country;
  Region? _region;
  Country? get country => _country;
  Region? get region => _region;
  String get currencyCode => _region?.currencyCode?.toUpperCase() ?? 'USD';

  void setGuest({bool? value}) => _prefs.setBool(_guestKey, value ?? true);
  Future<bool> setCartId(String cartId) async => await _prefs.setString(_cartKey, cartId);

  Future<bool> setCountry(Country country) async {
    try {
      final jsonCountry = jsonEncode(country.toJson());
      _country = country;
      return await _prefs.setString(_countryKey, jsonCountry);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> setRegion(Region region) async {
    try {
      final jsonRegion = jsonEncode(region.toJson());
      _region = region;
      return await _prefs.setString(_regionKey, jsonRegion);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
