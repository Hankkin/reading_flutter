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
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 243, 247),
        appBar: _createAppBar(),
        body: RefreshIndicator(
          displacement: 15,
          onRefresh: _getData,
          child: ListView.separated(
              controller: _scrollController,
              itemBuilder: _createListView,
              separatorBuilder: (BuildContext context, index) {
                return Container(
                  height: 5,
                  color: Colors.transparent,
                );
              },
              itemCount: _datas.length + 2),
        ));
  }

  //创建Item
  Widget _createListView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 150,
        child: new BannerWidget(),
      );
    }
    if (index < _datas.length - 1) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebPage(
                title: _datas[index - 1].title, url: _datas[index - 1].link);
          }));
        },
        child: Container(
          margin: EdgeInsets.only(top: 5),
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      _datas[index - 1].author,
                      style: TextStyles.listTitle,
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Text(
                        "${_datas[index - 1].chapterName} / ${_datas[index - 1].superChapterName}",
                        style: TextStyles.listSub,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _datas[index - 1].title,
                        style: TextStyles.listContent,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    _getTagText(index),
                    Expanded(
                      child: Text(
                        _datas[index - 1].niceDate,
                        textAlign: TextAlign.right,
                        style: TextStyles.listSub,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _getTagText(int index) {
    if (_datas[index - 1].tags.length > 0) {
      String tagStr = "";
      _datas[index - 1].tags.forEach((tag) {
        tagStr = "$tagStr" + "${tag.name}";
      });
      return Text(
        tagStr,
        style: TextStyles.themeTxt,
      );
    } else {
      return Text("");
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

  Future<Null> _loadRequest() async {
    _page++;
    ApiService().getArticleList((ArticleModel _articleModel) {
      if (_articleModel.errorCode == 0) {
        if (_articleModel.data.datas.length > 0) {
          setState(() {
            _datas.addAll(_articleModel.data.datas);
          });
        }
      } else {}
    }, (DioError error) {}, _page);
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
