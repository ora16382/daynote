import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daynote/constant/enum/age_group.dart';
import 'package:daynote/constant/enum/music_genre.dart';
import 'package:daynote/modules/user/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user/user_model.dart';

class ProfileController extends GetxController {
  final bool isEdit = Get.parameters['isEdit'] == 'true' ? true : false;

  final Rxn<AgeGroup> ageGroup = Rxn();
  final selectedGenres = <MusicGenre>[].obs;

  @override
  void onInit() {
    /// 수정일 경우 데이터 세팅
    if(isEdit) {
      UserModel user = Get.find<UserController>().currentUser;
      ageGroup.value = user.ageGroup;
      if(user.musicGenres != null) {
        selectedGenres.addAll(user.musicGenres!);
      }
    }

    super.onInit();
  }

  void toggleGenre(MusicGenre genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
  }

  Future<void> saveProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'ageGroup': ageGroup.value?.name,
      'musicGenres': selectedGenres.map((genre) => genre.name).toList(),
    });

    await Get.find<UserController>().loadUser(isOnlyLoad: true);

    Get.back(result: isEdit);
  }

  /// 스킵 콜백
  Future<void> onTapSkipBtn() async {
      if(await Get.dialog<bool>(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '지금 건너뛰시겠어요?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '이 설정은 나중에 마이페이지에서\n다시 수정할 수 있어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
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
                          Get.back(result: true);     // 다이얼로그 닫고
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('확인'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ) ?? false){
        Get.back();
      }
  }
}
