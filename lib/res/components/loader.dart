import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoader {
  static showLoader({String message = 'loading...'}) {
    EasyLoading.show(status: message);
  }

  static hideLoader() {
    EasyLoading.dismiss();
  }
}
