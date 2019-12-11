import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/worm_list_data.dart';
import 'package:beyond_user/network/api.dart';


class WormListModel extends ViewStateRefreshListModel<WormListData>{

  @override
  Future<List<WormListData>> loadData({int pageNum}) async{
    return await Api.getWormDeviceList(pageNum);
  }

}
