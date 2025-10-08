// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String token = '';
String selectpage = '';
String selectstatus = '';
TextEditingController selectslot = TextEditingController();
TextEditingController StartDateControllerGlobal = TextEditingController();
TextEditingController StartDateController = TextEditingController();
DateTime StartDateToDateTimeGlobal = DateTime.now();
FocusNode StartDateFocusNodeGlobal = FocusNode();
// Widget CuPage = const Page0();
int CuPageLV = 0;
String masterType = '';
String CustShort = '';
List<String> dropDownIncharge = [];
List<String> dropDownGroupNameTS = [];
List<String> dropDownSampleGroup = [];
List<String> dropDownSampleType = [];

Options dioOption = Options(
  validateStatus: (status) {
    return true;
  },
  sendTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
);

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String Password = '';
  static String ID = '';
  static String Section = '';
  static String Branch = '';
  static String Permission = '';
  static String Email = '';
  static String Status = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

String PageName = '';
// String serverG = 'http://127.0.0.1:15152';
// String serverG = 'http://172.23.10.51:15152/';
// String ToServer = 'http://127.0.0.1:3400';
String ToServer = 'http://172.23.10.168:3400';
List<String> holidays = [];
