class GankModel {
  bool error;
  ResultsBean results;
  List<String> category;

  @override
  String toString() {
    return 'GankModel{error: $error, results: $results, category: $category}';
  }

  static GankModel fromMap(Map<String, dynamic> map) {
    GankModel gankModel = new GankModel();
    gankModel.error = map['error'];
    gankModel.results = ResultsBean.fromMap(map['results']);

    List<dynamic> dynamicList0 = map['category'];
    gankModel.category = new List();
    gankModel.category.addAll(dynamicList0.map((o) => o.toString()));

    return gankModel;
  }

  static List<GankModel> fromMapList(dynamic mapList) {
    List<GankModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ResultsBean {
  List<ListBean> Android;
  List<ListBean> App;
  List<ListBean> iOS;
  List<ListBean> video;
  List<ListBean> web;
  List<ListBean> other;

  static ResultsBean fromMap(Map<String, dynamic> map) {
    ResultsBean resultsBean = new ResultsBean();
    resultsBean.Android = ListBean.fromMapList(map['Android']);
    resultsBean.App = ListBean.fromMapList(map['App']);
    resultsBean.iOS = ListBean.fromMapList(map['iOS']);
    resultsBean.video = ListBean.fromMapList(map['休息视频']);
    resultsBean.web = ListBean.fromMapList(map['前端']);
    resultsBean.other = ListBean.fromMapList(map['拓展资源']);
    return resultsBean;
  }

  static List<ResultsBean> fromMapList(dynamic mapList) {
    List<ResultsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ListBean {
  String _id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;
  bool used;
  List<String> images;

  static ListBean fromMap(Map<String, dynamic> map) {
    ListBean androidListBean = new ListBean();
    androidListBean._id = map['_id'];
    androidListBean.createdAt = map['createdAt'];
    androidListBean.desc = map['desc'];
    androidListBean.publishedAt = map['publishedAt'];
    androidListBean.source = map['source'];
    androidListBean.type = map['type'];
    androidListBean.url = map['url'];
    androidListBean.who = map['who'];
    androidListBean.used = map['used'];
    List<dynamic> dynamicList0 = map['images'];
    androidListBean.images = new List();
    if (dynamicList0 != null) {
      androidListBean.images.addAll(dynamicList0.map((o) => o.toString()));
    }
    return androidListBean;
  }

  static List<ListBean> fromMapList(dynamic mapList) {
    List<ListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GankCateBean {
  bool error;
  List<ListBean> results;

  static GankCateBean fromMap(Map<String, dynamic> map) {
    GankCateBean gank = new GankCateBean();
    gank.error = map['error'];
    gank.results = ListBean.fromMapList(map['results']);
    return gank;
  }

  static List<GankCateBean> fromMapList(dynamic mapList) {
    List<GankCateBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
