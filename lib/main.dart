import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jsbridge/jsbridge.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web/feedback_channel.dart';
import 'dart:html' as html;
import 'dart:js' as js;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BotToast.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  static const String _PREVIEW_URL =
      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2849993288,4096874629&fm=26&gp=0.jpg?w=500&h=500";
  static const String _PC_URL = "https://marki-user.biusq.com";
  static const String _WECHAT_NUMBER = "16626414008";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          body: _body(context),
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
    return SingleChildScrollView(
        child: CachedNetworkImage(
            imageUrl: _PREVIEW_URL,
            placeholder: (context, url) => AspectRatio(
                aspectRatio: width * 1.0 / height,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center)),
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: width * 1.0 / height,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
            )));
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
                  child: Text("复制",
                      style: TextStyle(color: Colors.white, fontSize: (16))),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _PC_URL)).then((value) {
                    BotToast.showText(text: "复制成功，请在PC客户端打开");
                    // Fluttertoast.showToast(
                    //     msg: "复制成功，请在PC客户端打开",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.CENTER,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0
                    // );
                    //YFlutterToast.showToast(S.of(context).copied_open_in_pc);
                  });
                })
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

  static final _bridge = JSBridge("nativeHost");

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
                  child: Text("复制",
                      style: TextStyle(
                          color: Color(0xFF2E5BFF),
                          fontSize: (14),
                          fontWeight: FontWeight.w400)),
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15)),
              onTap: () {
                // js.context["nativeHost"].callMethod("openWx");
                // _bridge.registerFunction("openWx", (arguments) => null);
                BotToast.showText(text: "复制微信成功");
                FeedbackChannel.openWechat(_WECHAT_NUMBER).then((value) {
                  Fluttertoast.showToast(
                      msg: "复制微信成功",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }).catchError((onError) {
                  Fluttertoast.showToast(
                      msg: "打开失败, msg = ${onError.toString()}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }) ;
              },
            ))
      ],
    );
  }
}
