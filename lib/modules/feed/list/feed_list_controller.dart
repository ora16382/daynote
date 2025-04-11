import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daynote/modules/user/user_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../main.dart';
import '../../../models/feed/feed_model.dart';
import '../../../routes/app_pages.dart';

class FeedController extends GetxController {
  static const int pageSize = 10;

  final userCtrl = Get.find<UserController>();

  /// 무한 스크롤 페이지 컨트롤러
  late final PagingController<int, FeedModel> pagingController;

  /// 페이지 단위로 로드시 실시간으로 추가되는 데이터 때문에 데이터가 밀리는 문제가 발생할 수 있음
  /// 해당 문제를 해결하기 위해 데이터 가져올 시점(불러온 마지막 문서)을 기록하는 객체
  DocumentSnapshot? lastDocumentSnapshot;

  /// firestore 리스너 객체
  late final StreamSubscription _subscription;

  /// Firestore의 snapshots()는 앱에서 listen이 연결될 때마다 전체 데이터에 대해 최초로 한 번 added 이벤트를 전부 보냄.
  /// 최초 구독 이벤트 무시하기위한 플래그
  bool _isFirstSnapshot = true;

  @override
  void onInit() {
    super.onInit();

    pagingController = PagingController<int, FeedModel>(
      fetchPage: _fetchPage,
      getNextPageKey: (state) {
        if (state.keys?.isEmpty ?? true) return 0;

        final isLastPage = state.pages?.last.isEmpty ?? true;
        return isLastPage ? null : (state.keys?.last ?? 0) + 1;
      },
    );

    /// 추가된 데이터 실시간 업데이트
    _subscription = FirebaseFirestore.instance
        .collection('feeds')
        .doc(userCtrl.currentUser.uid)
        .collection('feedList')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          if (_isFirstSnapshot) {
            _isFirstSnapshot = false;
            return; // 최초 이벤트 무시
          }

          for (final documentChange in snapshot.docChanges) {
            logger.i(documentChange.type);
            if (documentChange.type == DocumentChangeType.added) {
              /// 추가된 경우
              Map<String, dynamic>? data = documentChange.doc.data();

              logger.i(data);
              logger.i(pagingController.pages?.firstOrNull?.isEmpty);
              if (data != null) {
                /// no data 상태에서 새로운 데이터가 들어왔을 경우 리프래쉬
                if (pagingController.pages?.firstOrNull?.isEmpty ?? true) {
                  onRefresh();

                  /// 아래 방법이 안되는 이유는 이미 처음 요청에 대한 키가 추가되어 있기 때문이다.
                  /// 그럼 다음 키로 검색하게 되는데 처음 배열은 당연히 nodata 라 비어있기 때문에
                  /// last page 로 인식하게 되어 더이상 요청되지 않는것이다.
                  /// 그냥 refresh 하는게 편하다.
                  //pagingController.fetchNextPage();
                } else {
                  /// 아니면 제일 상단에 노출시키기 위해 첫번째 배열에 추가
                  pagingController.pages?.firstOrNull?.insert(
                    0,
                    FeedModel.fromJson(data),
                  );

                  update([':feedList']);
                }
              }
            } else if (documentChange.type == DocumentChangeType.modified) {
              Map<String, dynamic>? data = documentChange.doc.data();

              if (data != null) {
                pagingController.pages?.forEach((page) {
                  for (var feedModel in page.indexed) {
                    if (feedModel.$2.id == documentChange.doc.id) {
                      page[feedModel.$1]= FeedModel.fromJson(data);
                    }
                  }
                });

                update([':feedList']);
                /// 불변 객체이기 때문에 아래 방법을 사용할 수 없음
                //update([':feed:${documentChange.doc.id}']);
              }
            }
          }
        });
  }

  @override
  void onReady() {
    /// 가입시 추가정보 이동 화면으로 이동
    if (GetStorage().read("isSignupFinished") ?? false) {
      Get.toNamed(Routes.profile);
      GetStorage().remove("isSignupFinished");
    }
    super.onReady();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _subscription.cancel();

    super.onClose();
  }

  /// 피드(페이징) 로드
  Future<List<FeedModel>> _fetchPage(int pageKey) async {
    Query query = FirebaseFirestore.instance
        .collection('feeds')
        .doc(userCtrl.currentUser.uid)
        .collection('feedList')
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

    if (lastDocumentSnapshot != null) {
      query = query.startAfterDocument(lastDocumentSnapshot!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      lastDocumentSnapshot = snapshot.docs.last;
    }

    final items =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return FeedModel.fromJson(data as Map<String, dynamic>);
        }).toList();
    return items;
  }

  /// 새로고침 콜백 함수
  Future<void> onRefresh() async {
    lastDocumentSnapshot = null;
    pagingController.refresh();
  }

  /// 피드 작성
  Future<void> onTapWriteFeed() async {
    final now = DateTime.now();

    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final query = FirebaseFirestore.instance
        .collection('feeds')
        .doc(userCtrl.currentUser.uid)
        .collection('feedList')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('createdAt', isLessThan: Timestamp.fromDate(end));

    final snapshot = await query.get();
    final exists = snapshot.docs.isNotEmpty;

    if(exists) {
      Get.snackbar('오늘의 일기', '하루에 일기는 한 번 작성 가능합니다.', snackPosition: SnackPosition.TOP);
      return;
    }

    Get.toNamed(Routes.feedWrite);
  }

  /// 피드 클릭 함수
  void onTapFeedCard(FeedModel feed) {
    /// 피드 상세보기로 이동
    Get.toNamed(Routes.feedDetail, arguments: feed);
  }
}
