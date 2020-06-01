import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {

  final String url;
  final String title;

  const DetailPage({Key key, this.url, this.title}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _pageLoading = true;
  void _adjustLoading(bool isLoading) {
    setState(() {
      _pageLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl:
                widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (_) => debugPrint('WebViewCreated!'),
            onPageStarted: (_) => debugPrint('PageStarted!'),
            onPageFinished: (_) {
              debugPrint('PageFinished!');
              _adjustLoading(false);
            },
          ),
          _pageLoading
              ? Container(
                  // color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
