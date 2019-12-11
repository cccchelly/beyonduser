import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:synchronized/synchronized.dart';
import 'package:beyond_user/config/storage_manager.dart';

class ShareUtil {
  static ShareUtil _shareUtil;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static final String _USERNAME = "user_name";



  ShareUtil._build();


  static ShareUtil instance() {
    if (_shareUtil == null) {
       _lock.synchronized(()  {
        if (_shareUtil == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = ShareUtil._build();
          singleton._init();
          _shareUtil = singleton;
        }
      });
    }
    return _shareUtil;
  }

   _init() {
    _prefs =  StorageManager.sharedPreferences;
  }

   saveUserName(String userName)  {
     _prefs.setString(_USERNAME, userName);
  }

   String getUserName()  {
    return  _prefs.get(_USERNAME);
  }

}
