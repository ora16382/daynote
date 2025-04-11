import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daynote/modules/auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/user/user_model.dart';
import '../../routes/app_pages.dart';

class UserController extends GetxController {
  late UserModel currentUser;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // loadUser();
  }

  /// Firestore에서 유저 정보 불러오기
  Future<void> loadUser({bool isOnlyLoad = false}) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      Fluttertoast.showToast(msg: '사용자 정보가 존재하지 않습니다.');
      Get.find<AuthController>().signOut();
      return;
    }

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      currentUser = UserModel.fromJson(snapshot.data()!);

      if(!isOnlyLoad){
        Get.offAllNamed(Routes.home);
      }
    } else {
      /// firebase auth 만 된 상태에서 가입이 완료되지 않은 경우에는
      /// 다음 접속 시점에 로그아웃 처리한다.
      if(!isOnlyLoad){
        Get.find<AuthController>().signOut();
      }
    }
  }
}
