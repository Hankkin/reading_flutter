import 'package:flutter/material.dart';

mixin ListState<T extends StatefulWidget> on State<T>,AutomaticKeepAliveClientMixin<T> {

//  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
//
//
//  showRefresh(){
//    new Future.delayed(const Duration(seconds: 0), () {
//      refreshIndicatorKey.currentState.show().then((e) {});
//      return true;
//    });
//  }
//
//  @protected
//  Future pullToRefresh();
//
//  @protected
//  Future loadMore();
//
//
//  ///是否需要第一次进入自动刷新
//  @protected
//  bool get isRefreshFirst;
//
//  ///是否需要头部
//  @protected
//  bool get needHeader => false;
//
//  ///是否需要保持
//  @override
//  bool get wantKeepAlive => true;
//
//  @protected
//  BlocListBase get bloc;
//
//  @override
//  void initState() {
//    super.initState();
//    bloc.changeNeedHeaderStatus(needHeader);
//    if (bloc.getDataLength() == 0 && isRefreshFirst) {
//      showRefresh();
//    }
//  }


}