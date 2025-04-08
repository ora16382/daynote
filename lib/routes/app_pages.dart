import 'package:get/get.dart';

import '../modules/auth/auth_view.dart';
import '../modules/mood/mood_view.dart';
import '../modules/feed/feed_write_view.dart';
import '../modules/feed/feed_list_view.dart';
import '../modules/name/name_setting_view.dart';
import '../modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.auth, page: () => const AuthView()),
    GetPage(name: Routes.name, page: () => const NameSettingView()),
    GetPage(name: Routes.mood, page: () => const MoodView()),
    GetPage(name: Routes.feedWrite, page: () => const FeedWriteView()),
    GetPage(name: Routes.feedList, page: () => const FeedListView()),
  ];
}