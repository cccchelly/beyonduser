
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/view_modle/main_about_model.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/model/main_about_data.dart';


class MainAbout extends StatefulWidget {
  @override
  MainAboutState createState() => new MainAboutState();
}

class MainAboutState extends State<MainAbout>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '关于比昂',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        leading: Text(''),
      ),

      body: SingleChildScrollView(
        child: ProviderWidget<MainAboutModel>(
          model: MainAboutModel(),
          onModelReady: (model){
            model.getAboutData();
          },
          builder: (context,model,child){
            if(model.busy){
              return ViewStateBusyWidget();
            }else{
              return new Column(
                children: [
                  _buildGreen(model),
                  _buildWhite(),
                ],
              );
            }
          },

        ),
      ),
    );
  }

  Widget _buildWhite() {
    return new Column(children: [
      Center(
          child: Container(
              width: 82,
              height: 36,
              margin: const EdgeInsets.only(top: 24),
              child: Image.asset("images/gyba_hzal.png"))),
      Center(child: Image.asset("images/gyba_hzal_tpzs.png")),
    ]);
  }

  Widget _buildGreen(MainAboutModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 20),
          bottomRight: Radius.elliptical(300, 20)),
      child: Container(
        color: Theme.of(context).accentColor,
        padding: const EdgeInsets.only(bottom: 20),
        child: new Column(
          children: [
            Container(
                child: Image.asset(
                  "images/jj_baner.png",
                  fit: BoxFit.fill,
                )),
            Center(
                child: Container(
                    width: 82,
                    height: 36,
                    margin: const EdgeInsets.only(top: 30),
                    child: Image.asset(
                      "images/gyba_ryzz.png",
                      fit: BoxFit.fill,
                    ))),
            _buildHonor(model),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Center(
                child: Container(
                    width: 82,
                    height: 36,
                    margin: const EdgeInsets.only(top: 24),
                    child: Image.asset(
                      "images/gyba_gsjj.png",
                      fit: BoxFit.fill,
                    ))),
            Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 12, top: 23, bottom: 23),
                child: Text(
                  "${model.aboutData == null ? "" : model.aboutData.companyDesc}",
                  style: TextStyle(fontSize: 13,color: Color(LocalColors.text_e7fffa)),
                )),
            Container(
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                child: Image.asset("images/gyba_tpjs.png")),
          ],
        ),
      ),
    );
  }

  //荣誉资质list
  Widget _buildHonor(MainAboutModel model) {
    var honor = model.aboutData.honor.split(new RegExp(","));

    return Container(
      color: Theme.of(context).accentColor,
      height: 78,
      margin: EdgeInsets.only(top: 23, bottom: 23, left: 14, right: 14),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: honor.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 3, right: 3),
              child: CachedNetworkImage(
                width: 112,
                imageUrl: "${AppConstans.PIC_BASE_URL}${honor[index]}",
              ),
            );
          }),
    );
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