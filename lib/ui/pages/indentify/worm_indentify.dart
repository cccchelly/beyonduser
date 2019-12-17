
import 'package:beyond_user/config/local_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


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
            _buildImageWidget(),


          ],
        ),
      ),
    );
  }

  _buildImageWidget(){
    if(imageAsset == null){
      return Container(
        width: double.infinity,
        height: 180,
        color: Color(LocalColors.bg_dddddd),
        child: Center(child: Image.asset('images/zptj.png')),
      );
    }else{

    }
  }

  @override
  void initState() {
    super.initState();
  }


}