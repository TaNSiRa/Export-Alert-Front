// // ignore_for_file: unused_local_variable, file_names

// import 'dart:io' as io;

// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
// import 'package:universal_html/html.dart' as html;

// import '../../../bloc/BlocEvent/01-01-P01INPUTDATA.dart';

// Future<void> exportToExcelKPI(List<P01INPUTDATAGETDATAclass> filteredData) async {
//   final workbook = xlsio.Workbook();
//   final sheet = workbook.worksheets[0];
//   sheet.name = 'MASTER KPI';

//   // ✅ Header
//   sheet.importList([
//     'No.',
//     'CustFull',
//     'CustShort',
//     'Group Name TS',
//     'Type',
//     'Group',
//     'MKT Group',
//     'Frequency',
//     'Report Items',
//   ], 1, 1, false);

//   // ✅ Style
//   final centerStyleHeader = workbook.styles.add('centerStyleHeader');
//   centerStyleHeader.hAlign = xlsio.HAlignType.center;
//   centerStyleHeader.vAlign = xlsio.VAlignType.center;
//   centerStyleHeader.bold = true;

//   final centerStyleData = workbook.styles.add('centerStyleData');
//   centerStyleData.hAlign = xlsio.HAlignType.center;
//   centerStyleData.vAlign = xlsio.VAlignType.center;

//   // ✅ Apply style to header row
//   final headerRange = sheet.getRangeByIndex(1, 1, 1, 9);
//   headerRange.cellStyle = centerStyleHeader;

//   // ✅ Fill data
//   int currentRow = 2;
//   for (var item in filteredData) {
//     sheet.getRangeByIndex(currentRow, 1).setText((currentRow - 1).toString());
//     sheet.getRangeByIndex(currentRow, 2).setText(item.CustFull);
//     sheet.getRangeByIndex(currentRow, 3).setText(item.CustShort);
//     sheet.getRangeByIndex(currentRow, 4).setText(item.Incharge);
//     sheet.getRangeByIndex(currentRow, 5).setText(item.TYPE);
//     sheet.getRangeByIndex(currentRow, 6).setText(item.GROUP);
//     sheet.getRangeByIndex(currentRow, 7).setText(item.MKTGROUP);
//     sheet.getRangeByIndex(currentRow, 8).setText(item.FRE);
//     sheet.getRangeByIndex(currentRow, 9).setText(item.REPORTITEMS);

//     // Apply style row data
//     final dataRange = sheet.getRangeByIndex(currentRow, 1, currentRow, 9);
//     dataRange.cellStyle = centerStyleData;

//     currentRow++;
//   }

//   // ✅ Save
//   final List<int> bytes = workbook.saveAsStream();
//   workbook.dispose();

//   final now = DateTime.now();
//   final dateStr =
//       '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}';
//   final fileName = 'MasterKPI_$dateStr.xlsx';

//   if (kIsWeb) {
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName)
//       ..click();
//     html.Url.revokeObjectUrl(url);
//   } else {
//     if (await Permission.storage.request().isGranted) {
//       final directory = await getExternalStorageDirectory();
//       final path = '${directory!.path}/$fileName';
//       final file = io.File(path);
//       await file.writeAsBytes(bytes, flush: true);
//     }
//   }
// }

// Future<void> exportToExcelTS(List<P01MASTERTSclass> filteredData) async {
//   final workbook = xlsio.Workbook();
//   final sheet = workbook.worksheets[0];
//   sheet.name = 'MASTER TS';

//   // ✅ Header
//   sheet.importList([
//     'No.',
//     'Id',
//     'CustId',
//     'CustFull',
//     'CustShort',
//     'Incharge',
//     'SampleNo',
//     'GroupNameTS',
//     'SampleGroup',
//     'SampleType',
//     'SampleTank',
//     'SampleName',
//     'ProcessReportName',
//     'ItemNo',
//     'ItemName',
//     'ItemReportName',
//     'StdFactor',
//     'StdMin',
//     'StdSymbol',
//     'StdMax',
//     'ControlRange',
//     'SubLeader',
//     'GL',
//     'JP',
//     'DGM',
//     'PatternReport',
//     'ReportOrder',
//     'TYPE',
//     'GROUP',
//     'MKTGROUP',
//     'FRE',
//     'REPORTITEMS',
//   ], 1, 1, false);

//   // ✅ Style
//   final centerStyleHeader = workbook.styles.add('centerStyleHeader');
//   centerStyleHeader.hAlign = xlsio.HAlignType.center;
//   centerStyleHeader.vAlign = xlsio.VAlignType.center;
//   centerStyleHeader.bold = true;

//   final centerStyleData = workbook.styles.add('centerStyleData');
//   centerStyleData.hAlign = xlsio.HAlignType.center;
//   centerStyleData.vAlign = xlsio.VAlignType.center;

//   // ✅ Apply style to header row (32 columns total)
//   final headerRange = sheet.getRangeByIndex(1, 1, 1, 32);
//   headerRange.cellStyle = centerStyleHeader;

