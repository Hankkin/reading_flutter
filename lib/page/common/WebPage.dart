import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];
    content
        .add(new Text(widget.title, style: new TextStyle(color: Colors.white)));
    if (!isLoad) {
      content.add(new CircularProgressIndicator());
    }
    content.add(new Container(
      width: 50,
    ));
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
          title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: content,
      )),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
