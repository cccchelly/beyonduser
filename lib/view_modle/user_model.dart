

import 'package:flutter/services.dart';
import 'package:beyond_user/config/storage_manager.dart';
import 'package:beyond_user/model/user.dart';
import 'package:beyond_user/model/user_data.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/utlis/log_util.dart';

class UserModel extends ViewStateModel {
  static const String kUser = 'kUser';

  UserData _user;

  UserData get user => _user;

  bool get hasUser => user != null;


  static const BasicMessageChannel<String> platform =
  BasicMessageChannel<String>("android_channel", StringCodec());


  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? UserData.fromJson(userMap) : null;
  }

  saveUser(User user) {
    _user = UserData(access_token: user.accessToken,refresh_token: user.refreshToken);
    notifyListeners();
    //LogUtil.log('user: ${_user.toString()}');
    StorageManager.localStorage.setItem(kUser, _user);
    MyLogUtil.log('获取到token：${user.accessToken}传递给原生');
    platform.send(user.accessToken);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }

}
