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
  List<Article> _data = new List();
  int _page = 0;
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadRequest();
      }

      //当前位置是否超过屏幕高度
      if (_scrollController.offset < 200 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
            physics: new AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemBuilder: _createListView,
            separatorBuilder: (BuildContext context, index) {
              return Container(
                height: 5,
                color: Colors.transparent,
              );
            },
            itemCount: _data.length + 2),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                _scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }

  //创建Item
  Widget _createListView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 150,
        child: new BannerWidget(),
      );
    }
    if (index < _data.length - 1) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebPage(
                title: _data[index - 1].title, url: _data[index - 1].link);
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
                      _data[index - 1].author,
                      style: TextStyles.listTitle,
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Text(
                        "${_data[index - 1].chapterName} / ${_data[index - 1].superChapterName}",
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
                        _data[index - 1].title,
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
                        _data[index - 1].niceDate,
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
    if (_data[index - 1].tags.length > 0) {
      String tagStr = "";
      _data[index - 1].tags.forEach((tag) {
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
          setState(() {
            _data.clear();
            _data.addAll(_articleModel.data.datas);
          });
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
            _data.addAll(_articleModel.data.datas);
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
