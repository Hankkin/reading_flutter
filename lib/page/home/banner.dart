import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:reading_flutter/http/api_service.dart';
import 'package:reading_flutter/model/banner_model.dart';
import 'package:reading_flutter/page/common/web_page.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BannerWidgetState();
  }
}

class BannerWidgetState extends State<BannerWidget> {
  List<BannerData> _bannerList = new List();

  @override
  void initState() {
    super.initState();
    _getBanner();
  }

  Future<Null> _getBanner() async {
    ApiService().getBanner((BannerModel _bannerModel) {
      if (_bannerModel.data.length > 0) {
        setState(() {
          _bannerList.clear();
          _bannerList.addAll(_bannerModel.data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        if (_bannerList[index] == null ||
            _bannerList[index].imagePath == null) {
          return new Container(
            color: Colors.grey[100],
          );
        } else {
          return createBannerItem(context, index);
        }
      },
      itemCount: _bannerList.length,
      autoplay: true,
      pagination: new SwiperPagination(),
    );
  }

  Widget createBannerItem(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebPage(
            title: _bannerList[index].title,
            url: _bannerList[index].url,
          );
        }));
      },
      child: new Container(
        child: new Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
