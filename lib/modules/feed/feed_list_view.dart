import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth_controller.dart';

class FeedListView extends StatelessWidget {
  const FeedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            Get.find<AuthController>().signOut();
          },
          child: Text('feed_list'),
        ),
      ),
    );
  }
}

