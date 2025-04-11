import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_color.dart';
import '../../constant/enum/home_type.dart';
import '../feed/list/feed_list_view.dart';
import '../profile/my_info_view.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GestureDetector(
          child: const Text('Daynote'),
          onTap: () {
            // controller.seedDummyFeeds();
            // logger.i(Get.find<UserController>().currentUser);
          },
        ),
      ),
      body: Obx(() {
        switch (controller.homeType.value) {
          case HomeType.feed:
            return const FeedListView();
          default:
            return const MyInfoView();
        }
      }),
      bottomNavigationBar: Obx(() {
        return ConvexAppBar(
          style: TabStyle.react,
          // 기본 스타일 외에도 fixed, react, flip 등 있음
          backgroundColor: Colors.white,
          activeColor: AppColors.primary,
          color: Colors.grey,
          items: const [
            TabItem(icon: Icons.list, title: '피드'),
            TabItem(icon: Icons.person, title: '내 정보'),
          ],
          initialActiveIndex: controller.homeType.value.index,
          onTap: controller.onTapBottomNavi,
        );
      }),
    );
  }
}
