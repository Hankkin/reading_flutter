import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:reading_flutter/res/styles.dart';
import 'package:reading_flutter/utils/ToastUtils.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;

  WebPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WebPageState();
  }
}

class WebPageState extends State<WebPage> {
  final wbPlugin = new FlutterWebviewPlugin();
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    wbPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = true;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = false;
        });
      }
    });
  }

  void onPopSelected(String value) {
    switch (value) {
      case "browser":
        ToastUtils.toast('敬请期待');
        break;
      case "collection":
        break;

      case "share":
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          new PopupMenuButton(
            padding: const EdgeInsets.all(0),
            onSelected: onPopSelected,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>> [
              new PopupMenuItem<String>(
                        value: "browser",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Colors.black26,
                                    size: 22.0,
                                  ),
                                  Gaps.hGap10,
                                  Text(
                                    '浏览器打开',
                                    style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
            ],
          )
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
