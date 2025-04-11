import 'dart:async';

import 'package:daynote/modules/auth/auth_controller.dart';
import 'package:daynote/modules/user/user_controller.dart';
import 'package:daynote/routes/app_pages.dart';
import 'package:daynote/services/open_ai_service.dart';
import 'package:daynote/services/youtube_data_service.dart';
import 'package:daynote/util/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

Logger logger = Logger();

Future<void> main() async {
  await runZonedGuarded(() async {
    /// runZonedGuarded - 전체 앱의 오류를 잡는 안전망 역할.

    /// 위젯 바인딩
    WidgetsFlutterBinding.ensureInitialized();

    /// .env 파일 로드
    await dotenv.load(fileName: ".env");

    /// firebase 초기화
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    /// GetStorage 초기화
    await GetStorage.init();

    runApp(const DaynoteApp());
  }, (error, stack) async {
    logger.e(error);
    stack.printInfo();
  });
}

class DaynoteApp extends StatelessWidget {
  const DaynoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Daynote',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(UserController(), permanent: true);
        Get.put(AuthController(), permanent: true);
        Get.put(OpenAiService(), permanent: true);
        Get.put(YoutubeDataService(), permanent: true);
      },),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
    );
  }
}
