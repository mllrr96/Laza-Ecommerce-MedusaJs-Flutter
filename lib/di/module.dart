import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/config.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/routes/app_router.dart';

@module
abstract class RegisterCoreDependencies {
  @singleton
  final AppRouter appRouter = AppRouter();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  final MedusaStore medusaStore = MedusaStore(Config(baseUrl: 'http://172.19.13.95:9000/', enableDebugging: false));
}
