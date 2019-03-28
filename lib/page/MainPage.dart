import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_flutter/page/GankPage.dart';
import 'package:reading_flutter/page/HomePage.dart';
import 'package:reading_flutter/page/PersonPage.dart';
import 'package:reading_flutter/page/WeChatPage.dart';
import 'package:reading_flutter/utils/ViewHelper.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageWidget(),
      theme: new ThemeData(
        primaryColor: Color(0xfffddbd0),
      )
    );
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int tabIndex = 0;
  static List tabImgs = [
    new Icon(Icons.home),
    new Icon(Icons.assignment),
    new Icon(Icons.receipt),
    new Icon(Icons.person)
  ];
  static List titles = ['首页', '干货', '公众号', '我的'];
  var pageList;
  var bodys;

  Image getTab(int index) {
    if (index == tabIndex) {
      return tabImgs[index][1];
    }
    return tabImgs[index][0];
  }

  Text getTabTitle(int index) {
    if (index == tabIndex) {
      return new Text(titles[index]);
    } else {
      return new Text(titles[index],
          style: new TextStyle(color: Colors.black26));
    }
  }

  void initPages() {
    bodys = [
      new HomePage(),
      new GankPage(),
      new WeChatPage(),
      new PersonPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    initPages();
    return Scaffold(
      drawer: new Drawer(child: new MainBuilder(context).mainDrawer(),),
      body: bodys[tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(icon: tabImgs[0], title: getTabTitle(0)),
          new BottomNavigationBarItem(icon: tabImgs[1], title: getTabTitle(1)),
          new BottomNavigationBarItem(icon: tabImgs[2], title: getTabTitle(2)),
          new BottomNavigationBarItem(icon: tabImgs[3], title: getTabTitle(3)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }
}

class MainBuilder {
  BuildContext _context;

  MainBuilder(this._context);

  Widget mainDrawer() {
    return new ListView(padding: const EdgeInsets.only(), children: <Widget>[
      _drawerHeader(),
      new ClipRect(
        child: new ListTile(
          leading: IconButton(icon: Icon(Icons.star), onPressed: null),
          title: new Text('我的收藏'),
          onTap: () => {},
        ),
      ),
      new ListTile(
        leading: IconButton(icon: Icon(Icons.today), onPressed: null),
        title: new Text('TODO'),
        onTap: () => {},
      ),
      new ListTile(
        leading: IconButton(icon: Icon(Icons.settings), onPressed: null),
        title: new Text('设置'),
        onTap: () => {},
      ),
      new ListTile(
        leading: IconButton(icon: Icon(Icons.error), onPressed: null),
        title: new Text("关于Reading"),
        onTap: () => {
          ViewHelper.showAbout(_context)
        },
      ),
      new ListTile(
        leading: IconButton(icon: Icon(Icons.exit_to_app), onPressed: null),
        title: new Text('退出'),
        onTap: () async {
          await pop();
        },
      ),
    ]);
  }

  Widget _drawerHeader() {
    return new UserAccountsDrawerHeader(
//      margin: EdgeInsets.zero,
      accountName: new Text(
        "未登录",
      ),
      accountEmail: new Text(
        "淡泊名利，宁静致远",
      ),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage("assets/images/default_avatar.png"),
      ),
      onDetailsPressed: () {},
    );
  }

  //退出app
  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
