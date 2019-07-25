import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:ui';
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
  MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  String currentCity;
  String positionCity;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _getCityList(context);
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

  // 渲染首字母城市列表
  _renderCityList() {
    if(_address == null) return <Widget>[];
    List<Widget> list = [];
    _address['cityList'].forEach((firstLetter, cityList) {
      list.add(
        // 首字母
        Expanded(
          flex: 0,
        child: 
        Container(
          alignment: Alignment.bottomLeft,
          height: 32.0,
          margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
          child: Text(
            firstLetter,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.green,
            )
          ),
        ),
        ),
      );
    var a = List<Widget>.from(cityList.map((city) {
        return Expanded(
          flex: 0,
          child: GestureDetector(
            onTap: () {
              // setState(() {
              //   currentCity = city;
              // });
              Navigator.popAndPushNamed(context, 'home', arguments: { 'currentCity': city });
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              height: 50.0,
              constraints: BoxConstraints.tightForFinite(),
              child: Text(
                city,
                style: TextStyle(
                  color: currentCity == city ? Colors.white : Colors.black,
                )
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
                color: currentCity == city ? Colors.orange : Colors.white
              ),
            ),
          ),
        );
    }));
    list.addAll(a);
    });
    return list;
  }

  // 获取路有参数
  _getParams() {
    Map params = ModalRoute.of(context).settings.arguments;
    setState(() {
      currentCity = params['currentCity'];
      positionCity = params['positionCity'];
    });
  }

  @override
  Widget build(BuildContext context) {
    _getParams();
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
        elevation: 0,
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
        color: Color(0xFFF5F5F5),
        child: Stack(
          children: <Widget>[
            // 地址
            ListView(
              children: <Widget>[
                // 当前城市
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 50.0, 0, 10.0),
                  child: Text(
                    '当前城市',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF000000)
                    )
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    GestureDetector(
                      onTap: currentCity == null
                        ? () => Message.warning(context, '必须先选择一个城市')
                        : () => Navigator.popAndPushNamed(context, 'home', arguments: {'currentCity': currentCity}),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: mediaQuery.size.width / 3.5,
                        height: 32.0,
                        alignment: Alignment.center,
                        constraints: BoxConstraints.tightFor(),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Color(0xFFFF576C), width: 1),
                            top: BorderSide(color: Color(0xFFFF576C), width: 1),
                            right: BorderSide(color: Color(0xFFFF576C), width: 1),
                            bottom: BorderSide(color: Color(0xFFFF576C), width: 1),
                          ),
                          color: Colors.white,
                        ),
                        child: Text(
                          currentCity ?? '暂无选择城市',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFFF576C),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                // 定位城市
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                  child: Text(
                    '定位城市',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF000000)
                    )
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    GestureDetector(
                      onTap: currentCity == null
                        ? () => Message.warning(context, '必须先选择一个城市')
                        : () => Navigator.popAndPushNamed(context, 'home', arguments: { 'currentCity': positionCity }),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: mediaQuery.size.width / 3.5,
                        height: 32.0,
                        alignment: Alignment.center,
                        constraints: BoxConstraints.tightFor(),
                        decoration: BoxDecoration(
                          border: currentCity == positionCity ? Border(
                            left: BorderSide(color: Color(0xFFFF576C), width: 1),
                            top: BorderSide(color: Color(0xFFFF576C), width: 1),
                            right: BorderSide(color: Color(0xFFFF576C), width: 1),
                            bottom: BorderSide(color: Color(0xFFFF576C), width: 1),
                          ) : null,
                          color: Colors.white,
                        ),
                        child: Text(
                          positionCity ?? '暂无定位城市',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: currentCity == positionCity ? Color(0xFFFF576C) : Color(0xFF999999),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                // 城市数据
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                  child: Text(
                    '热门城市',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF000000)
                    )
                  ),
                ),
                // 热门城市
                Wrap(
                  children: _address != null ? List<String>.from(_address['hotList']).map((city) {
                  return GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   currentCity = city;
                      // });
                      Navigator.popAndPushNamed(context, 'home', arguments: { 'currentCity': city });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: mediaQuery.size.width / 3.5,
                      height: 32.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: currentCity == city ? Border(
                          left: BorderSide(color: Color(0xFFFF576C), width: 1),
                          top: BorderSide(color: Color(0xFFFF576C), width: 1),
                          right: BorderSide(color: Color(0xFFFF576C), width: 1),
                          bottom: BorderSide(color: Color(0xFFFF576C), width: 1),
                        ) : null,
                        color: Colors.white,
                      ),
                      child: Text(
                        city,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF999999),
                        )
                      ),
                    ),
                  );
                }).toList()
                : [],
                ),
                // 城市列表
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _renderCityList()
                ),
              ],
            ),
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
