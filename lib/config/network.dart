// 通信配置
import 'package:dio/dio.dart';

Dio dio = new Dio();

get(url) async {
  Response res = await dio.get(url);
  print('get==========================');
  print(res);
  // print(res.data['success']);
}

post(url, data) async {
  Response res = await dio.post(url, data: data);
  print('post==========================');
  print(res);
  // print(res.data['success']);
}
