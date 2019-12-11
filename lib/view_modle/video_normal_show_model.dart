import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/video_normal_show_data.dart';

class VideoNormalShowModel extends ViewStateModel{
  String _source;
  List<VideoNormalShowData> videoData;

  VideoNormalShowModel(this._source);

   getVideo() async{
     setBusy(true);
    videoData =  await Api.getNormalVideo(_source);
    notifyListeners();
    setOk();
  }

}