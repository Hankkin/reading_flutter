class WeChatModel {
  String errorMsg;
  int errorCode;
  List<DataListBean> data;

  static WeChatModel fromMap(Map<String, dynamic> map) {
    WeChatModel weChatModel = new WeChatModel();
    weChatModel.errorMsg = map['errorMsg'];
    weChatModel.errorCode = map['errorCode'];
    weChatModel.data = DataListBean.fromMapList(map['data']);
    return weChatModel;
  }

  static List<WeChatModel> fromMapList(dynamic mapList) {
    List<WeChatModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataListBean {
  String name;
  bool userControlSetTop;
  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;

  static DataListBean fromMap(Map<String, dynamic> map) {
    DataListBean dataListBean = new DataListBean();
    dataListBean.name = map['name'];
    dataListBean.userControlSetTop = map['userControlSetTop'];
    dataListBean.courseId = map['courseId'];
    dataListBean.id = map['id'];
    dataListBean.order = map['order'];
    dataListBean.parentChapterId = map['parentChapterId'];
    dataListBean.visible = map['visible'];
    return dataListBean;
  }

  static List<DataListBean> fromMapList(dynamic mapList) {
    List<DataListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
