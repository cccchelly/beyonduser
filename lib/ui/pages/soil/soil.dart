import 'package:flutter/material.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/view_modle/soil_model.dart';
import 'package:beyond_user/model/soil_data.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';


/*土壤墒情*/
class Soil extends StatefulWidget {
  @override
  SoilState createState() => new SoilState();
}

class SoilState extends State<Soil> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarTheme('土壤墒情'),
          Expanded(
            flex: 1,
            child: ProviderWidget<SoilModel>(
              model: SoilModel(),
              onModelReady: (model){
                model.initData();
              },
              builder: (ctx,model,child){
                if(model.busy){
                  return ViewStateBusyWidget();
                }

                return SmartRefresher(controller: model.refreshController,
                header: MyRefreshHeader(),
                  footer: MyRefreshFooter(),
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  child: ListView.builder(
                      itemCount: model.list.length,
                      itemBuilder: (context,index){
                    return _buildItem(model.list[index]);
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(SoilData data){
    return Container(
      margin: const EdgeInsets.only(left: 12,right: 12,top: 6,bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 11,right: 11,top: 15,bottom: 13),
            child: new Row(
              children: [
                Text('设备名称:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),),
                Container(margin: const EdgeInsets.only(left: 14),child: Text('${data.moistureName}',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_222222)),))
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 11,right: 11),
            child: new Row(
              children: [
                Text('安装地址:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),),
                Container(margin: const EdgeInsets.only(left: 14),child: Text('${data.address}',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_222222)),))
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 11,right: 11,top: 13,bottom: 29),
            child: new Row(
              children: [
                Text('在线状态:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),),
                Container(margin: const EdgeInsets.only(left: 14),child: Text('在线',style: TextStyle(fontSize: 13,color: Theme.of(context).accentColor),))
              ],
            ),
          ),
          
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(RouteName.soil_detail,arguments: data);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 13,bottom: 13),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
              ),
              child: Center(child: Text('查看土壤状态',style: TextStyle(fontSize: 15,color: Colors.white),)),
            ),
          )

        ],
      ),
    );
  }

}
