import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:beyond_user/config/storage_manager.dart';
import 'package:beyond_user/utlis/log_util.dart';

class LoginModle extends  ViewStateModel{
   UserModel userModel;

   LoginModle(this.userModel);

   Future<bool> login(String userName,String passWord,String code) async{
    setBusy(true);
    try{
      var user = await Api.login(userName, passWord, code);
      MyLogUtil.log('modle:-----${user.toString()}');
      userModel.saveUser(user);
      setBusy(false);
      return true;
    }catch (e){
      setError(e is Error ? e.toString() : e.message);
      MyLogUtil.log('登录出错:${e.toString()}');
      setBusy(false);
      return false;
    }

  }

}