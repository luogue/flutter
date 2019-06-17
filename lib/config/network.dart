// 通信配置
import 'package:dio/dio.dart';

Dio dio = new Dio(new BaseOptions(
  baseUrl: 'https://www.easy-mock.com/mock/5ce761defcd92434dcbd613c/tpp/api',
  connectTimeout: 5000,
  receiveTimeout: 10000
));

get(url) async {
  Response res = await dio.get(url);
  // print('get==========================');
  // print(res.data['data']);
  // 此处应该是一个居中的弹窗，鉴于flutter的奇特写法，暂且搁置
  // if (res.data['code'] == 0) {}
  if (res.statusCode == 200 && res.data['code'] == 0) return res.data['data'];
}

post(url, data) async {
  Response res = await dio.post(url, data: data);
  // print('post==========================');
  // print(res);
  return res.data;
}
