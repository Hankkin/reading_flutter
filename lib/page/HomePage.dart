import 'package:flutter/material.dart';
import 'package:reading_flutter/http/Api.dart';
import 'package:reading_flutter/http/HttpUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:reading_flutter/model/BannerBean.dart';
import 'package:reading_flutter/page/common/WebPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<BannerBean> bannerData = [];

  @override
  void initState() {
    super.initState();
    requestBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Swiper(
              itemBuilder: createBannerItem,
              itemCount: bannerData.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Theme.of(context).primaryColor,
              )),
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index) => {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return new WebPage(
                        title: bannerData[index].title,
                        url: bannerData[index].url,
                      );
                    }))
                  },
            )));
  }

  Widget createBannerItem(BuildContext context, int index) {
    return (Image.network(
      bannerData[index].imagePath,
      fit: BoxFit.fill,
    ));
  }

  void requestBanner() async {
    var result = await HttpUtils.getInstance().sendRequest(
      Api.BANNER,
      method: HttpUtils.GET,
    );
    if (result != null) {
      List data = result['data'];
      data.forEach((json) => {bannerData.add(BannerBean.fromJson(json))});
    }
  }

  Widget createAppBar() {
    return new AppBar(
        backgroundColor: Color(0xfffddbd0),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () => {Scaffold.of(context).openDrawer()},
          tooltip: 'Navigtation',
        ),
        title: new Text(
          'Reading',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {},
          )
        ]);
  }
}
