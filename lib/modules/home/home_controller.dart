import 'package:daynote/constant/enum/home_type.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeType = HomeType.feed.obs;

  void onTapBottomNavi(int value) {
    homeType.value = HomeType.values[value];
  }
}
