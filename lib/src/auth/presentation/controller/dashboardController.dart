import 'package:get/get.dart';

class DashboardViewController extends GetxController {
  var selectedIndex = 0.obs;

  changeNav(int nav) {
    selectedIndex.value = nav;
    print(selectedIndex.value);
  }
}
