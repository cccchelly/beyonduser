import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/view_modle/wea_station_list_model.dart';
import 'package:beyond_user/model/wea_sta_list_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/config/router_config.dart';

/*气象站列表*/
class WeaStaList extends StatefulWidget {
  @override
  WeaStaListState createState() => new WeaStaListState();
}

class WeaStaListState extends State<WeaStaList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarTheme('气象站'),
          Expanded(
            flex: 1,
            child: ProviderWidget<WeaStationListModel>(
              model: WeaStationListModel(),
              onModelReady: (model) {
                model.initData();
              },
              builder: (ctx, model, child) {
                return SmartRefresher(
                  controller: model.refreshController,
                  header: MyRefreshHeader(),
                  footer: MyRefreshFooter(),
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  enablePullDown: true,
                  child: ListView.builder(
                      itemCount: model.list.length,
                      itemBuilder: (ctx, index) {
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

  Widget _buildItem(WeaStaListData item) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          new Row(
            children: [
              Container(
                  width: 80,
                  child: Text(
                    '气象站名称:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(LocalColors.text_555555), fontSize: 13),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  '${item.name}',
                  style: TextStyle(
                      color: Color(LocalColors.text_222222), fontSize: 13),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '气象站编号:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${item.id}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '拥有者:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${item.owner}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '联系电话:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${item.telephone}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 13, bottom: 27),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '地址:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${item.address}',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toDataRecently(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5))),
                      child: Text(
                        '查看气象数据',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toDataList(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Color(LocalColors.bg_006F2D),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5))),
                      child: Text(
                        '查看历史数据',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _toDataRecently(WeaStaListData deviceData) {
    Navigator.of(context)
        .pushNamed(RouteName.wea_sta_data_recently, arguments: deviceData);
  }

  _toDataList(WeaStaListData deviceData) {
    Navigator.of(context)
        .pushNamed(RouteName.wea_sta_data_list, arguments: deviceData);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
