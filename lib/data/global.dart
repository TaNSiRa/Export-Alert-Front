import 'package:flutter/material.dart';
import '../page/page0.dart';

String token = '';
String selectpage = '';
Widget CuPage = const Page0();
int CuPageLV = 0;

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String ID = '';
  static String Section = '';
  static String Branch = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

String serverG = 'http://172.23.10.51:15152/';
