import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reading_flutter/http/api_service.dart';
import 'package:reading_flutter/model/article_model.dart';
import 'package:reading_flutter/model/wechat_model.dart';
import 'package:reading_flutter/page/common/web_page.dart';
import 'package:reading_flutter/res/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeChatState();
  }
}

class WeChatState extends State<WeChatPage> with AutomaticKeepAliveClientMixin{
  List<DataListBean> _chapters = new List();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getChapters();
  }

  @override
  Widget build(BuildContext context) {
    _tabController =
    new TabController(length: _chapters.length, vsync: ScrollableState());
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 20,
            color: Theme
                .of(context)
                .primaryColor,
          ),
          Container(
            height: 48,
            color: Theme
                .of(context)
                .primaryColor,
            child: TabBar(
              tabs: _chapters.map((s) {
                return Tab(text: s.name);
              }).toList(),
              indicatorColor: Colors.white,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _chapters.map((t) {
                return new ContentList(t.id);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _getChapters() async {
    ApiService().getWeChatChapters((WeChatModel _wechatModel) {
      if (_wechatModel.errorCode == 0 && _wechatModel.data != null) {
        setState(() {
          _chapters.addAll(_wechatModel.data);
        });
      }
    }, (DioError error) {});
  }

  @override
  bool get wantKeepAlive => true;
}

class ContentList extends StatefulWidget {
  final int _id;

  ContentList(this._id);

  @override
  State<StatefulWidget> createState() {
    return new ContentListState();
  }
}

class ContentListState extends State<ContentList>
    with AutomaticKeepAliveClientMixin,TickerProviderStateMixin {
  int _page = 0;
  List<DatasListBean> _data = new List();
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    _getChapterList();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 15,
        onRefresh: _getChapterList,
        child: _createContent(),
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

  Widget _createContent() {
    return _data.length == 0 ? new Center(
      child: SpinKitCircle(color: Theme.of(context).primaryColor),) : ListView.separated(
        padding: EdgeInsets.only(top: 0),
        controller: _scrollController,
        itemBuilder: _createListView,
        separatorBuilder: (BuildContext context, index) {
          return Container(
            height: 5,
            color: Colors.transparent,
          );
        },
        itemCount: _data.length + 1);
  }

  //创建Item
  Widget _createListView(BuildContext context, int index) {
    if (index < _data.length) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebPage(
                title: _data[index].title, url: _data[index].link);
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
                      _data[index].author,
                      style: TextStyles.listTitle,
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Text(
                        "${_data[index].chapterName} / ${_data[index]
                            .superChapterName}",
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
                        _data[index].title,
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
                        _data[index].niceDate,
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
    if (_data[index].tags.length > 0) {
      String tagStr = "";
      _data[index].tags.forEach((tag) {
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

  Future<Null> _getChapterList() async {
    _page = 0;
    int id = widget._id;
    ApiService().getWeChatChaptersList((ArticleModel _articleModel) {
      if (_articleModel.errorCode == 0) {
        if (_articleModel.data != null) {
          setState(() {
            _data.clear();
            _data.addAll(_articleModel.data.datas);
          });
        }
      }
    }, (DioError error) {}, id, _page);
  }

  Future<Null> _loadRequest() async {
    _page++;
    int id = widget._id;
    ApiService().getWeChatChaptersList((ArticleModel _articleModel) {
      setState(() {
        _data.addAll(_articleModel.data.datas);
      });
    }, (DioError error) {}, id, _page);
  }

  @override
  bool get wantKeepAlive => true;
}
