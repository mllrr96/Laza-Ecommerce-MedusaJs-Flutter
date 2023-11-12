import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class PreferenceRepository {
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  static const String _guestKey = 'guest';
  static const String _cartKey = 'cart';

  bool get isGuest => _prefs.getBool(_guestKey) ?? false;
  String? get cartId => _prefs.getString(_cartKey);

  void setGuest() => _prefs.setBool(_guestKey, true);
  Future<bool> setCartId(String cartId) async => await _prefs.setString(_cartKey, cartId);
}
