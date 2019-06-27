import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:webview_flutter/webview_flutter.dart';


class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/index.html');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return WebView(
          //   initialUrl: new Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
          //   debuggingEnabled: true,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   // javascriptChannels: JavascriptChannel,
          // );
          return WebviewScaffold(
            appBar: AppBar(
              title: Text('flutter和web页面通信', style: TextStyle(color: Colors.white)),
              centerTitle: true
            ),
            url: new Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
            withJavascript: true,
            // clearCache: true,
            // clearCookies: true,
            enableAppScheme: true,
            primary: true,
            withLocalStorage: true,
            withLocalUrl: true,
            scrollBar: true,
            supportMultipleWindows: true,
            appCacheEnabled: true,
            // hidden: true,
            allowFileURLs: true,
            resizeToAvoidBottomInset: true,
            geolocationEnabled: true,
            initialChild: Container(
              color: Colors.deepOrangeAccent,
              child: const Center(
                child: Text('Loading.....', style: TextStyle( color: Colors.white, fontSize: 20.0 )),
              ),
            ),
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
  }
}
