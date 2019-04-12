import 'package:flutter/material.dart';

class GankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GankStatePage();
  }
}

class GankStatePage extends State<GankPage> {
  List<String> _titles = ['今日推荐', 'ANDROID'];
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    _tabController =
        new TabController(length: _titles.length, vsync: ScrollableState());
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 20,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: 48,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: _titles.map((s) {
                return Tab(text: s);
              }).toList(),
              indicatorColor: Colors.white,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ],
      ),
    );
  }
}
