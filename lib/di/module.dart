import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/common/enums.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/routes/app_router.dart';

@module
abstract class RegisterCoreDependencies {
  @singleton
  final AppRouter appRouter = AppRouter();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  final MedusaStore medusaStore = MedusaStore.initialize(
      baseUrl: 'https://medusa-j2t9.onrender.com',
      interceptors: [_authInterceptor]);

  static final Interceptor _authInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      const authType = AuthenticationType.jwt;
      try {
        switch (authType) {
          case AuthenticationType.cookie:
            if (options.headers['Cookie'] != null) {
              break;
            }
            final String? cookie = PreferenceRepository.instance.cookie;
            if (cookie?.isNotEmpty ?? false) {
              options.headers['Cookie'] = cookie;
            }
            break;

          case AuthenticationType.jwt:
            if (options.headers['Authorization'] != null) {
              break;
            }
            final String? jwt = PreferenceRepository.instance.cookie;
            if (jwt?.isNotEmpty ?? false) {
              options.headers['Authorization'] = 'Bearer $jwt';
            }
            break;
        }
      } catch (_) {}
      handler.next(options);
    },
    onError: (DioException e, handler) async {
      if (e.response?.statusCode != 401) {
        handler.next(e);
        return;
      }
      try {
        await PreferenceRepository.instance.deleteCookie();
      } catch (_) {}
      handler.next(e);
    },
  );
}
