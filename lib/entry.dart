// 入口页
import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  Entry({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('入口页', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer(); 
            },
          );
        })
      ),
      drawer: new MyDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Image(
                image: AssetImage("assets/images/nav.gif"),
                width: 160.0,
                height: 160.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 120.0),
              child: Text(
                '月月的个人项目，可以打开左上角的菜单选项进行跳转',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.fromLTRB(0, 210, 0, 0),
              child: Image(
                image: AssetImage("assets/images/yueyue.gif"),
                width: 150.0,
                height: 150.0,
              ),
            ),
          ],
        )
      )
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  // 淘票票
                  GestureDetector(
                    child: ListTile(
                      leading: const Icon(Icons.movie, color: Colors.deepOrange),
                      title: const Text('淘票票', style: TextStyle(color: Colors.deepOrange)),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'home'),
                  ),
                  // 微信：用于测试原生功能
                  GestureDetector(
                    child: ListTile(
                      leading: const Icon(Icons.offline_bolt, color: Colors.deepOrange),
                      title: const Text('微信', style: TextStyle(color: Colors.deepOrange)),
                    ),
                    onTap: ()=> Navigator.pushNamed(context, 'wechat'),
                  ),
                  // Flutter：用于测试 Flutter 的功能
                  GestureDetector(
                    child: ListTile(
                      leading: const Icon(Icons.touch_app, color: Colors.deepOrange),
                      title: const Text('Flutter', style: TextStyle(color: Colors.deepOrange)),
                    ),
                    onTap: ()=> Navigator.pushNamed(context, 'index'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
