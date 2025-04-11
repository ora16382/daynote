import 'package:daynote/modules/home/home_view.dart';
import 'package:get/get.dart';

import '../modules/auth/auth_view.dart';
import '../modules/feed/detail/feed_detail_view.dart';
import '../modules/feed/write/feed_write_view.dart';
import '../modules/name/name_setting_view.dart';
import '../modules/profile/profile_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/youtube/youtube_player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.auth, page: () => const AuthView()),
    GetPage(name: Routes.name, page: () => const NameSettingView()),
    GetPage(name: Routes.profile, page: () => const ProfileView()),
    GetPage(name: Routes.home, page: () => HomeView()),
    GetPage(name: Routes.feedWrite, page: () => const FeedWriteView()),
    GetPage(name: Routes.feedDetail, page: () => const FeedDetailView()),
    GetPage(name: Routes.youtubePlayer, page: () => const YoutubePlayerView()),
  ];
}