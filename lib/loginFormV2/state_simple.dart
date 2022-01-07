import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  late String _email;

  void setEmail(String email) {
    _email = email;
  }

  String get email => _email;
}