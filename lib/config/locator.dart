// import 'package:get_it/get_it.dart';
// import 'package:laza/repositories/preference_repository.dart';
// import 'package:medusa_store_flutter/config.dart';
// import 'package:medusa_store_flutter/medusa_store_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// /// Global [GetIt.instance].
// final GetIt locator = GetIt.instance;
//
// /// Set up [GetIt] locator.
// Future<void> setUpLocator() async {
//   // final File logOutputFile = await LogUtil.initLogFile();
//   //
//   locator
//     ..registerSingleton<MedusaStore>(MedusaStore(Config(baseUrl: 'http://localhost:9000/', enableDebugging: false)))
//     ..registerSingleton<PreferenceRepository>(PreferenceRepository(prefs: await SharedPreferences.getInstance()));
//   //   ..registerSingleton<PostRepository>(PostRepository())
//   //   ..registerSingleton<SembastRepository>(SembastRepository())
//   //   ..registerSingleton<OfflineRepository>(OfflineRepository())
//   //   ..registerSingleton<DraftCache>(DraftCache())
//   //   ..registerSingleton<CommentCache>(CommentCache())
//   //   ..registerSingleton<LocalNotificationService>(LocalNotificationService())
//   //   ..registerSingleton(AppReviewService());
// }
