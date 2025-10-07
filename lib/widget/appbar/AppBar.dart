// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/LoginEvent.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../page/P01INPUTDATA/P01INPUTDATAMAIN.dart';
import '../../page/page1.dart';
// import 'package:tpk_login_arsa_01/script/bloc/login/login_bloc.dart';
// import 'package:tpk_login_arsa_01/script/bloc/login/login_event.dart';

//---------------------------------------------

String pageactive = '';

class App_Bar extends StatefulWidget {
  const App_Bar({super.key});

  @override
  _App_BarState createState() => _App_BarState();
}

class _App_BarState extends State<App_Bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      // color: Color(0xff0b1327),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Logo2(),
          if (PageName.contains('Master detail')) BackButton(),
          Logo1(),
          Spacer(),
          //Text(MediaQuery.of(context).size.width.toString()),
          //Text("  |  <--->  |  " + current_page.toString()),
          // const Spacer(),
          Pack_topright_bar(),
        ],
      ),
    );
  }

  ///###################################################################################
}

class Logo2 extends StatelessWidget {
  const Logo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.menu_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: InkWell(
        onTap: () {
          MainBodyContext.read<ChangePage_Bloc>().ChangePage_nodrower('', const Page1());
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

//============================================================
class Logo1 extends StatelessWidget {
  const Logo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        PageName,
        style: const TextStyle(
          fontFamily: 'Mitr',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class Pack_topright_bar extends StatelessWidget {
  const Pack_topright_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            USERDATA.NAME,
            style: const TextStyle(
              fontFamily: 'Mitr',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Time_(),
          const Icon_bell(),
          const LogoTPK(),
          // Icon_profile()
        ],
      ),
    );
  }
}

class Icon_bell extends StatelessWidget {
  const Icon_bell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 24,
      // height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Image.asset("assets/icons/icon-notifications.png"),
      ),
    );
  }
}

class Icon_profile extends StatelessWidget {
  const Icon_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LoginContext.read<Login_Bloc>().add(Logout());
        // timer?.cancel();
      },
      child: const Icon(
        Icons.logout,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}

class Time_ extends StatefulWidget {
  const Time_({super.key});

  @override
  _Time_State createState() => _Time_State();
}

class _Time_State extends State<Time_> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Center(
          child: Text(
            DateFormat(' hh:mm a').format(DateTime.now()),
            style: const TextStyle(
              fontFamily: 'Mitr',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        );
      },
    );
  }
}

class LogoTPK extends StatelessWidget {
  const LogoTPK({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 70,
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo_tpk.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
