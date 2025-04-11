import 'package:daynote/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../routes/app_pages.dart';

class MyInfoController extends GetxController {
  final authController = Get.find<AuthController>();

  Future<PackageInfo> loadPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  /// 로그아웃 클릭 콜백
  Future<void> onTapLogout() async {
    if (await Get.dialog<bool>(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '로그아웃 하시겠습니까?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(), // 취소
                          child: const Text('취소'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back(result: true); // 다이얼로그 닫고
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('확인'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false) {
      authController.signOut();
    }
  }

  /// 개인정보 수정 클릭 콜백
  Future<void> onTapEditProfile() async {
    if ((await Get.toNamed(Routes.profile, parameters: {'isEdit': 'true'})
            as bool?) ??
        false) {
      /// 수정했을 경우
      update([':myInfoCard']);
    }
  }
}
