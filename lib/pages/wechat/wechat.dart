// 微信页
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yangyue/components/toast.dart';
import 'package:device_info/device_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contact_picker/contact_picker.dart';


class Wechat extends StatefulWidget {
  Wechat({Key key}) : super(key: key);

  @override
  _WechatState createState() => _WechatState();
}

class _WechatState extends State<Wechat> {
  List<File> _photoList = [];
  List<File> _imageList = [];
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  _renderImageList(imageList) {
    if (imageList == null) return null;
    List<Widget> list = [];
    imageList.forEach((_image) {
      list.add(
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Image.file(_image, fit: BoxFit.cover)
        )
      );
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: list
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('微信页', style: TextStyle(color: Colors.white)),
        centerTitle: true
      ),
      body: new Container(
        color: Colors.orange,
        child: ListView(
          children: <Widget>[
            Text(
              '微信页，用于测试调用系统功能',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 2.0,
              )
            ),
            // 设备信息
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.blueGrey,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('获取手机信息'),
                onPressed: () async {
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                  Message.success(context, androidInfo.model);
                },
              ),
            ),
            // 拍照
            Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.blueGrey,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('拍个丑照'),
                onPressed: () async {
                  var image = await ImagePicker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _photoList.add(image);
                    });
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:  _imageList.length == 0 ? 0 : 10.0),
              height: _photoList.length == 0 ? 0 : 160.0,
              child: _renderImageList(_photoList)
            ),
            // 相册
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.blueGrey,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('看看照片呢'),
                onPressed: () async {
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imageList.add(image);
                    });
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _imageList.length == 0 ? 0 : 10.0),
              height: _imageList.length == 0 ? 0 : 160.0,
              child: _renderImageList(_imageList)
            ),
            // webview
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.blueGrey,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('打开webview'),
                onPressed: () {
                  Navigator.pushNamed(context, 'webview');
                },
              ),
            ),
            // 读取联系人
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 120.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.blueGrey,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('读取联系人'),
                onPressed: () async {
                  Contact contact = await _contactPicker.selectContact();
                  Message.success(context, contact.toString());
                  setState(() {
                    _contact = contact;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _contact == null ? 0 : 10.0),
              alignment: Alignment.center,
              // height: _imageList.length == 0 ? 0 : 160.0,
              child: Text(
                _contact == null ? '' : _contact.toString()
              ),
            ),
          ],
        ),
      )
    );
  }
}