//   // ✅ Fill data
//   int currentRow = 2;
//   for (var item in filteredData) {
//     sheet.getRangeByIndex(currentRow, 1).setText((currentRow - 1).toString());
//     sheet.getRangeByIndex(currentRow, 2).setText(item.Id);
//     sheet.getRangeByIndex(currentRow, 3).setText(item.CustId);
//     sheet.getRangeByIndex(currentRow, 4).setText(item.CustFull);
//     sheet.getRangeByIndex(currentRow, 5).setText(item.CustShort);
//     sheet.getRangeByIndex(currentRow, 6).setText(item.Incharge);
//     sheet.getRangeByIndex(currentRow, 7).setText(item.SampleNo);
//     sheet.getRangeByIndex(currentRow, 8).setText(item.GroupNameTS);
//     sheet.getRangeByIndex(currentRow, 9).setText(item.SampleGroup);
//     sheet.getRangeByIndex(currentRow, 10).setText(item.SampleType);
//     sheet.getRangeByIndex(currentRow, 11).setText(item.SampleTank);
//     sheet.getRangeByIndex(currentRow, 12).setText(item.SampleName);
//     sheet.getRangeByIndex(currentRow, 13).setText(item.ProcessReportName);
//     sheet.getRangeByIndex(currentRow, 14).setText(item.ItemNo);
//     sheet.getRangeByIndex(currentRow, 15).setText(item.ItemName);
//     sheet.getRangeByIndex(currentRow, 16).setText(item.ItemReportName);
//     sheet.getRangeByIndex(currentRow, 17).setText(item.StdFactor);
//     sheet.getRangeByIndex(currentRow, 18).setText(item.StdMin);
//     sheet.getRangeByIndex(currentRow, 19).setText(item.StdSymbol);
//     sheet.getRangeByIndex(currentRow, 20).setText(item.StdMax);
//     sheet.getRangeByIndex(currentRow, 21).setText(item.ControlRange);
//     sheet.getRangeByIndex(currentRow, 22).setText(item.SubLeader);
//     sheet.getRangeByIndex(currentRow, 23).setText(item.GL);
//     sheet.getRangeByIndex(currentRow, 24).setText(item.JP);
//     sheet.getRangeByIndex(currentRow, 25).setText(item.DGM);
//     sheet.getRangeByIndex(currentRow, 26).setText(item.PatternReport);
//     sheet.getRangeByIndex(currentRow, 27).setText(item.ReportOrder);
//     sheet.getRangeByIndex(currentRow, 28).setText(item.TYPE);
//     sheet.getRangeByIndex(currentRow, 29).setText(item.GROUP);
//     sheet.getRangeByIndex(currentRow, 30).setText(item.MKTGROUP);
//     sheet.getRangeByIndex(currentRow, 31).setText(item.FRE);
//     sheet.getRangeByIndex(currentRow, 32).setText(item.REPORTITEMS);

//     // Apply style to data row (32 columns)
//     final dataRange = sheet.getRangeByIndex(currentRow, 1, currentRow, 32);
//     dataRange.cellStyle = centerStyleData;

//     currentRow++;
//   }

//   // ✅ Save
//   final List<int> bytes = workbook.saveAsStream();
//   workbook.dispose();

//   final now = DateTime.now();
//   final dateStr =
//       '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}';
//   final fileName = 'MasterTS_$dateStr.xlsx';

//   if (kIsWeb) {
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName)
//       ..click();
//     html.Url.revokeObjectUrl(url);
//   } else {
//     if (await Permission.storage.request().isGranted) {
//       final directory = await getExternalStorageDirectory();
//       final path = '${directory!.path}/$fileName';
//       final file = io.File(path);
//       await file.writeAsBytes(bytes, flush: true);
//     }
//   }
// }

// Future<void> exportToExcelLab(List<P01MASTERLABclass> filteredData) async {
//   final workbook = xlsio.Workbook();
//   final sheet = workbook.worksheets[0];
//   sheet.name = 'MASTER LAB';

//   // ✅ Header
//   sheet.importList([
//     'No.',
//     'Id',
//     'CustId',
//     'CustFull',
//     'CustShort',
//     'Branch',
//     'Code',
//     'Incharge',
//     'FrequencyRequest',
//     'SampleNo',
//     'SampleGroup',
//     'SampleType',
//     'SampleTank',
//     'SampleName',
//     'SampleAmount',
//     'ProcessReportName',
//     'Frequency',
//     'ItemNo',
//     'InstrumentName',
//     'ItemName',
//     'ItemReportName',
//     'Position',
//     'Mag',
//     'Temp',
//     'StdMinL',
//     'StdMaxL',
//     'StdFactor',
//     'Std1',
//     'Std2',
//     'Std3',
//     'Std4',
//     'Std5',
//     'Std6',
//     'Std7',
//     'Std8',
//     'Std9',
//     'StdMin',
//     'StdSymbol',
//     'StdMax',
//     'ControlRange',
//     'ReportOrder',
//     'FactorC',
//   ], 1, 1, false);

//   // ✅ Style
//   final centerStyleHeader = workbook.styles.add('centerStyleHeader');
//   centerStyleHeader.hAlign = xlsio.HAlignType.center;
//   centerStyleHeader.vAlign = xlsio.VAlignType.center;
//   centerStyleHeader.bold = true;

