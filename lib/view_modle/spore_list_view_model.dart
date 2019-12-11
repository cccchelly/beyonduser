import 'package:beyond_user/model/spore_list_data.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_refresh_list_model.dart';


class SporeListViewModel extends ViewStateRefreshListModel<SporeListData>{

  @override
  Future<List<SporeListData>> loadData({int pageNum}) async{
    return await Api.getSporeList();
  }

  getSporeDevice() async {
    //设备目前是写死的   意思一下就是了
  }

}