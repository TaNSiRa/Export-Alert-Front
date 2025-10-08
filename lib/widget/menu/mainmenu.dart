// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, camel_case_types, must_be_immutable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/LoginEvent.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../page/P01INPUTDATA/P01INPUTDATAMAIN.dart';
import '../../page/page1.dart';
import '../../page/page10.dart';
import '../../page/page2.dart';
import '../../page/page3.dart';
import '../../page/page4.dart';
import '../../page/page5.dart';
import '../../page/page6.dart';
import '../../page/page7.dart';
import '../../page/page8.dart';
import '../../page/page9.dart';

late BuildContext MenuContext;

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    MenuContext = context;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color(0xFF1565C0),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: const Center(
        child: Data_Menu_mainmenu(),
      ),
    );
  }
}

class Data_Menu_mainmenu extends StatelessWidget {
  const Data_Menu_mainmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            height: 80,
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
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
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo_tpk.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontFamily: 'Mitr',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  USERDATA.NAME,
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    menu_normal(
                      name: "SUMMARY DATA",
                      page: const Page3(),
                      Lv: 1,
                      icon: Icons.bar_chart_rounded,
                    ),
                    menu_normal(
                      name: "SHIPMENT PROGRESS",
                      page: const Page2(),
                      Lv: 1,
                      icon: Icons.local_shipping_outlined,
                    ),
                    menu_normal(
                      name: "DATA TABLE",
                      page: const Page1(),
                      Lv: 1,
                      icon: Icons.table_chart_outlined,
                    ),

                    // menu_dropdown(
                    //   name: "CALENDAR",
                    //   icon: Icons.calendar_today,
                    //   items: [
                    //     DropdownMenuItem(
                    //       name: "CALENDAR INSTRUMENT",
                    //       page: const Page4(),
                    //       icon: Icons.calendar_today,
                    //     ),
                    //     DropdownMenuItem(
                    //       name: "CALENDAR JOB",
                    //       page: const Page5(),
                    //       icon: Icons.event_note,
                    //     ),
                    //   ],
                    // ),
                    // menu_dropdown(
                    //   name: "EDIT",
                    //   icon: Icons.edit,
                    //   items: [
                    //     DropdownMenuItem(
                    //       name: "EDIT CUSTOMER",
                    //       page: const Page6(),
                    //       icon: Icons.person_outline,
                    //     ),
                    //     DropdownMenuItem(
                    //       name: "EDIT REQUESTER",
                    //       page: const Page10(),
                    //       icon: Icons.person_3_outlined,
                    //     ),
                    //     if (USERDATA.UserLV >= 99 || USERDATA.Permission == 'Admin')
                    //       DropdownMenuItem(
                    //         name: "EDIT USER",
                    //         page: const Page8(),
                    //         icon: Icons.people_rounded,
                    //       ),
                    //   ],
                    // ),
                    menu_normal(
                      name: "CHANGE PASSWORD",
                      page: const Page7(),
                      Lv: 1,
                      icon: Icons.lock_reset,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: menu_logout(
              name: "Logout",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DropdownMenuItem {
  final String name;
  final Widget page;
  final IconData icon;

  DropdownMenuItem({
    required this.name,
    required this.page,
    required this.icon,
  });
}

class menu_dropdown extends StatefulWidget {
  menu_dropdown({
    super.key,
    this.name,
    this.icon,
    required this.items,
  });
  String? name;
  IconData? icon;
  List<DropdownMenuItem> items;

  @override
  _menu_dropdownState createState() => _menu_dropdownState();
}

class _menu_dropdownState extends State<menu_dropdown> {
  bool isHovered = false;
  OverlayEntry? _overlayEntry;

  void _showDropdown() {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = _createOverlayEntry(position);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Offset position) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 190,
        top: position.dy,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
            _hideDropdown();
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.map((item) {
                  return InkWell(
                    onTap: () {
                      _hideDropdown();
                      CuPageLV = 1;
                      MainBodyContext.read<ChangePage_Bloc>().ChangePage('', item.page);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1565C0).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              item.icon,
                              size: 16,
                              color: const Color(0xFF1565C0),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontFamily: 'Mitr',
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _name = widget.name ?? "";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
          _showDropdown();
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
          Future.delayed(const Duration(milliseconds: 0), () {
            if (!isHovered) {
              _hideDropdown();
            }
          });
        },
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isHovered ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon ?? Icons.chevron_right_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  _name,
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.6),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideDropdown();
    super.dispose();
  }
}

class menu_logout extends StatelessWidget {
  menu_logout({super.key, this.name});
  String? name;

  @override
  Widget build(BuildContext context) {
    String _name = name ?? "";

    return InkWell(
      onTap: () {
        LoginContext.read<Login_Bloc>().add(Logout());
        // timer?.cancel();
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                _name,
                style: const TextStyle(
                  fontFamily: 'Mitr',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class menu_normal extends StatelessWidget {
  menu_normal({
    super.key,
    this.name,
    this.icon,
    required this.page,
    required this.Lv,
  });
  String? name;
  Widget page;
  IconData? icon;
  int Lv;
  String? pagename;

  @override
  Widget build(BuildContext context) {
    String _name = name ?? "";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          CuPageLV = Lv;
          MainBodyContext.read<ChangePage_Bloc>().ChangePage(pagename ?? '', page);
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon ?? Icons.chevron_right_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  _name,
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
