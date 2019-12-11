

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/core/drag_scale_widget.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/utlis/image_util.dart';

class ImageShow extends StatefulWidget {
  @override
  ImageShowState createState() => new ImageShowState();
}

class ImageShowState extends State<ImageShow> {

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('图片展示'),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: DragScaleContainer(
                  doubleTapStillScale: true,
                  child: CachedNetworkImage(imageUrl: ImageUtil.getImageUrl(url)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

}