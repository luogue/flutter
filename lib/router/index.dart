import 'package:flutter/material.dart';

/* 淘票票 */

// 首页
import 'package:yangyue/pages/tpp/home/home.dart';
import 'package:yangyue/pages/tpp/home/address.dart';

// 电影页
import 'package:yangyue/pages/tpp/movie/movie.dart';
import 'package:yangyue/pages/tpp/movie/search.dart';

// 视频页
import 'package:yangyue/pages/tpp/video/video.dart';
import 'package:yangyue/pages/tpp/performance/performance.dart';
import 'package:yangyue/pages/tpp/mine/mine.dart';

/* 微信 */
import 'package:yangyue/pages/wechat/wechat.dart';
import 'package:yangyue/pages/wechat/webview.dart';

Map<String, WidgetBuilder> routes = {
  'home': (context) => Home(),
  'address': (context) => Address(),
  'movie': (context) => Movie(),
  'search': (context) => Search(),
  'video': (context) => Video(),
  'performance': (context) => Performance(),
  'mine': (context) => Mine(),
  'wechat': (context) => Wechat(),
  'webview': (context) => WebViewPage(),
};
