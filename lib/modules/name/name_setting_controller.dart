import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user/user_controller.dart';

class NameSettingController extends GetxController {
  final RxString name = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoginProgress = false;

  /// 이름을 추가하여 최종적으로 저장
  Future<void> registerUser() async {
    isLoginProgress = true;
    update([':loading']);

    final user = _auth.currentUser;

    if (user == null || name.value.trim().length < 2) {
      Fluttertoast.showToast(msg: '닉네임은 2자 이상으로 입력해주세요.');
      return;
    }

    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    await doc.set({
      'uid': user.uid,
      'displayName': name.value.trim(),
      'email': user.email,
      'selectedMood': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    /// 유저 상태 초기화
    await Get.find<UserController>().loadUser();
  }
}
