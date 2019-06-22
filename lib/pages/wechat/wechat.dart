// 微信页
import 'package:flutter/material.dart';
// import 'package:device_info/device_info.dart';

class Wechat extends StatelessWidget {
  Wechat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('微信页', style: TextStyle(color: Colors.white)),
        centerTitle: true
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 50.0),
        color: Colors.orange,
        alignment: Alignment.center,
        child: new Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '微信页，用于测试调用系统功能',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 3.0
              )
            ),
            Text('微信页，用于测试调用系统功能'),
          ],
        ),
      )
    );
  }
}
