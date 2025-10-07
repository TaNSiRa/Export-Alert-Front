// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison, avoid_web_libraries_in_flutter, unused_import, unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;
import '../../bloc/BlocEvent/01-01-P01INPUTDATA.dart';
import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';

import '../../mainBody.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../../widget/function/ShowDialog.dart';
import '../page2.dart';
import 'Function/api.dart';
import 'Function/buildColumn.dart';
import 'Function/exportExcel.dart';
import 'Function/showDialog.dart';
import 'P01INPUTDATAVAR.dart';

late BuildContext P01INPUTDATAcontext;
ScrollController _controllerIN01 = ScrollController();

class P01INPUTDATAMAIN extends StatefulWidget {
  P01INPUTDATAMAIN({
    super.key,
    this.data,
  });
  List<P01INPUTDATAGETDATAclass>? data;

  @override
  State<P01INPUTDATAMAIN> createState() => _P01INPUTDATAMAINState();
}

class _P01INPUTDATAMAINState extends State<P01INPUTDATAMAIN> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<P01INPUTDATAGETDATAclass> sortedData = [];

  @override
  void initState() {
    super.initState();
    context.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
    PageName = 'DATA TABLE';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    P01INPUTDATAcontext = context;
    List<P01INPUTDATAGETDATAclass> _datain = widget.data ?? [];
    List<P01INPUTDATAGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where((data) =>
          data.po_no.toLowerCase().contains(P01INPUTDATAVAR.search.toLowerCase()) ||
          data.custfull.toLowerCase().contains(P01INPUTDATAVAR.search.toLowerCase()) ||
          data.custshort.toLowerCase().contains(P01INPUTDATAVAR.search.toLowerCase())),
    );

    final dataSource = SampleDataSource(
      _datasearch,
      onNextPlan: (item) {
        if (item.status != 'Book shipment' || item.status != 'Confirm Bill of Loading (B/L)') {
          ConfirmationDialog.show(
            context,
            icon: Icons.next_plan_outlined,
            iconColor: Colors.blue,
            title: 'Next Plan',
            content: 'Did you next plan?',
            confirmText: 'Confirm',
            confirmButtonColor: Colors.blue,
            cancelText: 'Cancel',
            cancelButtonColor: Colors.blue,
            onConfirm: () async {
              updateItemStatus(item);
              updateStatusDue(item);
              P01INPUTDATAVAR.SendDataToAPI = item.toJson();
              // print(P01INPUTDATAVAR.SendDataToAPI);
              await nextPlan(context);
            },
          );
        } else {
          showN2Dialog(context, item);
        }
      },
      onEditCalendar: (item) {
        showN2Dialog(context, item, editAction: true);
      },
    );

    void sortData(int columnIndex, bool ascending) {
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
        final DateFormat formatter = DateFormat("dd-MM-yy");

        List<P01INPUTDATAGETDATAclass> dataToSort = _datasearch;

        switch (columnIndex) {
          case 1:
            dataToSort.sort((a, b) => ascending ? a.po_no.compareTo(b.po_no) : b.po_no.compareTo(a.po_no));
            break;
          case 2:
            dataToSort.sort(
                (a, b) => ascending ? a.custfull.compareTo(b.custfull) : b.custfull.compareTo(a.custfull));
            break;
          case 3:
            dataToSort.sort((a, b) =>
                ascending ? a.custshort.compareTo(b.custshort) : b.custshort.compareTo(a.custshort));
            break;
          case 4:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.receive_po_date);
                DateTime dateB = formatter.parse(b.receive_po_date);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.receive_po_date.compareTo(b.receive_po_date)
                    : b.receive_po_date.compareTo(a.receive_po_date);
              }
            });
            break;
          case 5:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.receive_booking);
                DateTime dateB = formatter.parse(b.receive_booking);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.receive_booking.compareTo(b.receive_booking)
                    : b.receive_booking.compareTo(a.receive_booking);
              }
            });
            break;
          case 6:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.loading_date);
                DateTime dateB = formatter.parse(b.loading_date);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.loading_date.compareTo(b.loading_date)
                    : b.loading_date.compareTo(a.loading_date);
              }
            });
            break;
          case 7:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.etd);
                DateTime dateB = formatter.parse(b.etd);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending ? a.etd.compareTo(b.etd) : b.etd.compareTo(a.etd);
              }
            });
            break;
          case 8:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.eta);
                DateTime dateB = formatter.parse(b.eta);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending ? a.eta.compareTo(b.eta) : b.eta.compareTo(a.eta);
              }
            });
            break;
          case 9:
            dataToSort.sort((a, b) => ascending
                ? a.shipment_type.compareTo(b.shipment_type)
                : b.shipment_type.compareTo(a.shipment_type));
            break;
          case 10:
            dataToSort
                .sort((a, b) => ascending ? a.status.compareTo(b.status) : b.status.compareTo(a.status));
            break;
          case 11:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.status_date);
                DateTime dateB = formatter.parse(b.status_date);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.status_date.compareTo(b.status_date)
                    : b.status_date.compareTo(a.status_date);
              }
            });
            break;
          case 12:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.status_due);
                DateTime dateB = formatter.parse(b.status_due);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.status_due.compareTo(b.status_due)
                    : b.status_due.compareTo(a.status_due);
              }
            });
            break;
          case 13:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.final_due);
                DateTime dateB = formatter.parse(b.final_due);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending ? a.final_due.compareTo(b.final_due) : b.final_due.compareTo(a.final_due);
              }
            });
            break;
          case 14:
            dataToSort.sort((a, b) =>
                ascending ? a.user_input.compareTo(b.user_input) : b.user_input.compareTo(a.user_input));
            break;
          case 15:
            dataToSort.sort((a, b) {
              try {
                DateTime dateA = formatter.parse(a.user_input_date);
                DateTime dateB = formatter.parse(b.user_input_date);
                return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              } catch (e) {
                return ascending
                    ? a.user_input_date.compareTo(b.user_input_date)
                    : b.user_input_date.compareTo(a.user_input_date);
              }
            });
            break;
        }

        sortedData = List.from(dataToSort);
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Theme(
          data: Theme.of(context).copyWith(
            cardTheme: const CardThemeData(color: Colors.white),
          ),
          child: SingleChildScrollView(
            controller: _controllerIN01,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ComInputTextTan(
                        sPlaceholder: "Search...",
                        isSideIcon: true,
                        height: 40,
                        width: 400,
                        isContr: P01INPUTDATAVAR.iscontrol,
                        fnContr: (input) {
                          P01INPUTDATAVAR.iscontrol = input;
                        },
                        sValue: P01INPUTDATAVAR.search,
                        returnfunc: (String s) {
                          P01INPUTDATAVAR.search = s;
                          Future.delayed(const Duration(seconds: 1), () {
                            if (P01INPUTDATAVAR.search == s) {
                              setState(() {
                                P01INPUTDATAVAR.search = s;
                              });
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            P01INPUTDATAVAR.isHoveredClear = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            P01INPUTDATAVAR.isHoveredClear = false;
                          });
                        },
                        child: InkWell(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            setState(() {
                              P01INPUTDATAVAR.isHoveredClear = false;
                              P01INPUTDATAVAR.iscontrol = true;
                              P01INPUTDATAVAR.search = '';
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: P01INPUTDATAVAR.isHoveredClear
                                    ? Colors.yellowAccent.shade700
                                    : Colors.redAccent.shade700,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: const [
                                      Colors.white,
                                      Colors.red,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: P01INPUTDATAVAR.isHoveredClear ? 15 : 17,
                                      end: P01INPUTDATAVAR.isHoveredClear ? 17 : 15,
                                    ),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, size, child) {
                                      return TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                          begin: P01INPUTDATAVAR.isHoveredClear
                                              ? Colors.redAccent.shade700
                                              : Colors.yellowAccent.shade700,
                                          end: P01INPUTDATAVAR.isHoveredClear
                                              ? Colors.yellowAccent.shade700
                                              : Colors.redAccent.shade700,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, color, child) {
                                          return Text(
                                            'CLEAR',
                                            style: TextStyle(
                                              fontSize: size,
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // setState(() {
                                //   P03DATATABLEVAR.CustomerIsPM = false;
                                // });
                                await getDropdown(P01INPUTDATAcontext);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'New PO',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Refresh',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PaginatedDataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                      columnSpacing: 16,
                      horizontalMargin: 12,
                      showCheckboxColumn: false,
                      rowsPerPage: P01INPUTDATAVAR.rowsPerPage,
                      availableRowsPerPage: const <int>[10, 15, 20],
                      onRowsPerPageChanged: (value) => setState(() {
                        P01INPUTDATAVAR.rowsPerPage = value ?? 20;
                      }),
                      dataRowHeight: 35,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: [
                        buildStyledColumn('No.'),
                        buildSortableColumn('PO No.', 1, sortData),
                        buildSortableColumn('Customer Name', 2, sortData),
                        buildSortableColumn('Short Name', 3, sortData),
                        buildSortableColumn('Receive PO', 4, sortData),
                        buildSortableColumn('Receive booking', 5, sortData),
                        buildSortableColumn('Loading Date', 6, sortData),
                        buildSortableColumn('ETD', 7, sortData),
                        buildSortableColumn('ETA', 8, sortData),
                        buildSortableColumn('Shipment Type', 9, sortData),
                        buildSortableColumn('Status', 10, sortData),
                        buildSortableColumn('Status Date', 11, sortData),
                        buildSortableColumn('Status Due', 12, sortData),
                        buildSortableColumn('Final Due', 13, sortData),
                        buildSortableColumn('User Input', 14, sortData),
                        buildSortableColumn('User Input Date', 15, sortData),
                        buildStyledColumn('Action')
                      ],
                      source: dataSource,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SampleDataSource extends DataTableSource {
  final List<P01INPUTDATAGETDATAclass> data;
  final void Function(P01INPUTDATAGETDATAclass) onNextPlan;
  final void Function(P01INPUTDATAGETDATAclass) onEditCalendar;

  SampleDataSource(this.data, {required this.onNextPlan, required this.onEditCalendar});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text(
        (index + 1).toString(),
        style: const TextStyle(fontSize: 12),
      )),
      DataCell(Text(item.po_no, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.custfull, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.custshort, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.receive_po_date, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.receive_booking, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.loading_date, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.etd, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.eta, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.shipment_type, style: const TextStyle(fontSize: 12))),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getStatusColor(item.status), // ฟังก์ชันกำหนดสีตาม status
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            item.status,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold, // ทำตัวหนา
              color: Colors.white, // ตัวอักษรสีขาว
            ),
          ),
        ),
      ),
      DataCell(Text(item.status_date, style: const TextStyle(fontSize: 12))),
      DataCell(
        Text(
          item.status_due,
          style: TextStyle(
            fontSize: 12,
            color: _isOverdue(item.status_due) ? Colors.red : Colors.black,
            fontWeight: _isOverdue(item.status_due) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      DataCell(Text(item.final_due, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.user_input, style: const TextStyle(fontSize: 12))),
      DataCell(Text(item.user_input_date, style: const TextStyle(fontSize: 12))),
      DataCell(
        Row(
          children: [
            if (item.status != 'Completed') ...[
              IconButton(
                icon: const Icon(Icons.next_plan_outlined, color: Colors.green),
                tooltip: "Next Plan",
                onPressed: () => onNextPlan(item),
              ),
              IconButton(
                icon: const Icon(Icons.edit_calendar, color: Colors.blue),
                tooltip: "Edit Calendar",
                onPressed: () => onEditCalendar(item),
              ),
            ],
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'Completed':
      return Colors.green;
    // case 'Pending':
    //   return Colors.orange;
    default:
      return Colors.blue;
  }
}

bool _isOverdue(String statusDue) {
  try {
    if (statusDue.isEmpty) return false;

    final parts = statusDue.split('-');
    if (parts.length != 3) return false;

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = 2000 + int.parse(parts[2]);

    final dueDate = DateTime(year, month, day);
    return DateTime.now().isAfter(dueDate);
  } catch (e) {
    return false;
  }
}
