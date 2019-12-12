import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/model/spore_list_data.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/view_modle/spore_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*孢子捕捉仪*/
class Spore extends StatefulWidget {
  @override
  SporeState createState() => new SporeState();
}

class SporeState extends State<Spore> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget() {
    return new Column(
      children: [
        CustomAppbarTheme('孢子设备列表'),
        Expanded(
          flex: 1,
          child: ProviderWidget<SporeListViewModel>(
            model: SporeListViewModel(),
            onModelReady: (model) {
              model.initData();
              model.getSporeDevice();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }

              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: DropdownButton(
                        items: _getDropDownItem(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(LocalColors.text_333333)),
                        value: '浦江县农业局',
                        underline: Container(),
                        onChanged: (str) {},
                      ),
                  ),

                  Expanded(
                    flex: 1,
                    child: SmartRefresher(
                      controller: model.refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: MyRefreshHeader(),
                      footer: MyRefreshFooter(),
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      child: ListView.builder(
                          itemCount: model.list.length,
                          itemBuilder: (context, index) {
                            return _buildItem(model.list[index]);
                          }),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _getDropDownItem() {
    List<String> data = new List();
    data.add('浦江县农业局');
    return data
        .map<DropdownMenuItem<String>>(
            (item) => DropdownMenuItem(value: item,child: Text(item,style: TextStyle(fontSize: 14),)))
        .toList();
  }

  _buildItem(SporeListData data) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 13),
            child: new Row(
              children: [
                Text(
                  '设备名称:',
                  style: TextStyle(
                      fontSize: 13, color: Color(LocalColors.text_555555)),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 14),
                    child: Text(
                      '${data.name}',
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_222222)),
                    ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 11, right: 11),
            child: new Row(
              children: [
                Text(
                  '安装地址:',
                  style: TextStyle(
                      fontSize: 13, color: Color(LocalColors.text_555555)),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 14),
                    child: Text(
                      '${data.address}',
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_222222)),
                    ))
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 11, right: 11, top: 13, bottom: 29),
            child: new Row(
              children: [
                Text(
                  '在线状态:',
                  style: TextStyle(
                      fontSize: 13, color: Color(LocalColors.text_555555)),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 14),
                    child: Text(
                      '在线',
                      style: TextStyle(
                          fontSize: 13, color: Theme.of(context).accentColor),
                    ))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.spore_detail,arguments: data);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Center(
                  child: Text(
                '查看孢子图片',
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
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
