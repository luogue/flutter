import 'package:flutter/material.dart';
import 'package:yangyue/entry.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:yangyue/router/index.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // // 竖直方向
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.orange));
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarIconBrightness: Brightness.dark));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var a = DateTime.now().millisecondsSinceEpoch;
    print (a);
    return new MaterialApp(
      title: '这是一个 flutter 应用',
      theme: (
        new ThemeData(
          primaryColor: Colors.deepOrange,
        )
      ),
      //注册路由表
      routes: routes,
      home: new Entry(),
    );
  }
}