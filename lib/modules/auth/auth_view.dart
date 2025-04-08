import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../util/app_color.dart' show AppColors;
import 'auth_controller.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/app_icon.png', width: 200, height: 200),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: controller.signInWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/google_logo.png', // 구글 로고 이미지 경로
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Google로 로그인',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<AuthController>(
              id: ':loading',
              builder: (ctrl) {
                if(!ctrl.isLoginProgress) {
                 return const SizedBox();
                } else {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
