import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/model/main_product_data.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/view_modle/main_product_model.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/app_constans.dart';

class MainProduct extends StatefulWidget {
  @override
  MainProductState createState() => new MainProductState();
}

class MainProductState extends State<MainProduct> with AutomaticKeepAliveClientMixin {
  int _leftCheckPosition = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '比昂科技',
          style: TextStyle(fontSize: 16,color: Color(LocalColors.text_212121)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Text(''),
      ),
      body: ProviderWidget<MainProductModel>(
        model: MainProductModel(),
        onModelReady: (model){
          model.getCategory();
        },
        builder: (context,model,child){
          if(model.busy){
            return ViewStateBusyWidget();
          }else{
            return _buildProduct(model);
          }
        },

      ),
    );
  }

  Widget _buildProduct(MainProductModel model) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeftList(model),
        //单项列表
        _buildRightListSingle(model),
      ],
    );
  }

  Widget _buildLeftList(MainProductModel model) {
    return Container(
      width: 100,
      color: Color(LocalColors.bg_eeeeee),
      child: ListView.builder(
          itemCount: model.prodectList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _checkType(index);
              },
              child: Container(
                  color: index != _leftCheckPosition
                      ? Color(LocalColors.bg_eeeeee)
                      : Colors.white,
                  padding: const EdgeInsets.only(top: 19, bottom: 19),
                  child: Text(
                    "${model.prodectList[index].typeName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,color: Color(LocalColors.text_212121)),
                  )),
            );
          }),
    );
  }

  Widget _buildRightListSingle(MainProductModel model) {
    List<CommoditiesListBean> _commodities = model.prodectList[_leftCheckPosition].commodities;

    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: _commodities.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.61),
              itemBuilder: (context, position) {
                double leftMargin, rightMargin;
                switch (position % 3) {
                  case 0:
                    leftMargin = 9;
                    rightMargin = 4;
                    break;
                  case 1:
                    leftMargin = 4;
                    rightMargin = 4;
                    break;
                  case 2:
                    leftMargin = 4;
                    rightMargin = 14;
                    break;
                }
                return Container(
                  height: 200,
                  margin: EdgeInsets.only(
                      left: leftMargin, right: rightMargin, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(LocalColors.bg_line), width: 0.5)),
                  child: new Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                              imageUrl: AppConstans.PIC_BASE_URL +
                                  _commodities[position].attachements[0].uri)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _commodities[position].name,
                          style: TextStyle(fontSize: 11,color: Color(LocalColors.text_222222)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }

  _checkType(int index) {
    if (index != _leftCheckPosition) {
      if(mounted) {
        setState(() {
          _leftCheckPosition = index;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}