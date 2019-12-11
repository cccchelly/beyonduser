import 'package:beyond_user/config/app_constans.dart';

class MyLogUtil {
  static final int _line = 800;

  static log(String msg, [String tag]) {
    String t = tag == null ? "" : tag;
    if (AppConstans.isDebug) {
      while (msg.length > _line) {
        print(t + msg.substring(0, _line));
        msg = msg.substring(_line);
      }
      print(t + msg);
    }
  }
}
