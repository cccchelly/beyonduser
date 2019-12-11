import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/worm_pic_data.dart';
import 'package:beyond_user/network/api.dart';

class WormPicsModel extends ViewStateRefreshListModel<WormPicData>{
  var imei;
  var startAt;
  var endAt;

  WormPicsModel(this.imei, this.startAt, this.endAt);

  @override
  Future<List<WormPicData>> loadData({int pageNum}) async {
    return  await Api.getWormPics(pageNum, 20 , '$imei', startAt, endAt);
  }

}