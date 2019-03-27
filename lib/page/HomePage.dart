import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:reading_flutter/http/Api.dart';
import 'package:reading_flutter/http/HttpUtils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {

List bannerData = [];

  @override
  void initState() {
    super.initState();
    requestBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
    );
  }

  void requestBanner() async {
    var result = await HttpUtils.getInstance().sendRequest(
      Api.BANNER,
      method: HttpUtils.GET,
    );
  }

  Widget createAppBar() {
    return new AppBar(
      backgroundColor: Color(0xfffddbd0),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () => {Scaffold.of(context).openDrawer()},
          tooltip: 'Navigtation',
        ),
        title: new Text(
          'Reading',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {},
          )
        ]);
  }
}
