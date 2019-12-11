import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/wea_sta_list_data.dart';
import 'package:beyond_user/network/api.dart';


class WeaStationListModel extends ViewStateRefreshListModel<WeaStaListData>{


  @override
  Future<List<WeaStaListData>> loadData({int pageNum}) async{
    return await Api.getWeaStaDeviceList(pageNum, 10);
  }

}