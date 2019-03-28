class BannerBean {
  String desc;
  String imagePath;
  int id;
  int isVisible;
  int order;
  String title;
  String url;

  BannerBean({this.title,this.imagePath,this.url});

  factory BannerBean.fromJson(Map<String, dynamic> json) {
    return new BannerBean(
      title: json['title'],
      imagePath: json['imagePath'],
      url: json['url']
    );
  }
}