//   final centerStyleData = workbook.styles.add('centerStyleData');
//   centerStyleData.hAlign = xlsio.HAlignType.center;
//   centerStyleData.vAlign = xlsio.VAlignType.center;

//   // ✅ Apply style to header row (42 columns total)
//   final headerRange = sheet.getRangeByIndex(1, 1, 1, 42);
//   headerRange.cellStyle = centerStyleHeader;

//   // ✅ Fill data
//   int currentRow = 2;
//   for (var item in filteredData) {
//     sheet.getRangeByIndex(currentRow, 1).setText((currentRow - 1).toString());
//     sheet.getRangeByIndex(currentRow, 2).setText(item.Id);
//     sheet.getRangeByIndex(currentRow, 3).setText(item.CustId);
//     sheet.getRangeByIndex(currentRow, 4).setText(item.CustFull);
//     sheet.getRangeByIndex(currentRow, 5).setText(item.CustShort);
//     sheet.getRangeByIndex(currentRow, 6).setText(item.Branch);
//     sheet.getRangeByIndex(currentRow, 7).setText(item.Code);
//     sheet.getRangeByIndex(currentRow, 8).setText(item.Incharge);
//     sheet.getRangeByIndex(currentRow, 9).setText(item.FrequencyRequest);
//     sheet.getRangeByIndex(currentRow, 10).setText(item.SampleNo);
//     sheet.getRangeByIndex(currentRow, 11).setText(item.SampleGroup);
//     sheet.getRangeByIndex(currentRow, 12).setText(item.SampleType);
//     sheet.getRangeByIndex(currentRow, 13).setText(item.SampleTank);
//     sheet.getRangeByIndex(currentRow, 14).setText(item.SampleName);
//     sheet.getRangeByIndex(currentRow, 15).setText(item.SampleAmount);
//     sheet.getRangeByIndex(currentRow, 16).setText(item.ProcessReportName);
//     sheet.getRangeByIndex(currentRow, 17).setText(item.Frequency);
//     sheet.getRangeByIndex(currentRow, 18).setText(item.ItemNo);
//     sheet.getRangeByIndex(currentRow, 19).setText(item.InstrumentName);
//     sheet.getRangeByIndex(currentRow, 20).setText(item.ItemName);
//     sheet.getRangeByIndex(currentRow, 21).setText(item.ItemReportName);
//     sheet.getRangeByIndex(currentRow, 22).setText(item.Position);
//     sheet.getRangeByIndex(currentRow, 23).setText(item.Mag);
//     sheet.getRangeByIndex(currentRow, 24).setText(item.Temp);
//     sheet.getRangeByIndex(currentRow, 25).setText(item.StdMinL);
//     sheet.getRangeByIndex(currentRow, 26).setText(item.StdMaxL);
//     sheet.getRangeByIndex(currentRow, 27).setText(item.StdFactor);
//     sheet.getRangeByIndex(currentRow, 28).setText(item.Std1);
//     sheet.getRangeByIndex(currentRow, 29).setText(item.Std2);
//     sheet.getRangeByIndex(currentRow, 30).setText(item.Std3);
//     sheet.getRangeByIndex(currentRow, 31).setText(item.Std4);
//     sheet.getRangeByIndex(currentRow, 32).setText(item.Std5);
//     sheet.getRangeByIndex(currentRow, 33).setText(item.Std6);
//     sheet.getRangeByIndex(currentRow, 34).setText(item.Std7);
//     sheet.getRangeByIndex(currentRow, 35).setText(item.Std8);
//     sheet.getRangeByIndex(currentRow, 36).setText(item.Std9);
//     sheet.getRangeByIndex(currentRow, 37).setText(item.StdMin);
//     sheet.getRangeByIndex(currentRow, 38).setText(item.StdSymbol);
//     sheet.getRangeByIndex(currentRow, 39).setText(item.StdMax);
//     sheet.getRangeByIndex(currentRow, 40).setText(item.ControlRange);
//     sheet.getRangeByIndex(currentRow, 41).setText(item.ReportOrder);
//     sheet.getRangeByIndex(currentRow, 42).setText(item.FactorC);

//     // Apply style to data row (42 columns)
//     final dataRange = sheet.getRangeByIndex(currentRow, 1, currentRow, 42);
//     dataRange.cellStyle = centerStyleData;

//     currentRow++;
//   }

//   // ✅ Save
//   final List<int> bytes = workbook.saveAsStream();
//   workbook.dispose();

//   final now = DateTime.now();
//   final dateStr =
//       '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}';
//   final fileName = 'MasterLab_$dateStr.xlsx';

//   if (kIsWeb) {
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName)
//       ..click();
//     html.Url.revokeObjectUrl(url);
//   } else {
//     if (await Permission.storage.request().isGranted) {
//       final directory = await getExternalStorageDirectory();
//       final path = '${directory!.path}/$fileName';
//       final file = io.File(path);
//       await file.writeAsBytes(bytes, flush: true);
//     }
//   }
// }
