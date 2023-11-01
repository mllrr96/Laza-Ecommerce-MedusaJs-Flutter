import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class PreferenceRepository {
  final SharedPreferences _prefs = getIt.get<SharedPreferences>();

  static const String _guestKey = 'guest';

  bool get isGuest => _prefs.getBool(_guestKey) ?? false;

  void setGuest() => _prefs.setBool(_guestKey, true);
}
