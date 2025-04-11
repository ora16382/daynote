import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daynote/models/feed/feed_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../util/functions.dart';
import '../../user/user_controller.dart';

class FeedDetailController extends GetxController {
  final userCtrl = Get.find<UserController>();

  /// feed 정보
  FeedModel feed = Get.arguments;

  /// youtube 영상 컨트롤러
  late YoutubePlayerController youtubePlayerController;

  /// 뒤로가기 시 YouTube 영상이 화면 가운데에 잠깐 남았다 사라지는 잔상,
  /// youtube_player_flutter의 WebView 기반 렌더링 처리 지연 때문에 생기는 문제를 해결하기 위한 변수
  bool isHidePlayer = false;

  @override
  void onInit() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: feed.recommendMusicVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        captionLanguage: 'ko',
        showLiveFullscreenButton: false,
      ),
    );

    super.onInit();
  }

  @override
  void onClose() {
    youtubePlayerController.dispose();
    super.onClose();
  }

  /// 비디오 재생 버튼 클릭 콜백
  void onTapVideoPlayBtn() {
    Get.toNamed(
      Routes.youtubePlayer,
      parameters: {'videoId': feed.recommendMusicVideoId},
    );
  }

  /// 게시글 수정 버튼 클릭 콜백
  Future<void> onTapEditBtn() async {
    if (!isSameDay(DateTime.now(), feed.createdAt)) {
      Get.snackbar('수정 불가 안내', '당일 일기만 수정할 수 있습니다.');
      return;
    }

    youtubePlayerController.pause();

    if ((await Get.toNamed(
              Routes.feedWrite,
              parameters: {'isEdit': 'true'},
              arguments: feed,
            )
            as bool?) ??
        false) {
      /// 수정했을 경우
      final snapshot =
          await FirebaseFirestore.instance
              .collection('feeds')
              .doc(userCtrl.currentUser.uid)
              .collection('feedList')
              .doc(feed.id)
              .get();

      final newFeedData = snapshot.data();

      if (newFeedData != null) {
        feed = FeedModel.fromJson(newFeedData);
        update([':content', ':mood']);
      }
    }
  }

  /// 뒤로가기 클릭 콜백
  void onTapBackBtn() {
    youtubePlayerController.pause();

    /// 플레이어 화면 숨기기
    isHidePlayer = true;
    update([':youtubePlayer']);

    Get.back();
  }
}
