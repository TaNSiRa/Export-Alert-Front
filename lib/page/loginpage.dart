import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/LoginEvent.dart';
import '../mainBody.dart';
import '../data/global.dart';

class LoginPageWidget extends StatefulWidget {
  LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final FocusNode userFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/thaiparker.jpg"),
                fit: BoxFit.cover, // ให้ภาพเต็มพื้นที่
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6), // ไล่เฉดสีดำโปร่งใส
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Developed by Automation Version 1.0",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                width: 450,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo_tpk.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'EXPORT ALERT : LOGIN',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          focusNode: userFocusNode,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person, color: Colors.blue),
                            labelText: "User ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            logindata.userID = value;
                          },
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          focusNode: passwordFocusNode,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            logindata.userPASS = value;
                          },
                          onSubmitted: (value) {
                            LoginContext.read<Login_Bloc>().add(LoginPage());
                          },
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            LoginContext.read<Login_Bloc>().add(LoginPage());
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.blueAccent],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Sign IN",
                                style: TextStyle(
                                  fontFamily: 'Mitr',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// //--------------------------------------------- Bloc
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/BlocEvent/LoginEvent.dart';
// import '../bloc/cubit/Rebuild.dart';
// import '../mainBody.dart';
// import '../widget/common/ComInputText.dart';
// import '../data/global.dart';

// class LoginPageWidget extends StatelessWidget {
//   const LoginPageWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           height: 400,
//           width: 350,
//           child: SingleChildScrollView(
//               child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsetsDirectional.only(start: 50, end: 50),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Container(
//                     height: 100,
//                     // width: 300,
//                     decoration: const BoxDecoration(
//                       // color: Colors.red,
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/logo_tpk.png"),
//                         fit: BoxFit.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: ComInputText(
//                       height: 40,
//                       width: 240,
//                       isContr: logindata.isControl,
//                       fnContr: (input) {
//                         logindata.isControl = input;
//                       },
//                       sValue: logindata.userID,
//                       returnfunc: (String s) {
//                         logindata.userID = s;
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     // child: ComInputText(
//                     //   height: 40,
//                     //   width: 240,
//                     //   isPassword: true,
//                     //   isContr: logindata.isControl,
//                     //   fnContr: (input) {
//                     //     logindata.isControl = input;
//                     //   },
//                     //   sValue: logindata.userPASS,
//                     //   returnfunc: (String s) {
//                     //     logindata.userPASS = s;
//                     //   },
//                     // ),
//                     child: ComInputText(
//                       keyboardtype: TextInputType.visiblePassword,
//                       nLimitedChar: 50,
//                       width: 500,
//                       sPlaceholder: "Password",
//                       height: 40,
//                       isContr: logindata.isControl,
//                       fnContr: (input) {
//                         logindata.isControl = input;
//                       },
//                       sValue: logindata.userPASS,
//                       returnfunc: (String s) {
//                         logindata.userPASS = s;
//                       },
//                       isEnabled: true,
//                       isPassword: true,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const _LoginSignin(),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                 ],
//               ),
//             ),
//           )),
//         ),
//       ),
//     );
//   }
// }

// class _LoginSignin extends StatelessWidget {
//   const _LoginSignin({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           // BlocProvider.of<SwPageCubit>(context).togglePage("Page1");
//           LoginContext.read<Login_Bloc>().add(LoginPage());
//         },
//         child: Container(
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Align(
//             alignment: Alignment.center,
//             child: Text(
//               "Sign IN",
//               style: TextStyle(
//                 fontFamily: 'Mitr',
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w300,
//                 fontStyle: FontStyle.normal,
//                 letterSpacing: 0,
//               ),
//             ),
//           ),
//         ));
//   }
// }
