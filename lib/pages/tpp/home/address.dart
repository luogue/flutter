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
  _searchResource(context, String text) {
    // 手动筛选
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '选择城市',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16.0
          )
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F5F5),
        // 自定义图标
        leading: Builder(builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                '关闭',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16.0
                )
              ),
              onTap: () => Navigator.pop(context),
            ),
          );
        })
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: Stack(
          children: <Widget>[
            // 搜索框
            Positioned(
              child: Container(
                height: 32.0,
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: _searchText,
                      selection: TextSelection.fromPosition(
                        TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: _searchText.length
                        )
                      )
                    )
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: '搜索城市名称',
                    isDense: true,
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFAAAAAA)
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF999999),
                      size: 20.0
                    ),
                    suffixIcon: _searchText == '' ? null : GestureDetector(
                      child: Icon(
                        Icons.cancel,
                        color: Color(0xFF999999),
                        size: 20.0
                      ),
                      onTap: () {
                        setState(() {
                          _searchText = '';
                        });
                      }
                    ),
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                  ),
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.2,
                  ),
                  textInputAction: TextInputAction.search,
                  maxLengthEnforced: true,
                  cursorColor: Colors.red,
                  cursorRadius: Radius.circular(10),
                  onSubmitted: (text) {
                    _searchResource(context, text);
                  },
                  onChanged: (text) {
                    setState(() {
                      _searchText = text;
                    });
                    // 清空输入文本时显示搜索页
                    if (text == '') {
                      setState(() {
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
