import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}