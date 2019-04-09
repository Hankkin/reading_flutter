import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_flutter/utils/ViewHelper.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: new MainBuilder(context).mainDrawer(context));
  }
}


class MainBuilder {
  BuildContext _context;

  MainBuilder(this._context);

  Widget mainDrawer(BuildContext context) {
    return new ListView(padding: const EdgeInsets.only(), children: <Widget>[
      _drawerHeader(context),
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

  Widget _drawerHeader(BuildContext context) {
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          image: new AssetImage("assets/images/bg_drawer_header.jpeg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Color(0xfffddbd0).withOpacity(0.5), 
            BlendMode.hardLight)
        )
      ),
      onDetailsPressed: () {},
    );
  }

  //退出app
  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}