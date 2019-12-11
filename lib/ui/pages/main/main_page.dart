import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/pages/main/main_main.dart';
import 'package:beyond_user/ui/pages/main/main_product.dart';
import 'package:beyond_user/ui/pages/main/main_about.dart';
import 'package:beyond_user/ui/pages/main/main_mine.dart';
import 'package:beyond_user/config/local_colors.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  var _pageController;
  int _selectPage = 0;
  List<Widget> _pages = List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index){
          setState(() {
            _selectPage = index;
          });
        },
        //禁止滑动
        //physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _selectPage == 0
                  ? Image.asset('images/sy_xz.png')
                  : Image.asset('images/sy_hs.png'),
              title: Text('首页')),
          BottomNavigationBarItem(
              icon: _selectPage == 1
                  ? Image.asset('images/cp_xz.png')
                  : Image.asset('images/cp_hs.png'),
              title: Text('产品系列')),
          BottomNavigationBarItem(
              icon: _selectPage == 2
                  ? Image.asset('images/gyba_xz.png')
                  : Image.asset('images/ba_hs.png'),
              title: Text('关于比昂')),
          BottomNavigationBarItem(
              icon: _selectPage == 3
                  ? Image.asset('images/wd_xz.png')
                  : Image.asset('images/wd_hs.png'),
              title: Text('我的')),
        ],
        currentIndex: _selectPage,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).accentColor,

        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (index) {
          setState(() {
            _selectPage = index;
            _pageController.jumpToPage(_selectPage);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pages = [MainMain(),MainProduct(),MainAbout(),MainMine()];
    _pageController = PageController(initialPage: 0,keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
