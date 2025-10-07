// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, file_names, non_constant_identifier_names, must_be_immutable, camel_case_types, no_leading_underscores_for_local_identifiers, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/global.dart';
import '../cubit/NotificationEvent.dart';

//-------------------------------------------------

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> tokenSP;

abstract class LoginEvent {}

class LoginPage extends LoginEvent {}

class ReLogin extends LoginEvent {}

class Logout extends LoginEvent {}

class Login_Bloc extends Bloc<LoginEvent, String> {
  Login_Bloc() : super('') {
    on<LoginPage>((event, emit) {
      return _LoginPage_Function(state, emit);
    });
    on<ReLogin>((event, emit) {
      return _ReLogin_Function(state, emit);
    });
    on<Logout>((event, emit) {
      return _Logout_Function(state, emit);
    });
  }

  Future<void> _LoginPage_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    // token = (prefs.getString('token') ?? '');
    // token = 'test';
    // USERDATA.UserLV = 2;

    // tokenSP = prefs.setString("tokenSP", token).then((bool success) {
    //   return state;
    // });

    // if (token != '') {
    //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
    //       "Success", "Login OK", enumNotificationlist.Success);
    // } else {
    //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
    //       "user or password have some problem", enumNotificationlist.Error);
    // }
    final response = await Dio().post(
      "$ToServer/02EXPORTALERT/Login",
      data: {
        "user_name": logindata.userID,
        "password": logindata.userPASS,
      },
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      print(databuff);
      if (databuff['return'] == 'OK') {
        token =
            '{"id":"${databuff['user_name'].toString()}","name":"${databuff['name'].toString()}","roleid":"${databuff['roleid'].toString()}","section":"${databuff['section'].toString()}","branch":"${databuff['branch'].toString()}","permission":"${databuff['permission'].toString()}"}';
        USERDATA.ID = databuff['user_name'].toString();
        USERDATA.NAME = databuff['name'].toString();
        USERDATA.UserLV = int.parse(databuff['roleid'].toString());
        USERDATA.Section = databuff['section'].toString();
        USERDATA.Branch = databuff['branch'].toString();
        USERDATA.Permission = databuff['permission'].toString();
      } else {
        token = (prefs.getString('tokenSP') ?? '');
        USERDATA.UserLV = 0;
      }
    } else {
      token = (prefs.getString('tokenSP') ?? '');
      USERDATA.UserLV = 0;
    }

    tokenSP = prefs.setString("tokenSP", token).then((bool success) {
      return state;
    });

    if (token != '') {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Good to see you, ${USERDATA.NAME}!",
          "Let's check on your progress today.", enumNotificationlist.Success);
    } else {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Oops!",
          "The username or password you entered is incorrect. Please try again.", enumNotificationlist.Error);
    }

    emit(token);
  }

  Future<void> _ReLogin_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = (prefs.getString('tokenSP') ?? '');
    USERDATA.UserLV = 2;
    if (token != '') {
      // print(token);
      var databuff = jsonDecode(token);

      USERDATA.ID = databuff['ID'].toString();
      USERDATA.UserLV = int.parse(databuff['LV'].toString());
      USERDATA.NAME = databuff['NAME'].toString();
      USERDATA.Section = databuff['Section'].toString();
      USERDATA.Branch = databuff['Branch'].toString();
    } else {
      USERDATA.ID = '';
      USERDATA.UserLV = 0;
      USERDATA.NAME = '';
      USERDATA.Section = '';
      USERDATA.Branch = '';
    }
    emit(token);
  }

  Future<void> _Logout_Function(String toAdd, Emitter<String> emit) async {
    final SharedPreferences prefs = await _prefs;
    token = '';
    USERDATA.ID = '';
    USERDATA.UserLV = 0;
    USERDATA.NAME = '';
    USERDATA.Section = '';
    USERDATA.Branch = '';

    tokenSP = prefs.setString("tokenSP", token).then((bool success) {
      return state;
    });

    if (token == '') {
      BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
          "You have been logged out successfully.", "See you next time!", enumNotificationlist.Success);
    }

    emit('');
  }
}

// import 'dart:convert';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import '../../data/global.dart';

// import '../../data/global.dart';
// import '../cubit/NotificationEvent.dart';

// //-------------------------------------------------
// // String server = 'http://127.0.0.1:15000/';
// // String server = GLOserver;
// String server = 'http://172.23.10.40:16714/';

// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// late Future<String> tokenSP;

// abstract class LoginEvent {}

// class LoginPage extends LoginEvent {}

// class ReLogin extends LoginEvent {}

// class Logout extends LoginEvent {}

// class Login_Bloc extends Bloc<LoginEvent, String> {
//   Login_Bloc() : super('') {
//     on<LoginPage>((event, emit) {
//       return _LoginPage_Function(state, emit);
//     });
//     on<ReLogin>((event, emit) {
//       return _ReLogin_Function(state, emit);
//     });
//     on<Logout>((event, emit) {
//       return _Logout_Function(state, emit);
//     });
//   }

