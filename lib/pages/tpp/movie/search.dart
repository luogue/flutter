import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textEditingController = new TextEditingController();
  String _searchText = '';
  // 0为初始状态，清空搜索框时展示；1为搜索过渡状态；2为搜索结果页面
  num _pageStatus = 0;
  Map _searchResult;

  @override
  void initState() {
    super.initState();
  }

  // 获取搜索结果
  _searchResource(context, String searchText) {
    var res = post(context, api.searchResource, {'searchText': searchText});
    res.then((data) {
      setState(() { _searchResult = data; });
    // }).catchError((e) { Message.error(context, e.toString()); });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Scrollbar(
        child: Column(
          children: <Widget>[
            // 搜索框
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 30.0, 0.0, 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                )
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
          ],
        )
      ),
    );
  }
}

// 热映影片渲染函数
_renderHot(data) {
  if (data == null) return null;
  List<Widget> list = [];
  data['list'].forEach((item) {
    list.add(Container(
      margin: new EdgeInsets.symmetric(horizontal: 3.0),
      width: 114.0,
      child: Column(children: <Widget>[
        Container(
          margin: new EdgeInsets.only(bottom: 5.0),
          width: 114.0,
          height: 160.0,
          color: Color(0xFFDDDDDD),
          // 电影图片
          child: GestureDetector(
            child: Image(
              image: NetworkImage(item['url'])
            ),
            onTap: () => print('查看电影详情')
          )
        ),
        Text(
          item['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black54)
        ),
        // 购买和预售按钮
        MaterialButton(
          minWidth: 60.0,
          height: 30.0,
          color: item['status'] == 0 ? Colors.orange : Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Color(0xFFDDDDDD),
          child: Text(item['status'] == 0 ? '购票' : '预售'),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => print('购买电影票')
        )
      ])
    ));
  });
  // 显示全部电影数量
  list.add(Container(
    margin: new EdgeInsets.symmetric(horizontal: 3.0),
    width: 114.0,
    child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10.0),
        width: 114.0,
        height: 160.0,
        color: Color(0xFFDDDDDD),
        child: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('全部', style: TextStyle(color: Color(0xFF999999))),
                Container(
                  margin: EdgeInsets.all(6.0),
                  width: 50.0,
                  height: 1.0,
                  color: Color(0xFFCCCCCC)
                ),
                Text('${data['total']}部', style: TextStyle(color: Color(0xFF999999)))
              ]
            ),
            onTap: () => print('查看上映电影列表')
          )
      )
    ])
  ));
  return ListView(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    children: list
  );
}