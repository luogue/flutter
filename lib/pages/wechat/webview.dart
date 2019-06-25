import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_html/flutter_html.dart';

class WebView extends StatefulWidget {
  WebView({Key key}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}


class _WebViewState extends State<WebView> {
  // Future<File> _getFile() async {
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/index.html');
    // 获取应用目录
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // print('dir=============================');
    // print(dir);
    // print(new File('$dir/index.html'));
    // File a = new File('$dir/index.html');
    // print(a.readAsStringSync());
    // return new File('$dir/index.html');
  }
  _getHTML() {
    _getFile().then((data) {
      print('data=============================');
      print(data);
      print(data.runtimeType);
      return data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getFile(),
      // future: _getHTML(),
      builder: (context, snapshot) {
        print('==================================');
        print(snapshot.data);
        if (snapshot.hasData) {
          return WebviewScaffold(
            appBar: AppBar(title: Text("Load HTM file in WebView")),
            withJavascript: true,
            appCacheEnabled: true,
            withLocalUrl: true,
            hidden: true,
            allowFileURLs: true,
            url: new Uri.dataFromString(snapshot.data, mimeType: 'text/html').toString(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
    // return new Scaffold(
    //   appBar: AppBar(
    //     title: Text('网页', style: TextStyle(color: Colors.white)),
    //     centerTitle: true
    //   ),
    //   // body: Html(
    //   //   // data: '<div>1</div>'
    //   //   data: _getHTML()
    //   // )
    //   body: WebviewScaffold(
    //   //   // url: "https://www.baidu.com",
    //   //   // url: _getHTML(),
        
    //     url: 'assets/index.html',
    //     withLocalUrl: true,
    //     withZoom: true,
    //     withLocalStorage: true,
    //     hidden: true,
    //     allowFileURLs: true,
    //     initialChild: Container(
    //       color: Colors.deepOrangeAccent,
    //       child: const Center(
    //         child: Text('Loading.....', style: TextStyle( color: Colors.white, fontSize: 20.0 )),
    //       ),
    //     ),
    //   ),
    // );
  }
}