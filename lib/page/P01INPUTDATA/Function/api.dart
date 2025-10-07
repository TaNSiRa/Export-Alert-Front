// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/SuccessPopup.dart';

import '../../../bloc/BlocEvent/01-01-P01INPUTDATA.dart';
import '../../../data/global.dart';
import '../../../widget/common/ErrorPopup.dart';
import '../../../widget/common/Loading.dart';
import '../P01INPUTDATAMAIN.dart';
import '../P01INPUTDATAVAR.dart';
import 'showDialog.dart';

Future<void> addNewPO(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post("$ToServer/02EXPORTALERT/addNewPO",
        data: {
          "data": P01INPUTDATAVAR.SendDataToAPI,
        },
        options: dioOption);
    // Navigator.pop(context);
    Navigator.popUntil(context, (route) => route.isFirst);
    // print(response.data);
    if (response.statusCode == 200) {
      P01INPUTDATAcontext.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> nextPlan(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post("$ToServer/02EXPORTALERT/nextPlan",
        data: {
          "data": P01INPUTDATAVAR.SendDataToAPI,
        },
        options: dioOption);
    // Navigator.pop(context);
    Navigator.popUntil(context, (route) => route.isFirst);
    // print(response.data);
    if (response.statusCode == 200) {
      P01INPUTDATAcontext.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> updateN2(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post("$ToServer/02EXPORTALERT/updateN2",
        data: {
          "data": P01INPUTDATAVAR.SendDataToAPI,
        },
        options: dioOption);
    // Navigator.pop(context);
    Navigator.popUntil(context, (route) => route.isFirst);
    // print(response.data);
    if (response.statusCode == 200) {
      P01INPUTDATAcontext.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> updateEdit(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post("$ToServer/02EXPORTALERT/updateEdit",
        data: {
          "data": P01INPUTDATAVAR.SendDataToAPI,
          "stepAction": P01INPUTDATAVAR.stepAction,
        },
        options: dioOption);
    // Navigator.pop(context);
    Navigator.popUntil(context, (route) => route.isFirst);
    // print(response.data);
    if (response.statusCode == 200) {
      P01INPUTDATAcontext.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
      showSuccessPopup(context, '${response.data['message']}');
    } else {
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}

Future<void> getDropdown(BuildContext context) async {
  try {
    FreeLoadingTan(context);
    final response = await Dio().post("$ToServer/02EXPORTALERT/getDropdown", data: {}, options: dioOption);
    Navigator.pop(context);
    if (response.statusCode == 200) {
      P01INPUTDATAVAR.dropdownCustomer = List<String>.from(response.data['custshort'] ?? []);
      P01INPUTDATAVAR.dropdownMat = List<String>.from(response.data['material'] ?? []);
      showAddDialog(P01INPUTDATAcontext);
    } else {
      Navigator.pop(context);
      showErrorPopup(context, response.toString());
    }
  } catch (e) {
    print("Error: $e");
    showErrorPopup(context, e.toString());
  }
}
