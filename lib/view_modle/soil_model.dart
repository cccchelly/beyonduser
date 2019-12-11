import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/soil_data.dart';
import 'package:beyond_user/network/api.dart';

class SoilModel extends ViewStateRefreshListModel<SoilData>{

  @override
  Future<List<SoilData>> loadData({int pageNum}) async{
    return await Api.getSoilDevice();
  }

}