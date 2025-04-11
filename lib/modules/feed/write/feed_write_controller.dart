import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daynote/services/youtube_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../constant/enum/mood.dart';
import '../../../main.dart';
import '../../../models/feed/feed_model.dart';
import '../../../services/open_ai_service.dart';
import '../../user/user_controller.dart';

class FeedWriteController extends GetxController {
  final bool isEdit = Get.parameters['isEdit'] == 'true' ? true : false;

  TextEditingController textEditingController = TextEditingController();

  final selectedMood = Rx<Mood>(Mood.happy);

  final userCtrl = Get.find<UserController>();
  
  bool isLoading = false;

  final openAiService = Get.find<OpenAiService>();
  final youtubeDataService = Get.find<YoutubeDataService>();

  void setMood(Mood mood) => selectedMood.value = mood;
  @override
  void onInit() {
    /// 수정일 경우 데이터 세팅
    if(isEdit) {
      FeedModel feed = Get.arguments;
      textEditingController.text = feed.content;
      selectedMood.value = feed.mood;
    }

    super.onInit();
  }


  /// 일기 작성
  Future<void> submit() async {
    if (textEditingController.text.trim().isEmpty) {
      Get.snackbar('작성 실패', '일기 내용을 입력해주세요.', snackPosition: SnackPosition.TOP);
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    isLoading = true;
    update([':loading']);

    // /// chat gpt api 연동
    final Map<String, dynamic> recommendDataMap;

    try {
      recommendDataMap = await openAiService.recommendMusicAndWise(
        prompt: textEditingController.text.trim(), mood: selectedMood.value.label, age: userCtrl.currentUser.ageGroup?.label ?? '연령 모름', musicGenre:  userCtrl.currentUser.musicGenres?.map((e) => e.label,).join(",") ?? '선호하는 음악 없음',
      );
    } on Exception catch (e) {
      logger.e(e);
      Get.snackbar('작성중 에러 발생', '음악 추천 도중 에러가 발생했습니다. \n$e');
      return;
    }

    ///  youtube API 연동
    final Map<String, dynamic> youtubeDataMap;

    try {
      youtubeDataMap = await youtubeDataService.selectYoutubeDataInfo(
          prompt: '${recommendDataMap['recommendMusicArtist']} ${recommendDataMap['recommendMusic']}');
    } on Exception catch (e) {
      logger.e(e);
      Get.snackbar('작성중 에러 발생', '유튜브 데이터 검색 도중 에러가 발생했습니다. \n$e');
      return;
    }

    final now = DateTime.now();

    String feedId = const Uuid().v4();

    final feed = FeedModel(
      id: feedId,
      content: textEditingController.text.trim(),
      createdAt: now,
      date: ['일', '월', '화', '수', '목', '금', '토'][now.weekday % 7],
      mood: selectedMood.value,
      recommendMusic: recommendDataMap['recommendMusic'] ?? '',
      recommendMusicArtist: recommendDataMap['recommendMusicArtist'] ?? '',
      recommendMusicThumbnailUrl: youtubeDataMap['snippet']?['thumbnails']?['high']?['url'] ?? '',
      recommendMusicVideoId: youtubeDataMap['id']?['videoId'] ?? '',
      recommendWise: recommendDataMap['recommendWise'] ?? '',
      recommendWiseWriter: recommendDataMap['recommendWiseWriter'] ?? '',
    );

    await FirebaseFirestore.instance.collection('feeds').doc(userCtrl.currentUser.uid).collection('feedList').doc(feedId).set(feed.toJson());

    isLoading = false;
    update([':loading']);

    Get.back(closeOverlays: true); // 피드 목록으로 돌아가기
  }

  /// 일기 수정
  Future<void> modify() async {
    if (textEditingController.text.trim().isEmpty) {
      Get.snackbar('수정 실패', '일기 내용을 입력해주세요.', snackPosition: SnackPosition.TOP);
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    isLoading = true;
    update([':modifyLoading']);

    FeedModel feed = Get.arguments;

    await FirebaseFirestore.instance.collection('feeds').doc(userCtrl.currentUser.uid).collection('feedList').doc(feed.id).update({
      'content': textEditingController.text.trim(),
      'mood': selectedMood.value.name,
    });

    isLoading = false;
    update([':modifyLoading']);

    Get.back(closeOverlays: true, result: true); // 피드 목록으로 돌아가기
  }
}
