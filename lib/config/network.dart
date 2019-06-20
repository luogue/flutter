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
  // print('get==========================');
  // print(res.data['data']);
  if (res.statusCode == 200 && res.data['code'] == 0) {
    Toast.toast(
      context,
      msg: '数据请求成功',
      bgColor: Colors.deepOrange,
      textColor: Colors.white
    );
    return res.data['data'];
  } else {
    Toast.toast(
      null,
      msg: res.statusMessage
    );
  }
}

post(url, data) async {
  Response res = await dio.post(url, data: data);
  // print('post==========================');
  // print(res);
  return res.data;
}
