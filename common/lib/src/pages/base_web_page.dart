import 'dart:convert';
import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * BaseWebPage
 *
 * @author: Ruoyegz
 * @date: 2021/7/29
 */
class BaseWebPage extends StatefulWidget {
  const BaseWebPage({Key? key}) : super(key: key);

  @override
  _BaseWebPageState createState() => _BaseWebPageState();
}

class _BaseWebPageState extends State<BaseWebPage> {
  late WebViewController _controller;

  String title = "";
  String url = "";

  int loadProgress = 0;
  bool hideProgressBar = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map) {
      title = args['title'];
      url = args['url'];
    }
  }

  void loadHtml() async {
    if (TextHelper.isNotEmpty(url)) {
      if (url.startsWith('http')) {
        _controller.loadUrl(url);
      } else {
        String assetsPath = await rootBundle.loadString(url);
        _controller.loadUrl(Uri.dataFromString(assetsPath,
                mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
            .toString());
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: Toolbar(
        title: title,
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              loadHtml();
            },
            onPageStarted: (url) {
              LogDog.w("BaseWebPage, onPageStarted: ${url}");
              setState(() {
                hideProgressBar = false;
              });
            },
            onProgress: (int progress) {
              LogDog.w("BaseWebPage, onProgress: ${progress}");
              setState(() {
                loadProgress = progress;
              });
            },
            onPageFinished: (url) {
              LogDog.w("BaseWebPage, onPageFinished: ${url}");

              setState(() {
                hideProgressBar = true;
              });
            },
            onWebResourceError: (error) {
              LogDog.w("BaseWebPage, onWebResourceError", error);
              setState(() {
                hideProgressBar = true;
              });
            },
          ),
          Offstage(
            offstage: hideProgressBar,
            child: LinearProgressIndicator(
              minHeight: 1.38,
              color: AppColor.white,
              valueColor: AlwaysStoppedAnimation(AppColor.colorF7551D),
              value: loadProgress.toDouble(),
            ),
          )
        ],
      ),
    );
  }
}
