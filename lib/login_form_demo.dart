import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(const RowColumnDemo());

class RowColumnDemo extends StatelessWidget {
  const RowColumnDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                keyboardType: TextInputType.emailAddress,
                initialValue: 'your_name@gmail.com',
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                initialValue: 'input password',
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ElevatedButton(
                    child: Text('Log In'),
                    onPressed: null,
                  ),
                  const SizedBox(width: 10.0,),
                  ElevatedButton(
                    child: const Text('Cancel'),
                      onPressed: () { exit(0); }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
