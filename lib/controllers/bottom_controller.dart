import 'package:get/get.dart';
import 'package:travelmatex/views/home/home_screen.dart';

class BottomBarController extends GetxController {
  RxInt index = 0.obs;
  void indexChanger(int index) {
    this.index.value = index;
  }

  RxList pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ].obs;
}
