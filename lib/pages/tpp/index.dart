import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  List _advertisementList;
  Map _hot;
  Map _reach;
  Map _performance;

  @override
  void initState() {
    super.initState();
    //初始化状态  
    print("initState=========================");
    _getAdvertisementList();
    _getHot();
    _getReach();
    _getPerformance();
  }

  // 获取广告列表
  _getAdvertisementList() {
    var res = get(api.getAdvertisementList);
    res.then((data) {
      print('广告============================');
      print(data);
      setState(() { _advertisementList = data['list']; });
    }).catchError((e) { print(e); });
  }
  // 热映影片
  _getHot() {
    var res = get(api.getHot);
    res.then((data) {
      setState(() {
        _hot = data;
      });
    }).catchError((e) { print(e); });
  }
  // 即将上映
  _getReach() {
    var res = get(api.getHot);
    res.then((data) {
      setState(() {
        _reach = data;
      });
    }).catchError((e) { print(e); });
  }
  // 热门演出
  _getPerformance() {
    var res = get(api.getHot);
    res.then((data) {
      setState(() {
        _performance = data;
      });
    }).catchError((e) { print(e); });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('淘票票首页'),
        centerTitle: true,
      ),
      // body: ListView(
      //   children: <Widget>[
      //     Container(
      //       child: Image(
      //         image: NetworkImage(_advertisementList[0]['url']),
      //         width: 100.0,
      //       )
      //     )
      //   ],
      // )
        body: new Container(
          margin: new EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 160.0,
                color: Colors.red,
              ),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 160.0,
                color: Colors.blue,
              ),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 160.0,
                color: Colors.green,
              ),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 160.0,
                color: Colors.yellow,
              ),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 160.0,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      // body: Column(
      //   children: <Widget>[
      //     Flex(
      //       direction: Axis.horizontal,
      //       children: <Widget>[
      //         Text('即将上映'),
      //         Text('全部')
      //       ]
      //     ),
      //     ListView(
      //       children: <Widget>[
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //         Text('1'),
      //       ],
      //     )
      //     // _renderItem(_advertisementList)
      //     // ListView(
      //     //   shrinkWrap: true,
      //     //   children: <Widget>[
      //     //     Container(
      //     //       child: Text('数据')
      //     //     )
      //     //   ],
      //     //   // children: list,
      //     // )
      //   ]
      // )
    );
  }
}

_renderItem(data) {
  print('_render=====================');
  // print(data[0]);
  // if (data == null) {
    data = {
      'list': [{}, {}, {}, {}, {}]
    };
  // }
  List<Widget> list = [];
  data['list'].forEach((item) {
    // list.add(Container(
    //   margin: EdgeInsets.only(top: 10),
    //   width: 50,
    //   height: 100,
    //   // constraints: BoxConstraints.tightFor(width: 20.0, height: 15.0),
    //   color: Colors.grey,
    //   child: Text('加载中', textAlign: TextAlign.center, style: TextStyle( color: Colors.white ),)
    // ));
    list.add(Text('hello'));
  });
  // return GridView(
  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 5, //横轴三个子widget
  //     childAspectRatio: 1.0 //宽高比为1时，子widget
  //   ),
  return ListView(
    // scrollDirection: Axis.horizontal,
    // scrollDirection: Axis.vertical,
    shrinkWrap: true,
    // children: <Widget>[
    //   Container(
    //     child: Text('数据')
    //   )
    // ],
    children: list,
  );
}