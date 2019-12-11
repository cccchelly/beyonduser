import 'package:beyond_user/model/fix_list_data.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_refresh_list_model.dart';

class FixListViewModel extends ViewStateRefreshListModel<FixListData>{
  String statue = '';

  @override
  Future<List<FixListData>> loadData({int pageNum}) async {
    return await Api.getFixList(pageNum, 10, statue);
  }

}