//   Future<void> _LoginPage_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     // token = (prefs.getString('token') ?? '');
//     final response = await Dio().post(
//       server + "login",
//       data: {
//         "ID": logindata.userID,
//         "PASS": logindata.userPASS,
//       },
//     );

//     if (response.statusCode == 200) {
//       var databuff = response.data;
//       if (databuff['return'] == 'OK') {
//         token =
//             '{"ID":"${databuff['ID'].toString()}","NAME":"${databuff['NAME'].toString()}","LV":"${databuff['LV'].toString()}","Section":"${databuff['Section'].toString()}","Def":"${databuff['Def'].toString()}"  ,"LOCATION":"${databuff['LOCATION'].toString()}"}';
//         USERDATA.ID = databuff['ID'].toString();
//         USERDATA.NAME = databuff['NAME'].toString();
//         USERDATA.UserLV = int.parse(databuff['LV'].toString());
//         USERDATA.Section = databuff['Section'].toString();
//         USERDATA.Def = databuff['Def'].toString();
//         USERDATA.LOCATION = databuff['LOCATION'].toString();
//         USERDATA.DefList =
//             USERDATA.Def.substring(1, USERDATA.Def.length - 1).split(',');
//         USERDATA.LOCATIONList = USERDATA.LOCATION
//             .substring(1, USERDATA.LOCATION.length - 1)
//             .replaceAll(" ", "")
//             .split(',');
//       } else {
//         token = (prefs.getString('tokenSP') ?? '');
//         USERDATA.UserLV = 0;
//       }
//     } else {
//       token = (prefs.getString('tokenSP') ?? '');
//       USERDATA.ID = '';
//       USERDATA.UserLV = 0;
//       USERDATA.NAME = '';
//       USERDATA.Section = '';
//       USERDATA.Def = '';
//       USERDATA.LOCATION = '';
//     }

//     tokenSP = prefs.setString("tokenSP", token).then((bool success) {
//       return state;
//     });

//     if (token != '') {
//       BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
//           "Success", "Login OK", enumNotificationlist.Success);
//     } else {
//       BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
//           "user or password have some problem", enumNotificationlist.Error);
//     }

//     // BlocProvider.of<Notification_Bloc>(contextGB)
//     //   .UpdateNotification("", "Login OK", enumNotificationlist.Success);

//     emit(token);
//   }

//   Future<void> _ReLogin_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     token = (prefs.getString('tokenSP') ?? '');

//     if (token != '') {
//       var databuff = jsonDecode(token);

//       // print(databuff['ID'].toString());
//       final response = await Dio().post(
//         server + "re_login",
//         data: {
//           "ID": databuff['ID'].toString(),
//           // "PASS": logindata.userPASS,
//         },
//       );
//       if (response.statusCode == 200) {
//         var databuff = response.data;
//         print(databuff);
//         if (databuff['return'] == 'OK') {
//           token =
//               '{"ID":"${databuff['ID'].toString()}","NAME":"${databuff['NAME'].toString()}","LV":"${databuff['LV'].toString()}","Section":"${databuff['Section'].toString()}","Def":"${databuff['Def'].toString()}"  ,"LOCATION":"${databuff['LOCATION'].toString()}"}';
//           USERDATA.ID = databuff['ID'].toString();
//           USERDATA.NAME = databuff['NAME'].toString();
//           USERDATA.UserLV = int.parse(databuff['LV'].toString());
//           USERDATA.Section = databuff['Section'].toString();
//           USERDATA.Def = databuff['Def'].toString();
//           USERDATA.LOCATION = databuff['LOCATION'].toString();
//           USERDATA.DefList =
//               USERDATA.Def.substring(1, USERDATA.Def.length - 1).split(',');
//           USERDATA.LOCATIONList = USERDATA.LOCATION
//               .substring(1, USERDATA.LOCATION.length - 1)
//               .replaceAll(" ", "")
//               .split(',');
//         } else {
//           token = (prefs.getString('tokenSP') ?? '');
//           USERDATA.UserLV = 0;
//         }
//       }

//       // USERDATA.ID = databuff['ID'].toString();
//       // USERDATA.UserLV = int.parse(databuff['LV'].toString());
//       // USERDATA.NAME = databuff['NAME'].toString();
//       // USERDATA.Section = databuff['Section'].toString();
//       // USERDATA.Def = databuff['Def'].toString();
//       // USERDATA.LOCATION = databuff['LOCATION'].toString();

//       // USERDATA.DefList =
//       //     USERDATA.Def.substring(1, USERDATA.Def.length - 1).split(',');
//       // USERDATA.LOCATIONList = USERDATA.LOCATION
//       //     .substring(1, USERDATA.LOCATION.length - 1)
//       //     .split(',');
//     } else {
//       USERDATA.ID = '';
//       USERDATA.UserLV = 0;
//       USERDATA.NAME = '';
//       USERDATA.Section = '';
//       USERDATA.Def = '';
//       USERDATA.LOCATION = '';
//       USERDATA.DefList = [];
//       USERDATA.LOCATIONList = [];
//     }

