import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  Index({Key key}) : super(key: key);

  // @override
  // _IndexState createState() => new _IndexState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('淘票票首页'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('淘票票页面'),
          ],
        ),
      )
    );
  }
}

// class _IndexState extends State<Index> {
//   int _counter;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
// }