import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reading_flutter/http/api_service.dart';
import 'package:reading_flutter/model/gank_model.dart';
import 'package:reading_flutter/page/common/web_page.dart';
import 'package:reading_flutter/res/styles.dart';

class GankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GankStatePage();
  }
}

class GankStatePage extends State<GankPage> {
  List<String> _titles = List();
  TabController _tabController;

  Future<Null> getToady() async {
    ApiService().getGankToday((GankModel _gankModel) {
      if (!_gankModel.error) {
        if (_gankModel.category.length > 0) {
          setState(() {
            _titles.addAll(_gankModel.category);
          });
        }
      }
    }, (DioError error) {});
  }

  @override
  void initState() {
    super.initState();
    getToady();
  }

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
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _titles.map((t) {
                return new ContentList(t);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ContentList extends StatefulWidget {
  final String _cate;

  ContentList(this._cate);

  @override
  State<StatefulWidget> createState() {
    return new ContentListState();
  }
}

class ContentListState extends State<ContentList> with AutomaticKeepAliveClientMixin{
  int _page = 0;
  List<ListBean> _data = new List();
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    _getCateList();
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
        onRefresh: _getCateList,
        child: Container(
          child: ListView.separated(
              padding: EdgeInsets.only(top: 0),
              controller: _scrollController,
              itemBuilder: _createListView,
              separatorBuilder: (BuildContext context, index) {
                return Container(
                  height: 5,
                  color: Colors.transparent,
                );
              },
              itemCount: _data.length + 1),
        ),
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

  Widget _createListView(BuildContext context, int index) {
    if (index < _data.length) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebPage(title: _data[index].desc, url: _data[index].url);
          }));
        },
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  _data[index].who,
                                  style: TextStyles.listTitle,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _data[index].desc,
                                    style: TextStyles.listContent,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _getImg(index)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "${_data[index].source} / ${_data[index].type}",
                          style: TextStyles.themeTxt,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _data[index]
                              .publishedAt
                              .substring(0, 10)
                              .replaceFirst('-', '.'),
                          textAlign: TextAlign.right,
                          style: TextStyles.listSub,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
    }
    return null;
  }

  Widget _getImg(int _index) {
    if (_data[_index].images != null && _data[_index].images.length > 0) {
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: ClipRRect(
          child: Image.network(
            _data[_index].images[0],
            width: 80,
            height: 80,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      );
    } else {
      return Text('');
    }
  }

  Future<Null> _getCateList() async {
    _page = 1;
    String cate = widget._cate;
    ApiService().getCateList((GankCateBean _gankCateBean) {
      if (!_gankCateBean.error) {
        if (_gankCateBean.results.length > 0) {
          setState(() {
            _data.clear();
            _data.addAll(_gankCateBean.results);
          });
        }
      }
    }, (DioError error) {}, cate, _page);
  }

  Future<Null> _loadRequest() async {
    _page++;
    String cate = widget._cate;
    ApiService().getCateList((GankCateBean _gankCateBean) {
      setState(() {
        _data.addAll(_gankCateBean.results);
      });
    }, (DioError error) {}, cate, _page);
  }

  @override
  bool get wantKeepAlive => true;
}
