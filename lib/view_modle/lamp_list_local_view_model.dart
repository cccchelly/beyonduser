import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/utlis/ShareUtil.dart';
import 'package:beyond_user/utlis/log_util.dart';


class LampListLocalViewModel extends ViewStateRefreshListModel<LampListModel>{

  @override
  Future<List<LampListModel>> loadData({int pageNum}) async{
    //1或者不传  远程  2非远程
    return await Api.getLampList(
        ShareUtil.instance().getUserName(),
        '2', null, pageNum, 10);
  }

}