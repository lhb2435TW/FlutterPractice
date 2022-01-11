import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'login_form_demo_v2.dart';
import 'state_simple.dart';

class LoginPage extends StatefulWidget {

  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'your_name@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'input password');

  void _onLogin(BuildContext context) {
    final String email = _emailController.text;
    final SimpleState state = Provider.of<SimpleState>(context, listen: false);
    state.setEmail(email);

    Navigator.pushNamed(context, MAIN_PAGE);
  }

  void _onCancel() => exit(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 120),
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'heoro',
              child: CircleAvatar(
                child: Image.asset('assets/Lenna.png'),
                backgroundColor: Colors.transparent,
                radius: 58.0,
              )),
            const SizedBox(height: 45.0),
            TextFormField(
              key: const Key("email"),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _emailController,
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              key: const Key("password"),
              obscureText: true,
              decoration: const InputDecoration(border: const OutlineInputBorder()),
              controller: _passwordController,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  key: Key('login'),
                  child: const Text('로그인'),
                  onPressed: () => _onLogin(context)
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  child: const Text('취소'),
                  onPressed: _onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}