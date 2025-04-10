import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../constant/enum/mood.dart';
import '../../../util/app_color.dart';
import 'feed_write_controller.dart';

class FeedWriteView extends StatelessWidget {
  const FeedWriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedWriteController());

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: GestureDetector(child: Text(controller.isEdit ? '일기 수정' : '일기 작성')),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Text(
                          '오늘의 일기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// 작성 박스
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            maxLines: 10,
                            maxLength: 1000,
                            controller: controller.textEditingController,
                            decoration: const InputDecoration(
                              hintText: '오늘 있었던 일을 편하게 적어보세요 :)',
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        const Text(
                          '기분 선택',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// 기분 선택 이미지
                        Obx(() {
                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children:
                                Mood.values.map((mood) {
                                  final isSelected =
                                      controller.selectedMood.value == mood;
                                  return GestureDetector(
                                    onTap: () => controller.setMood(mood),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  isSelected
                                                      ? Colors.blue
                                                      : Colors.transparent,
                                              width: 2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            mood.emoji,
                                            style: TextStyle(fontSize: 36),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          mood.label,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                isSelected
                                                    ? Colors.black
                                                    : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          );
                        }),
                        const SizedBox(height: 36),
                        if(controller.isEdit) Text('* 일기를 수정해도 음악과 명언은 새로 추천되지 않습니다.', style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
                ),

                /// 작성 버튼
                Container(
                  width: double.infinity,
                  height: 48,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.isEdit ? controller.modify : controller.submit,
                    child: Text(
                      controller.isEdit ? '수정 완료' : '작성 완료',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GetBuilder<FeedWriteController>(
          id: ':loading',
          builder: (ctrl) {
            if (controller.isLoading) {
              return Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(128),
                  child: Center(
                    child: Image.asset(
                      'assets/images/loading_cat.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        GetBuilder<FeedWriteController>(
          id: ':modifyLoading',
          builder: (ctrl) {
            if (controller.isLoading) {
              return Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(128),
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
