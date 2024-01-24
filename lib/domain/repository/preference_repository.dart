import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PreferenceRepository {
  PreferenceRepository(this._prefs);
  final SharedPreferences _prefs;
  static PreferenceRepository get instance => getIt<PreferenceRepository>();

  @postConstruct
  void init() {
    try {
      if (_prefs.getString(_countryKey) != null) {
        _country = Country.fromJson(jsonDecode(_prefs.getString(_countryKey)!));
      }

      if (_prefs.getString(_regionKey) != null) {
        _region = Region.fromJson(jsonDecode(_prefs.getString(_regionKey)!));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static const String _guestKey = 'guest';
  static const String _cartKey = 'cart';
  static const String _regionKey = 'region';
  static const String _countryKey = 'country';
  static const String _cookie = 'cookie';

  bool get isGuest => _prefs.getBool(_guestKey) ?? false;
  String? get cartId => _prefs.getString(_cartKey);
  String? get cookie => _prefs.getString(_cookie);
  Future<void> setCookie(String cookie) async => await _prefs.setString(_cookie, cookie);
  Future<void> deleteCookie() async => await _prefs.remove(_cookie);
  Country? _country;
  Region? _region;
  Country? get country => _country;
  Region? get region => _region;
  static String get currencyCode =>
      instance._region?.currencyCode?.toUpperCase() ?? 'USD';

  void setGuest({bool? value}) => _prefs.setBool(_guestKey, value ?? true);
  Future<bool> setCartId(String cartId) async =>
      await _prefs.setString(_cartKey, cartId);

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
