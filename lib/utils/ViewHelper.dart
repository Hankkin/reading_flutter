import 'package:flutter/material.dart';
import 'package:reading_flutter/page/common/WebPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewHelper {
  static void showAbout(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createTitle('关于Reading'),
                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: createTitle('版本号'),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: createDesc('1.0.0'),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: createTitle('Reading用途'),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: createDesc(
                      '🍑Reading是一款基于WanAndroid OpenApi开发的阅读类工具，如果你是一个热衷于Android开发者，那么这款软件能帮助你阅读精品Android文章。     同时Reading中还包含"英文单词"、"账号本子"、"天气"、"查单词"、"快递查询"等小工具。项目基于"Kotlin+MVP"架构开发，风格大概也许属于Material Desgin原质化风格，包含主题颜色切换、百变Logo、等功能。'),
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: createTitle('License')),
                new Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: createDesc('CopyRight 2019 Hankkin'),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: createTitle('关注我'),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Image.asset('assets/images/about_github.png'),
                        onPressed: () {
                          jumpWeb(
                              'Github',
                              'https://juejin.im/user/55dea68160b291d79422c1bb',
                              context);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Image.asset('assets/images/about_juejin.png'),
                        onPressed: () {
                          jumpWeb(
                              '掘金',
                              'https://juejin.im/user/55dea68160b291d79422c1bb',
                              context);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Image.asset('assets/images/about_jianshu.png'),
                        onPressed: () {
                          jumpWeb(
                              '简书',
                              'https://www.jianshu.com/u/1ff65e347973',
                              context);
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Image.asset('assets/images/about_csdn.png'),
                        onPressed: () {
                          jumpWeb(
                              'CSDN', 'https://blog.csdn.net/lyhhj', context);
                        },
                      ),
                    ),
                  ],
                ),
                new Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: '敬请期待',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            fontSize: 16.0);
                      },
                      child: new Container(
                        margin: const EdgeInsets.only(top: 10, left: 40),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '评分',
                          style:
                              new TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: new Text(
                          '关闭',
                          style:
                              new TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

Widget createTitle(String text) {
  return Text(
    text,
    style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );
}

Text createDesc(String desc) {
  return new Text(desc);
}

void jumpWeb(String title, String url, BuildContext context) async {
  await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
    return new WebPage(
      title: title,
      url: url,
    );
  }));
}
