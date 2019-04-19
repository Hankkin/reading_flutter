import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_flutter/components/drawer_widget.dart';
import 'package:reading_flutter/page/gank/gank_page.dart';
import 'package:reading_flutter/page/home/home_page.dart';
import 'package:reading_flutter/page/person_page.dart';
import 'package:reading_flutter/page/wechat_page.dart';
import 'package:reading_flutter/res/styles.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPageWidget(),
        theme: new ThemeData(
          primaryColor: Color(0xff057FFF),
        ));
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> with AutomaticKeepAliveClientMixin{
  int tabIndex = 0;
  static List tabImgs = [
    new Icon(Icons.home),
    new Icon(Icons.assignment),
    new Icon(Icons.receipt),
    new Icon(Icons.person)
  ];
  static List titles = ['首页', '干货', '公众号', '我的'];
  var pageList;
  var _pages = [
    new HomePage(),
    new GankPage(),
    new WeChatPage(),
    new PersonPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: DrawerWidget(),
        body: new IndexedStack(
          children: _pages,
          index: tabIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: tabImgs[0], title: Text(titles[0])),
            new BottomNavigationBarItem(
                icon: tabImgs[1], title: Text(titles[1])),
            new BottomNavigationBarItem(
                icon: tabImgs[2], title: Text(titles[2])),
            new BottomNavigationBarItem(
                icon: tabImgs[3], title: Text(titles[3])),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: tabIndex,
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text(
                  '提示',
                ),
                content: new Text(
                  '确定退出应用吗？',
                ),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text(
                      '再看一会',
                      style: TextStyles.themeTxt,
                    ),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text(
                      '退出',
                      style: TextStyles.themeTxt,
                    ),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  bool get wantKeepAlive => true;
}
