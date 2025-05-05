import 'package:flutter/material.dart';

class LoginPageController with ChangeNotifier {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  String get email => controllerEmail.text;
  String get password => controllerPassword.text;

  void setEmail(String value) {
    print(value);
    controllerEmail.text = value;
    notifyListeners();
  }

  void setPassword(String value) {
    print(value);
    controllerPassword.text = value;
    notifyListeners();
  }

  Future<void> login() async {
    // Aqui você faria o login com Firebase ou outro backend
    print('Logando com: ${controllerEmail.text} e ${controllerPassword.text}');
  }
}
