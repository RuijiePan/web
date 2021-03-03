import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Created on 2/22/21
 * @author panruijie
 * 设置品牌水印定制
 */
class BrandCustomizationSetting extends StatelessWidget {
  static const String _PREVIEW_URL =
      "http://hk-facex-akm.biugoing.com/biugolite/admin/file/1614049891leWAYHQg.png?w=888&h=887";
  static const String _PC_URL = "https://marki-user.biusq.com";
  static const String _WECHAT_NUMBER = "16626414008";

  BrandCustomizationSetting();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //白色背景
        Container(
          color: Color(0xFFF6F7FB),
          width: double.infinity,
          height: double.infinity,
        ),
        //渐变色背景
        Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.center,
                colors: [
                  Color(0xFF2E5BFF).withOpacity(1.0),
                  Color(0xFF2E5BFF).withOpacity(0.0),
                ],
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Image(
                image: AssetImage("images/comment_back_white.png"),
                width: 24,
                height: 24,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "设置品牌水印定制",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(),
        )
      ],
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _preview(context),
                SizedBox(
                  height: 20,
                ),
                _previewBottomText("设置公司层级架构，多个团队统一管理"),
                SizedBox(
                  height: 4,
                ),
                _previewBottomText("通过数据看板一键查看所有层级团队数据"),
                SizedBox(
                  height: 34,
                ),
                _title(),
                SizedBox(
                  height: 8,
                ),
                _createFunction("方式一：自助创建"),
                SizedBox(
                  height: 8,
                ),
                _pcOperator(context),
                SizedBox(
                  height: 14,
                ),
                _inputText(1, "在电脑浏览器地址栏输入以上地址"),
                SizedBox(
                  height: 7,
                ),
                _inputText(2, "使用已加入团队的微信号扫码或手机号登录"),
                SizedBox(
                  height: 20,
                ),
                _createFunction("方式二：联系客服开通"),
                _copyWechat(context)
              ],
            ),
          )),
    );
  }

  _preview(BuildContext context) {
    Uri u = Uri.parse(_PREVIEW_URL);
    int width = 9;
    int height = 16;
    try {
      width = int.parse(u.queryParameters['w']);
      height = int.parse(u.queryParameters['h']);
    } on Exception catch (error) {
      print("error = ${error.toString()}");
    }
    return Container();
  }

  //图片底部文字
  _previewBottomText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(2)),
          child: new Container(
            width: 4,
            height: 4,
            color: Color(0xFF2E5BFF),
          ),
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontSize: (14), color: Color(0xFF50607A)),
        )
      ],
    );
  }

  //创建方式
  _title() {
    return Text(
      "创建方式",
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 22, color: Color(0xFF232325)),
    );
  }

  //方式一/二
  _createFunction(String text) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Divider(
            height: 1,
            color: Color(0xffE9ECF3),
          )),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: (16),
              color: Color(0xFF232325)),
        ),
        SizedBox(width: 10),
        Expanded(
            child: Divider(
              height: 1,
              color: Color(0xffE9ECF3),
            ))
      ],
    );
  }

  //pc复制链接
  _pcOperator(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Color(0xFFF6F7FB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 8),
            Expanded(
                child: Text(
                  _PC_URL,
                  style: TextStyle(color: Color(0xFF232325), fontSize: (16)),
                  maxLines: 1,
                )),
            SizedBox(width: 8),
            InkWell(
                child: Container(
                  color: Color(0xFF2E5BFF),
                  padding: EdgeInsets.all(12),
                  child: Text("copy",
                      style: TextStyle(color: Colors.white, fontSize: (16))),
                ),
                onTap: () {})
          ],
        ),
      ),
    );
  }

  //方式一操作步骤
  _inputText(int index, String text) {
    return Row(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
                width: 14,
                height: 14,
                color: Color(0xFF50607A),
                alignment: Alignment.center,
                child: Text(
                  "$index",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: (11),
                      fontWeight: FontWeight.w500),
                ))),
        SizedBox(width: 9),
        Text(
          text,
          style: TextStyle(
              color: Color(0xFF50607A),
              fontSize: (14),
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  _copyWechat(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("添加客服微信号：",
            style: TextStyle(
                color: Color(0xFF50607A),
                fontSize: (14),
                fontWeight: FontWeight.w400)),
        Image.asset("images/round_wechat.png", width: 20, height: 20),
        SizedBox(
          width: 5,
        ),
        Text(_WECHAT_NUMBER,
            style: TextStyle(
                color: Color(0xFF50607A),
                fontSize: (14),
                fontWeight: FontWeight.w400)),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: GestureDetector(
              child: Container(
                  child: Text("copy",
                      style: TextStyle(
                          color: Color(0xFF2E5BFF),
                          fontSize: (14),
                          fontWeight: FontWeight.w400)),
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15)),
              onTap: () {
                // FeedbackChannel.openWechat(_WECHAT_NUMBER).then((value) {
                //   YFlutterToast.showToast(S.of(context).vip_wehcat_copy_success);
                // });
              },
            ))
      ],
    );
  }
}
