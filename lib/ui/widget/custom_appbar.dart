import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';

///常规的appbar  固定了一些属性 比如title字体颜色大小居中  返回箭头的样式及点击监听
class CustomAppbarTheme extends StatefulWidget {
  String title;
  Widget action;

  CustomAppbarTheme(this.title, {Widget actionWidget}){
    action = actionWidget !=null ? actionWidget : SizedBox();
  }

  @override
  CustomAppbarThemeState createState() => new CustomAppbarThemeState();
}

class CustomAppbarThemeState extends State<CustomAppbarTheme> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: new Text(
        '${widget.title}',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('images/b_fh.png')),
      actions: <Widget>[
        Center(
            child: Container(
                padding: const EdgeInsets.only(right: 20)
                ,child: widget.action))
      ],
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
}

///白色的appbar
class CustomAppbarWhite extends StatefulWidget {
  String title;
  Widget action;


  CustomAppbarWhite(this.title, {Widget actionWidget}){
    action = actionWidget !=null ? actionWidget : SizedBox();
  }

  @override
  CustomAppbarWhiteState createState() => new CustomAppbarWhiteState();
}

class CustomAppbarWhiteState extends State<CustomAppbarWhite> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: new Text(
        '${widget.title}',
        style: TextStyle(color: Color(LocalColors.text_222222), fontSize: 16),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('images/fhjt.png')),
      actions: <Widget>[
        Center(
            child: Container(
            padding: const EdgeInsets.only(right: 20)
            ,child: widget.action))
      ],
    );
  }
}

class ChooseBotton extends StatelessWidget {
  Function onActionTap;


  ChooseBotton(this.onActionTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onActionTap();
      },
      child: new Row(
        children: [
          Image.asset('images/suoyou_sx.png'),
          Text(
            '筛选',
            style: TextStyle(
                fontSize: 14,
                color: Color(LocalColors.text_444444)),
          ),
        ],
      ),
    );
  }
}
