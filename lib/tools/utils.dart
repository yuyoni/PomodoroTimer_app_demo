import 'package:flutter/material.dart';

import 'package:sprintf/sprintf.dart';
import 'package:fluttertoast/fluttertoast.dart';

//시간 표시를 위해 문자열 포맷팅함수 sprintf를 이용
String secondsToString(int seconds) {
  return sprintf("%02d:%02d", [seconds ~/ 60, seconds % 60]);
}

//Toast 띄우기 위한 함수
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
