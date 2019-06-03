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
      body: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Text('即将上映'),
              Text('全部')
            ]
          ),
          _renderItem(_advertisementList)
          // _renderItem()
          // ListView(
          //   shrinkWrap: true,
          //   children: <Widget>[
          //     Container(
          //       child: Text('数据')
          //     )
          //   ],
          //   // children: list,
          // )
        ]
      )
    );
  }
}

_renderItem(data) {
  print('_render=====================');
  // print(data);
  // print(data['list']);
  // if (data == null) {
    data = {
      'list': [{}, {}, {}, {}, {}]
    };
  // }
  List<Widget> list = [];
  data['list'].forEach((item) {
    list.add(Container(
      margin: EdgeInsets.only(top: 5),
      width: 10,
      height: 10,
      // constraints: BoxConstraints.tightFor(width: 20.0, height: 15.0),
      color: Colors.grey,
    ));
  });
  return ListView(
    shrinkWrap: true,
    // children: <Widget>[
    //   Container(
    //     child: Text('数据')
    //   )
    // ],
    children: list,
  );
}