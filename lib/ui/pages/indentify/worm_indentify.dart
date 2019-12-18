import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/worm_indentify_data.dart';
import 'package:beyond_user/view_modle/worm_indentify_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:oktoast/oktoast.dart';

class WormIndentify extends StatefulWidget {
  @override
  WormIndentifyState createState() => new WormIndentifyState();
}

class WormIndentifyState extends State<WormIndentify> {
  Asset imageAsset;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: new Column(
          children: [
            CustomAppbarWhite('上传虫体图片'),
            ProviderWidget<WormIndentifyViewModel>(
              model: WormIndentifyViewModel(),
              onModelReady: (model){},
              builder: (context,model,child){
                if(model.busy){
                  return ViewStateBusyWidget();
                }
                return new Column(
                  children: [
                    _buildImageWidget(),
                    FlatButton(
                        onPressed: () {
                          if(imageAsset==null){
                            showToast('请选择虫体照片');
                            return;
                          }
                          _indentifySure(model);
                        },
                        color: Theme.of(context).accentColor,
                        padding: const EdgeInsets.symmetric(horizontal: 120,vertical: 12),
                        child: Text('确认上传',style: TextStyle(fontSize: 16,color: Colors.white),)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _indentifySure(WormIndentifyViewModel model)async{
  List<WormIndentifyData> resultList = await model.wormIndentify(imageAsset);
  if(resultList.length == 0){
    showToast('识别错误');
    return;
  }
    Navigator.of(context).pushNamed(RouteName.worm_indentify_result,arguments: [imageAsset,resultList]);

  }

  _buildImageWidget() {
    if (imageAsset == null) {
      return InkWell(
        onTap: () {
          _chooseImage();
        },
        child: Container(
          width: 325,
          height: 180,
          margin:
              const EdgeInsets.only(left: 25, right: 25, top: 21, bottom: 45),
          color: Color(LocalColors.bg_dddddd),
          child: Center(child: Image.asset('images/zptj.png')),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          _chooseImage();
        },
        child: Container(
          margin:
              const EdgeInsets.only(left: 25, right: 25, top: 21, bottom: 45),
          child: AssetThumb(
            asset: imageAsset,
            width: 325,
            height: 180,
          ),
        ),
      );
    }
  }

  //选择照片
  Future<void> _chooseImage() async {
    List<Asset> resultList;
    String error;

    try {
      resultList =
          await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList.length >= 1) {
      setState(() {
        imageAsset = resultList[0];
        //if (error == null) _error = 'No Error Dectected';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
