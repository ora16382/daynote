import 'package:daynote/modules/profile/my_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../util/app_color.dart';
import '../user/user_controller.dart';

class MyInfoView extends StatelessWidget {
  const MyInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyInfoController());
    final userController = Get.find<UserController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          /// ✅ 프로필 정보
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: const Text(
                  '프로필',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: controller.onTapEditProfile,
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: controller.onTapLogout,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GetBuilder<MyInfoController>(
            id: ':myInfoCard',
            builder: (_) {
              final user = userController.currentUser;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow('👤 이름', user.displayName ?? ''),
                      _infoRow('🎂 연령대', user.ageGroup?.label ?? '-'),
                      _infoRow(
                        '🎧 선호 장르',
                        user.musicGenres?.map((e) => e.label).join(', ') ?? '-',
                      ),
                    ],
                  ),
                ),
              );
            }
          ),

          const SizedBox(height: 32),

          /// ✅ 앱 정보
          const Text(
            '앱 정보',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: FutureBuilder<PackageInfo>(
              future: controller.loadPackageInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '현재 버전 : @version'.trParams({
                            'version': snapshot.data?.version ?? 'unknown',
                          }),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('오픈소스 라이선스'),
            leading: const Icon(Icons.article_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLicensePage(context: context),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
