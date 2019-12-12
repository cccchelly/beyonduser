import 'package:permission_handler/permission_handler.dart';

class PermissionUtil{

 static requestCameraPermission() async{
    return await _request(PermissionGroup.camera);
  }

  static requestLocation()async{
   return await _request(PermissionGroup.location);
  }
  
  static _request(PermissionGroup p) async{
    bool isCameraGot = await _isPermissionGot(p);
    if(isCameraGot){
      return true;
    }else {
      Map<PermissionGroup,
          PermissionStatus> permissions = await PermissionHandler()
          .requestPermissions([p]);
      return false;
    }
  }
  

  static _isPermissionGot(PermissionGroup p)async{
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(p);
    return permission == PermissionStatus.granted;
  }


}