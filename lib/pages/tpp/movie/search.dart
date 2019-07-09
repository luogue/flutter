import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';
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
  Map _searchResult;
  List<String> a = [];

  @override
  void initState() {
    super.initState();
  }

  // 获取搜索结果
  _searchResource(context, String searchText) {
    Future res = post(context, api.searchResource, {'searchText': searchText});
    res.then((data) {
      setState(() { _searchResult = data; });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，等会儿再试~');});
  }

  // 通过页面状态计算3个不同的页面切换
  Widget _getCurrentWidget () {
    switch (_pageStatus) {
      case 0:
        return Container(
          child: Text('1')
        );
      case 1:
        // 搜索过渡
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/loading.jpg"),
              width: 50.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text('正在加载，么么哒~', style: TextStyle(color: Color(0xFF9591A7)))
            )
          ],
        );
      case 2:
        return Container(
          child: Text('1')
        );
      default:
        return Container(
          child: Text('未找到该状态')
        );
    }
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
                          // controller: _textEditingController,
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
                            _searchResource(context, text);
                            // setState(() {
                            //   _pageStatus = 2;
                            // });
                          },
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                            });
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
