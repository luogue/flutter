import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/index.html');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebviewScaffold(
            appBar: AppBar(
              title: Text('app和web通信', style: TextStyle(color: Colors.white)),
              centerTitle: true
            ),
            url: new Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
            withJavascript: true,
            appCacheEnabled: true,
            withLocalUrl: true,
            hidden: true,
            withLocalStorage: true,
            enableAppScheme: true,
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
