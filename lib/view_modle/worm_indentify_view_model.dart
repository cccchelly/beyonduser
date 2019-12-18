import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class WormIndentifyViewModel extends ViewStateModel{

  wormIndentify(Asset asset)async{
    setBusy(true);
    var byteData = await asset.getByteData(quality: 50);
    var bytes = byteData.buffer.asUint8List();
    var result = await Api.wormIndentify(bytes, asset.name);
    setOk();
    return result;
  }

}