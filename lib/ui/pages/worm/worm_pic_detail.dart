import 'package:flutter/material.dart';
import 'package:beyond_user/model/worm_pic_data.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_drag_scale/flutter_drag_scale.dart';


class WormPicDetail extends StatefulWidget {
  @override
  WormPicDetailState createState() => new WormPicDetailState();
}

class WormPicDetailState extends State<WormPicDetail> {
  
  @override
  Widget build(BuildContext context) {
    WormPicData data = ModalRoute.of(context).settings.arguments;
    
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('虫情图像'),
          Container(
            width: double.infinity,
            height: 260,
            child: Center(
              child: DragScaleContainer(
                doubleTapStillScale: true,
                child: CachedNetworkImage(imageUrl: data.url),
              ),
            ),
          )
        ],
      ),
    );
  }

}