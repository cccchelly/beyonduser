import 'package:beyond_user/model/worm_indentify_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class WormIndentifyResult extends StatefulWidget {
  @override
  WormIndentifyResultState createState() => new WormIndentifyResultState();
}

class WormIndentifyResultState extends State<WormIndentifyResult> {
  Asset asset;
  List<WormIndentifyData> data;

  @override
  Widget build(BuildContext context) {
    List list = ModalRoute.of(context).settings.arguments;
    asset = list[0];
    data = list[1];

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('识别结果'),
          Expanded(
            flex: 1,
            child: new Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 25, right: 25, top: 21, bottom: 45),
                  child: AssetThumb(
                    asset: asset,
                    width: 325,
                    height: 180,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Text('${data[index].name}');
                    })
              ],
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
