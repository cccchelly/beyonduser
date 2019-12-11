import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/video_ball_pic_data.dart';
import 'package:beyond_user/network/api.dart';

class VideoBallPicModel extends ViewStateRefreshListModel<VideoBallPicData> {
  var imei = '';
  var startAt = '';
  var endAt = '';


  VideoBallPicModel(this.imei, this.startAt, this.endAt);

  @override
  Future<List<VideoBallPicData>> loadData({int pageNum}) async{

    return  await Api.getVDBallPic(imei, pageNum, 10, startAt, endAt);
  }

}