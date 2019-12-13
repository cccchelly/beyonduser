import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/utlis/ShareUtil.dart';
import 'package:beyond_user/utlis/log_util.dart';


class LampListViewModel extends ViewStateRefreshListModel<LampListModel>{
  int machineStatus = 0;

  @override
  Future<List<LampListModel>> loadData({int pageNum}) async{
    //1或者不传  远程  2非远程  3远程初始位置
    return await Api.getLampList(
        ShareUtil.instance().getUserName(),
        '1', machineStatus == 0?null : machineStatus, pageNum, 10);
  }

  Future searchLamp(String code) async{
    
     return await Api.searchLamp(code);
  }


}