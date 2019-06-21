import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:yangyue/components/toast.dart';

Dio dio = new Dio(new BaseOptions(
  baseUrl: 'https://www.easy-mock.com/mock/5ce761defcd92434dcbd613c/tpp/api',
  connectTimeout: 5000,
  receiveTimeout: 10000
));

get(context, url) async {
  Response res = await dio.get(url);
  if (res.statusCode == 200 && res.data['code'] == 0) {
    Message.success(context, '数据请求成功');
    return res.data['data'];
  } else {
    Message.success(context, res.statusMessage);
  }
}

post(context, url, data) async {
  Response res = await dio.post(url, data: data);
  if (res.statusCode == 200 && res.data['code'] == 0) {
    Message.success(context, '数据请求成功');
    return res.data['data'];
  } else {
    Message.success(context, res.statusMessage);
  }
}
