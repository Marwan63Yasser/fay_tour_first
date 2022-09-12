import 'package:app4/LogInScreen.dart';
import 'package:app4/RegScreen.dart';
import 'package:flutter/material.dart';

class AUTH extends StatefulWidget {
  const AUTH({Key? key}) : super(key: key);

  @override
  State<AUTH> createState() => _AUTHState();
}

class _AUTHState extends State<AUTH> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
  ? LOG(onClickedSignUp: toggle)
  : reg(onClickedSignUp: toggle);

  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}