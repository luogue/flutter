import 'package:flutter/material.dart';
import 'package:yangyue/pages/tpp/home/home.dart';
import 'package:yangyue/pages/tpp/movie/movie.dart';
import 'package:yangyue/pages/tpp/video/video.dart';
import 'package:yangyue/pages/tpp/performance/performance.dart';
import 'package:yangyue/pages/tpp/mine/mine.dart';

Map<String, WidgetBuilder> routes = {
  'home': (context) => Home(),
  'movie': (context) => Movie(),
  'video': (context) => Video(),
  'performance': (context) => Performance(),
  'mine': (context) => Mine()
};
