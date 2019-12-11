import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';
import 'package:yangyue/components/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  String _searchText = '';
  // 0为初始搜索页，清空搜索框时展示；1为搜索过渡状态；2为搜索结果页面
  num _pageStatus = 0;
  List<String> _hotSearch = [];
  Map _searchResult;
  List<String> _searchList;
  SharedPreferences _localStorage;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _getHotSearch(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    print('搜索========================');
    _localStorage.setStringList('searchList', _searchList);
  }

  // 初始化持久化存储
  Future<void> _initStorage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _localStorage = _prefs;
      _searchList = _prefs.getStringList('searchList') ?? [];
    });
  }

  // 获取热门搜索
  _getHotSearch(context) {
    Future res = get(context, api.hotSearch);
    res.then((data) {
      Message.success(context, '获取热门搜索');
      setState(() {
        _hotSearch = List<String>.from(data['list']);
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
        _pageStatus = 2;
        _searchResult = data;
      });
    }).catchError((e) {
      Message.error(context, '网络请求超时，等会儿再试~');
    });
  }

  // 处理搜索历史字符串操作
  _handleSearchText(String text) {
    // 非空才能搜索
    if (text != '') {
      // 显示搜索过渡状态
      setState(() {
        _searchText = text;
        _pageStatus = 1;
      });
      // 搜索
      _searchResource(context, text);
      if (_searchList.contains(text)) {
        // 把这个元素移动到最后面
        _searchList.remove(text);
        _searchList.add(text);
      } else {
        setState(() {
          _searchList.add(text);
        });
      }
    }
  }

  // 通过页面状态计算3个不同的页面切换
  Widget _getCurrentWidget () {
    switch (_pageStatus) {
      case 0:
        // 搜索页
        return ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('搜索记录', style: TextStyle(color: Color(0xFFA0A0A0)),),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchList.clear();
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Color(0xFFA0A0A0),
                    ),
                  )
                ],
              ),
            ),
            Wrap(
              children: _renderList(_searchList.reversed.toList()),
            ),
            // 热门搜索
            Container(
              margin: EdgeInsets.fromLTRB(0, 50.0, 0, 10.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('热门搜索', style: TextStyle(color: Color(0xFFA0A0A0))),
            ),
            Wrap(
              children: _renderList(_hotSearch),
            )
          ]
        );
      case 1:
        // 搜索过渡页
        return Loading();
      case 2:
        // 搜索结果页
        return Container(
          color: Color(0xFFEEEEEE),
          child: ListView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            children: <Widget>[
              // 影人
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text('影人', style: TextStyle(color: Color(0xFFA0A0A0))),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  color: Colors.white
                ),
              ),
              Column(
                children: _renderActors('actors')
              ),
              // 电影
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.all(15.0),
                child: Text('电影', style: TextStyle(color: Color(0xFFA0A0A0))),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  color: Colors.white
                ),
              ),
              Column(
                children: _renderActors('movies')
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  color: Colors.white
                ),
                child: GestureDetector(
                  child: Text('查看全部20部影片', style: TextStyle(color: Color(0xFF4BA7EE))),
                  onTap: () => Message.warning(context, '查看全部20部影片'),
                )
              )
            ],
          )
        );
      default:
        return Container(
          child: Text('未找到该状态')
        );
    }
  }

  // 渲染搜索资源名称
  _renderList(List<String> list) {
    if (list == null) return null;
    List<Widget> _list = [];
    list.forEach((text) {
      _list.add(
        // 搜索资源名称字符串
        GestureDetector(
          onTap: () {
            _handleSearchText(text);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        )
      );
    });
    return _list;
  }

  // 渲染演员列表
  _renderActors(String type) {
    if (_searchResult == null) return null;
    return List<Map<String, dynamic>>.from(_searchResult[type]).map((item) {
      var container = Container(
        height: 150.0,
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  item['image'],
                  fit: BoxFit.cover,
                ),
                // child: Text(item['image']),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 0, 50.0, 0),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: type == 'actors'
                  // 演员
                  ? <Widget>[
                    Text(
                      item['name'],
                      style: TextStyle(
                        color: Color(0xFFFF2221),
                        fontSize: 18.0,
                      )
                    ),
                    Text(item['nickName'], style: TextStyle(color: Color(0xFF666666))),
                    Text(
                      item['works'].fold('作品', (preValue, work) {
                        return preValue + work;
                      }) + '等',
                      style: TextStyle(color: Color(0xFF999999))
                    )
                  ]
                  // 电影列表
                  : <Widget>[
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                      )
                    ),
                    item['status'] == 2
                    // 未上映
                    ? Row(
                      children: <Widget>[
                        Text(
                          '${item['expects']}',
                          style: TextStyle(
                            color: Color(0xFFFEB46A),
                            fontWeight: FontWeight.w700,
                          )
                        ),
                        Text(' 人想看'),
                      ],
                    )
                    // 已上映
                    : Row(
                      children: <Widget>[
                        Text('淘票票评分 '),
                        Text(
                          '${item['rate']}',
                          style: TextStyle(
                            color: Color(0xFFFEB46A),
                            fontWeight: FontWeight.w700,
                          )
                        ),
                      ],
                    ),
                    Text(
                      item['actors'].fold('', (preValue, actor) {
                        return preValue + actor + ' ';
                      }),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xFF999999))
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          item['countries'].fold('', (preValue, country) {
                            return preValue + country + '  ';
                          }),
                          style: TextStyle(color: Color(0xFF999999))
                        ),
                        Text('${item['time']}', style: TextStyle(color: Color(0xFF999999))),
                      ],
                    ),
                  ],
                )
              )
            ),
          ],
        )
      );
      return container;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80.0),
              child: _getCurrentWidget(),
            ),
            // 搜索框
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 80.0,
              child: Container(
                padding: EdgeInsets.fromLTRB(16.0, 30.0, 0.0, 8.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  color: Colors.white
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget> [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 32.0,
                        child: TextField(
                          autofocus: true,
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
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                            ),
                            hintText: '搜影院、影片、影人、演出、资讯、视频',
                            isDense: true,
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
                                  _pageStatus = 0;
                                });
                              }
                            ),
                            filled: true,
                            fillColor: Color(0xFFEEEEEE),
                          ),
                          style: TextStyle(
                            fontSize: 12.0,
                            height: 1.6,
                          ),
                          textInputAction: TextInputAction.search,
                          maxLengthEnforced: true,
                          cursorColor: Colors.red,
                          cursorRadius: Radius.circular(10),
                          onSubmitted: (text) {
                            _handleSearchText(text);
                          },
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                            });
                            // 清空输入文本时显示搜索页
                            if (text == '') {
                              setState(() {
                                _pageStatus = 0;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Color(0xFF666666)
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pop(context)
                      )
                    ),
                  ]
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
