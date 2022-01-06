import 'package:flutter/material.dart';

void main() => runApp(const ButtonDemo());

class ButtonDemo extends StatefulWidget {
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  State createState() => ButtonDemoState();
}

class ButtonDemoState extends State<ButtonDemo> {
  static const String _title = "Button 위젯 데모";
  String _buttonState = 'OFF';

  void onClick() {
    print('onClick()');
    setState(() {
      if (_buttonState == 'OFF') {
        _buttonState = 'ON';
      } else {
        _buttonState = 'OFF';
      }
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
            RaisedButton(
              child: const Text('사각 버튼'),
              onPressed: onClick,
            ),
            Text('$_buttonState'),
            RaisedButton(
              child: const Text('둥근 버튼'),
              onPressed: onClick,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
            )
          ],
        ),
      )
    );
  }
}