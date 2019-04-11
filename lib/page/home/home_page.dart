import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:reading_flutter/http/api_service.dart';
import 'package:reading_flutter/model/article_model.dart';
import 'package:reading_flutter/page/common/web_page.dart';
import 'package:reading_flutter/page/home/banner.dart';
import 'package:reading_flutter/res/styles.dart';
import 'package:reading_flutter/utils/ToastUtils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Article> _datas = new List();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _createAppBar(),
        body: RefreshIndicator(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                  itemBuilder: _createListView,
                  separatorBuilder: (BuildContext context, index) {
                    return Container(
                      height: 5,
                      color: Colors.transparent,
                    );
                  },
                  itemCount: _datas.length + 2),
            ),
            onRefresh: _getData));
  }

  Widget _createListView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.grey,
        child: new BannerWidget(),
      );
    }
    if (index < _datas.length - 1) {
      return InkWell(
        onTap: () {},
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(
                      _datas[index - 1].author,
                      style: TextStyles.listSub,
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Text(
                        _datas[index - 1].niceDate,
                        style: TextStyles.listSub,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Future<Null> _getData() async {
    _page = 0;
    ApiService().getArticleList((ArticleModel _articleModel) {
      if (_articleModel.errorCode == 0) {
        if (_articleModel.data.datas.length > 0) {
          _datas.clear();
          _datas.addAll(_articleModel.data.datas);
        } else {}
      } else {
        ToastUtils.toast(_articleModel.errorMsg);
      }
    }, (DioError error) {
      print(error.response);
    }, _page);
  }

  Widget _createAppBar() {
    return new AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => {Scaffold.of(context).openDrawer()},
          tooltip: 'Navigtation',
        ),
        title: new Text(
          'Reading',
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ]);
  }
}
