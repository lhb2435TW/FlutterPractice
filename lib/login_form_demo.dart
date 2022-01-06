import 'package:flutter/material.dart';

void main() => runApp(LoginFormDemo());

class LoginFormDemo extends StatefulWidget {
  const LoginFormDemo({Key? key}) : super(key: key);

  @override
  State createState() => LoginFormDemoState();
}

class LoginFormDemoState extends State<LoginFormDemo> {
  static const String _title = "로그인 폼 데모";
  late String _id;
  late String _pw;

  void onChangeText() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Colors.black),
              ),
              height: 100.0,
              margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              child: TextField(

              ),
            ),
          ],
        ),
      ),
    );
  }
}