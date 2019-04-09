import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_flutter/page/GankPage.dart';
import 'package:reading_flutter/page/HomePage.dart';
import 'package:reading_flutter/page/PersonPage.dart';
import 'package:reading_flutter/page/WeChatPage.dart';

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
      drawer: new Drawer(),
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

