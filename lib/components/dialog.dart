import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<void> askedToLead(context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      // return SimpleDialog(
      //   title: const Text('Select assignment'),
      //   children: <Widget>[
      //     SimpleDialogOption(
      //       onPressed: () { Navigator.pop(context, 'hello world'); },
      //       child: const Text('Treasury department'),
      //     ),
      //     SimpleDialogOption(
      //       onPressed: () { Navigator.pop(context, '哎呀妈呀脑瓜疼'); },
      //       child: const Text('State department'),
      //     ),
      //   ],
      // );
      return AlertDialog(
        title: null,
        backgroundColor: Color(0xEE000000),
        contentTextStyle: TextStyle(),
        content: Container(
          // color: Colors.black,
          child: Text(
            'Hello World',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            )
          )
        )
      );
    }
  );
}