//     emit(token);
//   }

//   Future<void> _Logout_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     token = '';
//     USERDATA.UserLV = 0;
//     USERDATA.NAME = '';
//     serverGB = '';

//     tokenSP = prefs.setString("tokenSP", token).then((bool success) {
//       return state;
//     });

//     if (token == '') {
//       BlocProvider.of<BlocNotification>(contextGB)
//           .UpdateNotification("", "Logout", enumNotificationlist.Success);
//     }

//     emit('');
//   }
// }

// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../data/global.dart';
// import '../cubit/NotificationEvent.dart';

// //-------------------------------------------------

// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// late Future<String> tokenSP;

// abstract class LoginEvent {}

// class LoginPage extends LoginEvent {}

// class ReLogin extends LoginEvent {}

// class Logout extends LoginEvent {}

// class Login_Bloc extends Bloc<LoginEvent, String> {
//   Login_Bloc() : super('') {
//     on<LoginPage>((event, emit) {
//       return _LoginPage_Function(state, emit);
//     });
//     on<ReLogin>((event, emit) {
//       return _ReLogin_Function(state, emit);
//     });
//     on<Logout>((event, emit) {
//       return _Logout_Function(state, emit);
//     });
//   }

//   Future<void> _LoginPage_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     // token = (prefs.getString('token') ?? '');
//     // token = 'test';
//     // USERDATA.UserLV = 2;

//     // tokenSP = prefs.setString("tokenSP", token).then((bool success) {
//     //   return state;
//     // });

//     // if (token != '') {
//     //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
//     //       "Success", "Login OK", enumNotificationlist.Success);
//     // } else {
//     //   BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
//     //       "user or password have some problem", enumNotificationlist.Error);
//     // }
//     final response = await Dio().post(
//       serverG + "SAR/login",
//       data: {
//         "UserName": logindata.userID,
//         "Password": logindata.userPASS,
//       },
//     );

//     if (response.statusCode == 200) {
//       var databuff = response.data;
//       print(databuff);
//       if (databuff['return'] == 'OK') {
//         token =
//             '{"ID":"${databuff['UserName'].toString()}","NAME":"${databuff['NAME'].toString()}","LV":"${databuff['Roleid'].toString()}","Section":"${databuff['Section'].toString()}","Branch":"${databuff['Branch'].toString()}"}';
//         USERDATA.ID = databuff['UserName'].toString();
//         USERDATA.NAME = databuff['NAME'].toString();
//         USERDATA.UserLV = int.parse(databuff['Roleid'].toString());
//         USERDATA.Section = databuff['Section'].toString();
//         USERDATA.Branch = databuff['Branch'].toString();
//       } else {
//         token = (prefs.getString('tokenSP') ?? '');
//         USERDATA.UserLV = 0;
//       }
//     } else {
//       token = (prefs.getString('tokenSP') ?? '');
//       USERDATA.UserLV = 0;
//     }

//     tokenSP = prefs.setString("tokenSP", token).then((bool success) {
//       return state;
//     });

//     if (token != '') {
//       BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
//           "Success", "Login OK", enumNotificationlist.Success);
//     } else {
//       BlocProvider.of<BlocNotification>(contextGB).UpdateNotification("Error",
//           "user or password have some problem", enumNotificationlist.Error);
//     }

//     emit(token);
//   }

//   Future<void> _ReLogin_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     token = (prefs.getString('tokenSP') ?? '');
//     USERDATA.UserLV = 2;
//     if (token != '') {
//       print(token);
//       var databuff = jsonDecode(token);

//       USERDATA.ID = databuff['ID'].toString();
//       USERDATA.UserLV = int.parse(databuff['LV'].toString());
//       USERDATA.NAME = databuff['NAME'].toString();
//       USERDATA.Section = databuff['Section'].toString();
//       USERDATA.Branch = databuff['Branch'].toString();
//     } else {
//       USERDATA.ID = '';
//       USERDATA.UserLV = 0;
//       USERDATA.NAME = '';
//       USERDATA.Section = '';
//       USERDATA.Branch = '';
//     }
//     emit(token);
//   }

//   Future<void> _Logout_Function(String toAdd, Emitter<String> emit) async {
//     final SharedPreferences prefs = await _prefs;
//     token = '';
//     USERDATA.ID = '';
//     USERDATA.UserLV = 0;
//     USERDATA.NAME = '';
//     USERDATA.Section = '';
//     USERDATA.Branch = '';

//     tokenSP = prefs.setString("tokenSP", token).then((bool success) {
//       return state;
//     });

//     if (token == '') {
//       BlocProvider.of<BlocNotification>(contextGB)
//           .UpdateNotification("", "Logout", enumNotificationlist.Success);
//     }

//     emit('');
//   }
// }
