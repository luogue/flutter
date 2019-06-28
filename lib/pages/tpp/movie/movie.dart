import 'package:flutter/material.dart';
import 'package:yangyue/api/api.dart';
import 'package:yangyue/config/network.dart';
import 'package:yangyue/components/toast.dart';

class Movie extends StatefulWidget {
  Movie({Key key}) : super(key: key);

  @override
  _MovieState createState() => new _MovieState();
}

class _MovieState extends State<Movie> {
  ScrollController _controller = new ScrollController();
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
    });
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
  List<Widget> 
  list = [
    ListTile(title: Text('1')),
    ListTile(title: Text('2')),
    ListTile(title: Text('3')),
    ListTile(title: Text('4')),
    ListTile(title: Text('5')),
    ListTile(title: Text('6')),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('电影'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 1,
            // itemExtent: 5011.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return Container(
                height: 10000,
                child: Text('1'),
              );
            }
        ),
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