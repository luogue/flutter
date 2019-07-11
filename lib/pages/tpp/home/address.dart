import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => new _AddressState();
}

class _AddressState extends State<Address> {
  String _searchText = '';
  Map _address;
  Map _searchResult;
  SharedPreferences _localStorage;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _getCityList(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    // _localStorage.setStringList('searchList', _searchList);
  }

  // 初始化持久化存储
  Future<void> _initStorage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _localStorage = _prefs;
      // _searchList = _prefs.getStringList('searchList') ?? [];
    });
  }

  // 获取城市列表
  _getCityList(context) {
    Future res = get(context, api.getCityList);
    res.then((data) {
      Message.success(context, '获取城市列表');
      setState(() {
        _address = data;
      });
    }).catchError((e) {
      Message.error(context, '网络请求超时，等会儿再试~');
    });
  }

  // 搜索
  _searchResource(context, String searchText) {
    Future res = post(context, api.searchResource, {'searchText': searchText});
    res.then((data) {
      Message.success(context, '搜索资源成功');
      // 显示搜索结果页
      setState(() {
        _searchResult = data;
      });
    }).catchError((e) {
      Message.error(context, '网络请求超时，因为easy-mock接口挂了，等会儿再试~');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
