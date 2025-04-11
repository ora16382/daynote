import 'package:daynote/constant/enum/age_group.dart';
import 'package:daynote/constant/enum/music_genre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_color.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!controller.isEdit)
            GestureDetector(
              onTap: controller.onTapSkipBtn,
              child: Text(
                'skip',
                style: TextStyle(color: AppColors.darkText, fontSize: 16),
              ),
            ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
        leading: controller.isEdit ? null : const SizedBox(),
      ),
      backgroundColor: const Color(0xFF4A90E2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.isEdit ? '취향이 바뀌셨나요? 정보를 수정해보세요' : '당신을 조금 더 알려주세요!',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text('연령대 선택', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Obx(
                () => Wrap(
                  spacing: 12,
                  children:
                      AgeGroup.values.map((age) {
                        final selected = controller.ageGroup.value == age;
                        return ChoiceChip(
                          label: Text(age.label),
                          selected: selected,
                          onSelected: (_) => controller.ageGroup.value = age,
                          selectedColor: AppColors.primary,
                          backgroundColor: Colors.white24,
                          labelStyle: TextStyle(
                            color:
                                selected
                                    ? AppColors.darkText
                                    : AppColors.darkText,
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              const Text('관심 음악 장르', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Obx(
                () => Wrap(
                  spacing: 12,
                  children:
                      MusicGenre.values.map((genre) {
                        final selected = controller.selectedGenres.contains(
                          genre,
                        );
                        return FilterChip(
                          label: Text(genre.label),
                          selected: selected,
                          onSelected: (_) => controller.toggleGenre(genre),
                          selectedColor: AppColors.primary,
                          backgroundColor: Colors.white24,
                          labelStyle: TextStyle(
                            color:
                                selected
                                    ? AppColors.darkText
                                    : AppColors.darkText,
                          ),
                        );
                      }).toList(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4A90E2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    controller.isEdit ? '수정 완료' : '완료하고 시작하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
