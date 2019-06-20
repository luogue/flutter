import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => new _VideoState();
}

class _VideoState extends State<Video> {
  Map _advertisementList;
  Map _hot;
  Map _reach;
  Map _performance;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _getAdvertisementList(context);
    _getHot(context);
    _getReach(context);
    _getPerformance(context);
  }

  // 获取广告列表
  _getAdvertisementList(context) {
    var res = get(context, api.getAdvertisementList);
    res.then((data) {
      setState(() { _advertisementList = data; });
    }).catchError((e) { print(e); });
  }
  // 热映影片
  _getHot(context) {
    var res = get(context, api.getHot);
    res.then((data) {
      setState(() { _hot = data; });
    }).catchError((e) { print(e); });
  }
  // // 即将上映
  _getReach(context) {
    var res = get(context, api.getReach);
    res.then((data) {
      setState(() {
        _reach = data;
      });
    }).catchError((e) { print(e); });
  }
  // 热门演出
  _getPerformance(context) {
    var res = get(context, api.getPerformance);
    res.then((data) {
      setState(() {
        _performance = data;
      });
    }).catchError((e) { print(e); });
  }

  // 点击tab
  _onItemTapped(int index) {
    String routeName;
    if (_selectedIndex == index) return;
    switch (index) {
      case 0:
        routeName = 'home';
        break;
      case 1:
        routeName = 'movie';
        break;
      case 2:
        routeName = 'video';
        break;
      case 3:
        routeName = 'performance';
        break;
      case 4:
        routeName = 'mine';
        break;
    }
    Navigator.popAndPushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('淘气TV'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: ListView(
          children: <Widget>[
            // 轮播图
            Container(
              // padding: EdgeInsets.only(bottom: 30.0),
              height: 245.0,
              color: Colors.orange,
              child: _renderAdvertisement(_advertisementList)
            ),
            // 热映影片
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10.0),
              // margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
              color: Colors.white,
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '热映影片',
                          style: TextStyle(
                            fontSize: 18.0
                          )
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: GestureDetector(
                          child: Row(children: <Widget>[
                            Text(
                              '全部${ _hot != null ? _hot['total'] : 0 }部  ',
                              style: TextStyle(
                                color: Color(0xFFA8A8A6)
                              )
                            ),
                            Icon(Icons.arrow_forward_ios, color: Color(0xFFA8A8A6), size: 12.0)
                          ]),
                          onTap: () => print('查看热映影片全部')
                        )
                      )
                    ]
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 18.0),
                  height: 240.0,
                  child: _renderHot(_hot)
                )
              ])
            ),
            // 即将上映
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
              color: Colors.white,
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '即将上映',
                          style: TextStyle(
                            fontSize: 18.0
                          )
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: GestureDetector(
                          child: Row(children: <Widget>[
                            Text(
                              '全部  ',
                              style: TextStyle(
                                color: Color(0xFFA8A8A6)
                              )
                            ),
                            Icon(Icons.arrow_forward_ios, color: Color(0xFFA8A8A6), size: 12.0)
                          ]),
                          onTap: () => print('查看即将上映全部')
                        )
                      )
                    ]
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 18.0),
                  height: 240.0,
                  child: _renderReach(_reach)
                )
              ])
            ),
            // 热门演出
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
              color: Colors.white,
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '热门演出',
                          style: TextStyle(
                            fontSize: 18.0
                          )
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: GestureDetector(
                          child: Row(children: <Widget>[
                            Text(
                              '全部  ',
                              style: TextStyle(
                                color: Color(0xFFA8A8A6)
                              )
                            ),
                            Icon(Icons.arrow_forward_ios, color: Color(0xFFA8A8A6), size: 12.0)
                          ]),
                          onTap: () => print('查看即将开始的全部演出')
                        )
                      )
                    ]
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 18.0),
                  height: 240.0,
                  child: _renderPerformance(_performance)
                )
              ])
            )
          ]
        )
      ),
      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'), backgroundColor: Colors.orange),
          BottomNavigationBarItem(icon: Icon(Icons.movie), title: Text('电影')),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), title: Text('淘气视频')),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), title: Text('演出')),
          BottomNavigationBarItem(icon: Icon(Icons.spa), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.orangeAccent,
        onTap: (int index) {
          _onItemTapped(index);
        }
      ),
    );
  }
}

// 轮播图渲染函数
_renderAdvertisement(data) {
  if (data == null) return null;
  List<Widget> list = [];
  data['list'].forEach((item) {
    list.add(GestureDetector(
      child: Image(
        width: 394.0,
        image: NetworkImage(item['url'])
      ),
      onTap: () => print('进入广告页面')
    ));
  });
  return ListView(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    children: list
  );
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
// 即将上映渲染函数
_renderReach(data) {
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
        Text(
          item['time'],
          style: TextStyle(color: Color(0xFFCCCCCC))
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10.0),
        width: 114.0,
        height: 160.0,
        color: Color(0xFFDDDDDD),
        child: GestureDetector(
          child: Text('全部', style: TextStyle(color: Color(0xFF999999))),
          onTap: () => print('查看即将上映列表')
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

// 即将上映渲染函数
_renderPerformance(data) {
  if (data == null) return null;
  List<Widget> list = [];
  data['list'].forEach((item) {
    list.add(Container(
      margin: new EdgeInsets.symmetric(horizontal: 3.0),
      width: 114.0,
      child: Column(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(bottom: 5.0),
            width: 114.0,
            height: 160.0,
            color: Color(0xFFDDDDDD),
            // 演出图片
            child: GestureDetector(
              child: Image(
                image: NetworkImage(item['url'])
              ),
              onTap: () => print('查看演出详情')
            )
          ),
          Container(
            height: 40.0,
            child: Text(
              item['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54)
            ),
          ),
          Text(
            item['time'],
            style: TextStyle(color: Color(0xFFCCCCCC))
          )
        ]
      )
    ));
  });
  // 显示全部演出数量
  list.add(Container(
    margin: new EdgeInsets.symmetric(horizontal: 3.0),
    width: 114.0,
    child: Column(children: <Widget>[
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10.0),
        width: 114.0,
        height: 160.0,
        color: Color(0xFFDDDDDD),
        child: GestureDetector(
          child: Text('全部', style: TextStyle(color: Color(0xFF999999))),
          onTap: () => print('查看即将演出列表')
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