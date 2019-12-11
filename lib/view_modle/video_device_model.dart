import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/video_device_ball_data.dart';
import 'package:beyond_user/model/video_device_normal_data.dart';
import 'package:beyond_user/network/api.dart';


//封装的分页是从1开始的  但是接的三方的监控分页都是从0开始的  所以page -1
class VDNormalModel extends ViewStateRefreshListModel<VideoDeviceNormalData>{

  @override
  Future<List<VideoDeviceNormalData>> loadData({int pageNum}) async{

    return await Api.getVDNormal('${pageNum-1}','10');
  }

}


class VDBallModel extends ViewStateRefreshListModel<VideoDeviceBallData>{

  @override
  Future<List<VideoDeviceBallData>> loadData({int pageNum}) async{

    return await Api.getVDBall('{pageNum-1}','10');
  }

}