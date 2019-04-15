
import 'package:dio/dio.dart';
import 'package:reading_flutter/common/user.dart';
import 'package:reading_flutter/http/api.dart';
import 'package:reading_flutter/http/http_utils.dart';
import 'package:reading_flutter/model/article_model.dart';
import 'package:reading_flutter/model/banner_model.dart';
import 'package:reading_flutter/model/gank_model.dart';

class ApiService {
  void getBanner(Function callback) async {
    HttpUtils.instance.dio
        .get(Api.BANNER, options: _getOptions())
        .then((response) {
      callback(BannerModel(response.data));
    });
  }

  void getArticleList(Function callback, Function errorback, int _page) async {
    HttpUtils.instance.dio
        .get(Api.ARTICLE_LIST + "$_page/json", options: _getOptions())
        .then((response) {
      callback(ArticleModel(response.data));
    }).catchError((error) {
      errorback(error);
    });
  }

  void getGankToday(Function callback, Function errorback) async {
    HttpUtils.instance.dio
        .get(Api.TOADY_LIST, options: _getOptions())
        .then((response) {
      callback(GankModel.fromMap(response.data));
    }).catchError((error) {
      errorback(error);
      print(error);
    });
  }

  void getCateList(
      Function callback, Function errorback, String _cate, int _page) async {
    HttpUtils.instance.dio
        .get(Api.CATE_LIST + "$_cate/20/$_page", options: _getOptions())
        .then((response) {
      callback(GankCateBean.fromMap(response.data));
    }).catchError((error) {
      errorback(error);
    });
  }

  Options _getOptions() {
    Map<String, String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers: map);
  }
}
