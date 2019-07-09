import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Map _advertisementList;
  Map _hot;
  Map _reach;
  Map _performance;
  Map _recommend;
  int _selectedIndex = 0;
  double _headerHeight = 80.0;
  ScrollController _controller = new ScrollController();
  // 滚动条到顶部的距离
  double _distance = 0;
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _getAdvertisementList(context);
    _getHot(context);
    _getReach(context);
    _getPerformance(context);
    _getRecommend(context);
    Message.success(context, '初始化状态栏');
    // 隐藏顶部状态栏
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // 恢复
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset <= _headerHeight) {
        setState(() {
          _distance = _controller.offset;
          _showHeader = false;
        });
      }
      if (_showHeader == false && _controller.offset > _headerHeight) {
        setState(() {
          _distance = 80;
          _showHeader = true;
        });
      }
    });
  }

  // 获取广告列表
  _getAdvertisementList(context) {
    Future res = get(context, api.getAdvertisementList);
    res.then((data) {
      setState(() { _advertisementList = data; });
    // }).catchError((e) { Message.error(context, e.toString()); });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
  }

  // 热映影片
  _getHot(context) {
    Future res = get(context, api.getHot);
    res.then((data) {
      setState(() { _hot = data; });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
  }

  // 即将上映
  _getReach(context) {
    Future res = get(context, api.getReach);
    res.then((data) {
      setState(() {
        _reach = data;
      });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
  }
  // 热门演出
  _getPerformance(context) {
    Future res = get(context, api.getPerformance);
    res.then((data) {
      setState(() {
        _performance = data;
      });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
  }

  // 热门演出
  _getRecommend(context) {
    Future res = get(context, api.getRecommend);
    res.then((data) {
      setState(() {
        _recommend = data;
      });
    }).catchError((e) { Message.error(context, '网络请求超时，因为easy-mock接口挂了，暂时没数据，等会儿再试~');});
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
      body: Container(
        color: Color(0xFFEEEEEE),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // 内容
            Container(
              height: 300.0,
              child: ListView(
                padding: EdgeInsets.all(0),
                controller: _controller,
                children: <Widget>[
                  // 轮播图
                  Container(
                    height: 245.0,
                    color: Colors.orange,
                    child: Swiper(
                      itemBuilder: (BuildContext context,int index){
                        if (_advertisementList != null) {
                          return GestureDetector(
                            child: Image.network(_advertisementList['list'][index]['url'],fit: BoxFit.cover),
                            onTap: () => Message.warning(context, '我还没开发呢，点J8啊点')
                          );
                        }
                      },
                      autoplay: true,
                      itemCount: _advertisementList != null ? _advertisementList['list'].length : 0,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          size: 5.0,
                          activeSize: 5.0,
                          space: 2.0,
                          color: Color(0xFF999999),
                          activeColor: Color(0xFFEEEEEE),
                        ),
                      )
                    ),
                  ),
                  // 热映影片
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
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
                                  onTap: () => Message.success(context, '查看热映电影列表')
                                )
                              )
                            ]
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 18.0),
                          height: 240.0,
                          child: _renderHot(context, _hot)
                        )
                      ]
                    )
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
                                onTap: () => Message.success(context, '查看即将上映全部')
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 18.0),
                        height: 240.0,
                        child: _renderReach(context, _reach)
                      )
                    ])
                  ),
                  // 热门演出
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
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
                                  onTap: () => Message.success(context, '查看即将开始的全部演出')
                                )
                              )
                            ]
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 18.0),
                          height: 240.0,
                          child: _renderPerformance(context, _performance)
                        )
                      ]
                    )
                  )
                ]
              )
            ),
            // 头部
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _distance,
              child: Container(
                color: Color.fromRGBO(255, 255, 255, _distance / _headerHeight)
              )
            ),
            // 利用CSS的常用布局，容器没有高度，子元素占据各自的高度，完美
            Positioned(
              top: 40.0,
              left: 20.0,
              right: 15.0,
              height: 90,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5.0,
                    left: 0,
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text('成都', style: TextStyle(color: Color.fromRGBO(((1 - _distance / _headerHeight) * 255).toInt(), ((1 - _distance / _headerHeight) * 255).toInt(), ((1 - _distance / _headerHeight) * 255).toInt(), 1.0))),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromRGBO(((1 - _distance / _headerHeight) * 255).toInt(), ((1 - _distance / _headerHeight) * 255).toInt(), ((1 - _distance / _headerHeight) * 255).toInt(), 1.0),
                            size: 23.0
                          )
                        ],
                      ),
                      onTap: () {
                        Message.success(context, '选择城市列表');
                      },
                    )
                  ),
                  _showHeader
                  // 搜索框
                  ? Positioned(
                    top: 0,
                    height: 32.0,
                    left: 60.0,
                    right: 10.0,
                    child: TextField(
                      onTap: () => Navigator.pushNamed(context, 'search'),
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        // border: OutlineInputBorder(),
                        // border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        // labelText: '搜影院、影片、影人、演出、资讯、视频',
                        hintText: '搜影院、影片、影人、演出、资讯、视频',
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF999999),
                          size: 20.0
                        ),
                        filled: true,
                        fillColor: Color(0xFFEEEEEE),
                      ),
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      maxLengthEnforced: true,
                      cursorColor: Colors.red,
                      cursorRadius: Radius.circular(10),
                    )
                  )
                  // icon
                  : Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.all_out,
                              color: Color.fromRGBO(255, 255, 255, 1 - _distance / _headerHeight),
                              size: 23.0
                            )
                          ),
                          onTap: () => Message.success(context, '扫描二维码')
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.date_range,
                              color: Color.fromRGBO(255, 255, 255, 1 - _distance / _headerHeight),
                              size: 23.0
                            )
                          ),
                          onTap: () => Message.success(context, '日签')
                        ),
                        GestureDetector(
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Color.fromRGBO(255, 255, 255, 1 - _distance / _headerHeight),
                              size: 23.0
                            )
                          ),
                          onTap: () => Navigator.pushNamed(context, 'search')
                        )
                      ]
                    )
                  )
                ]
              )
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

// 热映影片渲染函数
_renderHot(context, data) {
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
              image: NetworkImage(item['url']),
              fit: BoxFit.cover
            ),
            onTap: () => Message.success(context, item['name'])
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
          onPressed: () {
            FlutterErrorDetails();
            if (item['status'] == 0) {
              Message.success(context, item['name']);
            } else {
              Message.success(context, item['name']);
            }
          }
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
            onTap: () => Message.success(context, '查看上映电影列表')
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
_renderReach(context, data) {
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
              image: NetworkImage(item['url']),
              fit: BoxFit.cover
            ),
            onTap: () => Message.success(context, item['name'])
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
          onTap: () => Message.success(context, '查看即将上映列表')
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
_renderPerformance(context, data) {
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
                image: NetworkImage(item['url']),
                fit: BoxFit.cover
              ),
              onTap: () => Message.success(context, item['name'])
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
          onTap: () => Message.success(context, '查看即将演出列表')
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