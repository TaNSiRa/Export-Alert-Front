// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/global.dart';
import '../../page/P01INPUTDATA/P01INPUTDATAMAIN.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/function/FormatDateTime.dart';
import '../../widget/function/SaveNull.dart';

//-------------------------------------------------

abstract class P01INPUTDATAGETDATA_Event {}

class P01INPUTDATAGETDATA_GET extends P01INPUTDATAGETDATA_Event {}

class P01INPUTDATAGETDATA_GET2 extends P01INPUTDATAGETDATA_Event {}

class P01INPUTDATAGETDATA_GET3 extends P01INPUTDATAGETDATA_Event {}

class P01INPUTDATAGETDATA_FLUSH extends P01INPUTDATAGETDATA_Event {}

class P01INPUTDATAGETDATA_Bloc extends Bloc<P01INPUTDATAGETDATA_Event, List<P01INPUTDATAGETDATAclass>> {
  P01INPUTDATAGETDATA_Bloc() : super([]) {
    on<P01INPUTDATAGETDATA_GET>((event, emit) {
      return _P01INPUTDATAGETDATA_GET([], emit);
    });

    on<P01INPUTDATAGETDATA_GET2>((event, emit) {
      return _P01INPUTDATAGETDATA_GET2([], emit);
    });
    on<P01INPUTDATAGETDATA_GET3>((event, emit) {
      return _P01INPUTDATAGETDATA_GET3([], emit);
    });
    on<P01INPUTDATAGETDATA_FLUSH>((event, emit) {
      return _P01INPUTDATAGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P01INPUTDATAGETDATA_GET(
      List<P01INPUTDATAGETDATAclass> toAdd, Emitter<List<P01INPUTDATAGETDATAclass>> emit) async {
    // FreeLoadingTan(P01INPUTDATAcontext);
    List<P01INPUTDATAGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    try {
      final response = await Dio().post("$ToServer/02EXPORTALERT/getDataTable", data: {}, options: dioOption);
      var input = [];
      if (response.statusCode == 200) {
        var databuff = response.data;
        input = databuff;
        // print(input);
        List<P01INPUTDATAGETDATAclass> outputdata = input.map((data) {
          return P01INPUTDATAGETDATAclass(
            id: savenull(data['id']),
            po_no: savenull(data['po_no']),
            customer_id: savenull(data['customer_id']),
            custfull: savenull(data['custfull']),
            custshort: savenull(data['custshort']),
            mat_no: savenull(data['mat_no']),
            mat_description: savenull(data['mat_description']),
            mat_type: savenull(data['mat_type']),
            mat_lead_time: savenull(data['mat_lead_time']),
            quantity: savenull(data['quantity']),
            uom: savenull(data['uom']),
            eta: formatDate(data['eta'] ?? ''),
            shipment_type: savenull(data['shipment_type']),
            receive_po_date: formatDate(data['receive_po_date'] ?? ''),
            sale_order: formatDate(data['sale_order'] ?? ''),
            proforma: formatDate(data['proforma'] ?? ''),
            book_shipment: formatDate(data['book_shipment'] ?? ''),
            receive_booking: formatDate(data['receive_booking'] ?? ''),
            receive_booking1: formatDate(data['receive_booking1'] ?? ''),
            user_edit_booking1: savenull(data['user_edit_booking1']),
            user_edit_booking_date1: formatDateTime(data['user_edit_booking_date1'] ?? ''),
            receive_booking2: formatDate(data['receive_booking2'] ?? ''),
            user_edit_booking2: savenull(data['user_edit_booking2']),
            user_edit_booking_date2: formatDateTime(data['user_edit_booking_date2'] ?? ''),
            receive_booking3: formatDate(data['receive_booking3'] ?? ''),
            user_edit_booking3: savenull(data['user_edit_booking3']),
            user_edit_booking_date3: formatDateTime(data['user_edit_booking_date3'] ?? ''),
            acknowledgement: formatDate(data['acknowledgement'] ?? ''),
            delivery_order: formatDate(data['delivery_order'] ?? ''),
            loading_sheet: formatDate(data['loading_sheet'] ?? ''),
            confirm_export_entry: formatDate(data['confirm_export_entry'] ?? ''),
            loading_date: formatDate(data['loading_date'] ?? ''),
            confirm_bill: formatDate(data['confirm_bill'] ?? ''),
            etd: formatDate(data['etd'] ?? ''),
            etd1: formatDate(data['etd1'] ?? ''),
            user_edit_etd1: savenull(data['user_edit_etd1']),
            user_edit_etd_date1: formatDateTime(data['user_edit_etd_date1'] ?? ''),
            etd2: formatDate(data['etd2'] ?? ''),
            user_edit_etd2: savenull(data['user_edit_etd2']),
            user_edit_etd_date2: formatDateTime(data['user_edit_etd_date2'] ?? ''),
            etd3: formatDate(data['etd3'] ?? ''),
            user_edit_etd3: savenull(data['user_edit_etd3']),
            user_edit_etd_date3: formatDateTime(data['user_edit_etd_date3'] ?? ''),
            confirm_insurance: formatDate(data['confirm_insurance'] ?? ''),
            post_and_qc: formatDate(data['post_and_qc'] ?? ''),
            send_document: formatDate(data['send_document'] ?? ''),
            issue_invoice: formatDate(data['issue_invoice'] ?? ''),
            receive_shipping: formatDate(data['receive_shipping'] ?? ''),
            status: savenull(data['status']),
            status_date: formatDate(data['status_date'] ?? ''),
            status_due: formatDate(data['status_due'] ?? ''),
            final_due: formatDate(data['final_due'] ?? ''),
            user_input: savenull(data['user_input']),
            user_input_date: formatDateTime(data['user_input_date']),
          );
        }).toList();

        // Navigator.pop(P01INPUTDATAcontext);

        output = outputdata;
        emit(output);
      } else {
        // Navigator.pop(P01INPUTDATAcontext);
        showErrorPopup(P01INPUTDATAcontext, response.toString());
        output = [];
        emit(output);
      }
    } on DioException catch (e) {
      // Navigator.pop(P01INPUTDATAcontext);
      if (e.type == DioExceptionType.sendTimeout) {
        showErrorPopup(P01INPUTDATAcontext, "Send timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showErrorPopup(P01INPUTDATAcontext, "Receive timeout");
      } else {
        showErrorPopup(P01INPUTDATAcontext, e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      // Navigator.pop(P01INPUTDATAcontext);
      showErrorPopup(P01INPUTDATAcontext, e.toString());
    }
  }

  Future<void> _P01INPUTDATAGETDATA_GET2(
      List<P01INPUTDATAGETDATAclass> toAdd, Emitter<List<P01INPUTDATAGETDATAclass>> emit) async {
    // FreeLoadingTan(P01INPUTDATAcontext);
    // List<P01INPUTDATAGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // final responseInstrument = await Dio().post(
    //   "$ToServer/02SALTSPRAY/InstrumentStatus",
    //   data: {},
    // );

    // if (responseInstrument.statusCode == 200) {
    //   print(responseInstrument.statusCode);
    //   var databuff = responseInstrument.data;
    //   P01INPUTDATAVAR.SST1Staus = databuff[0]['Status'];
    //   P01INPUTDATAVAR.SST2Staus = databuff[1]['Status'];
    //   P01INPUTDATAVAR.SST3Staus = databuff[2]['Status'];
    //   P01INPUTDATAVAR.SST4Staus = databuff[3]['Status'];
    //   // Navigator.pop(P01INPUTDATAcontext);
    // } else {
    //   // Navigator.pop(P01INPUTDATAcontext);
    //   showErrorPopup(P01INPUTDATAcontext, responseInstrument.toString());
    // }
  }

  Future<void> _P01INPUTDATAGETDATA_GET3(
      List<P01INPUTDATAGETDATAclass> toAdd, Emitter<List<P01INPUTDATAGETDATAclass>> emit) async {
    // List<P01INPUTDATAGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01INPUTDATAGETDATAclass> datadummy = [
    //   P01INPUTDATAGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01INPUTDATAGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01INPUTDATAGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01INPUTDATAGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01INPUTDATAGETDATA_FLUSH(
      List<P01INPUTDATAGETDATAclass> toAdd, Emitter<List<P01INPUTDATAGETDATAclass>> emit) async {
    List<P01INPUTDATAGETDATAclass> output = [];
    emit(output);
  }
}

class P01INPUTDATAGETDATAclass {
  P01INPUTDATAGETDATAclass({
    this.id = '',
    this.po_no = '',
    this.customer_id = '',
    this.custfull = '',
    this.custshort = '',
    this.mat_no = '',
    this.mat_description = '',
    this.mat_type = '',
    this.mat_lead_time = '',
    this.quantity = '',
    this.uom = '',
    this.eta = '',
    this.shipment_type = '',
    this.receive_po_date = '',
    this.sale_order = '',
    this.proforma = '',
    this.book_shipment = '',
    this.receive_booking = '',
    this.receive_booking1 = '',
    this.user_edit_booking1 = '',
    this.user_edit_booking_date1 = '',
    this.receive_booking2 = '',
    this.user_edit_booking2 = '',
    this.user_edit_booking_date2 = '',
    this.receive_booking3 = '',
    this.user_edit_booking3 = '',
    this.user_edit_booking_date3 = '',
    this.acknowledgement = '',
    this.delivery_order = '',
    this.loading_sheet = '',
    this.confirm_export_entry = '',
    this.loading_date = '',
    this.confirm_bill = '',
    this.etd = '',
    this.etd1 = '',
    this.user_edit_etd1 = '',
    this.user_edit_etd_date1 = '',
    this.etd2 = '',
    this.user_edit_etd2 = '',
    this.user_edit_etd_date2 = '',
    this.etd3 = '',
    this.user_edit_etd3 = '',
    this.user_edit_etd_date3 = '',
    this.confirm_insurance = '',
    this.post_and_qc = '',
    this.send_document = '',
    this.issue_invoice = '',
    this.receive_shipping = '',
    this.status = '',
    this.status_date = '',
    this.status_due = '',
    this.final_due = '',
    this.user_input = '',
    this.user_input_date = '',
  });

  String id;
  String po_no;
  String customer_id;
  String custfull;
  String custshort;
  String mat_no;
  String mat_description;
  String mat_type;
  String mat_lead_time;
  String quantity;
  String uom;
  String eta;
  String shipment_type;
  String receive_po_date;
  String sale_order;
  String proforma;
  String book_shipment;
  String receive_booking;
  String receive_booking1;
  String user_edit_booking1;
  String user_edit_booking_date1;
  String receive_booking2;
  String user_edit_booking2;
  String user_edit_booking_date2;
  String receive_booking3;
  String user_edit_booking3;
  String user_edit_booking_date3;
  String acknowledgement;
  String delivery_order;
  String loading_sheet;
  String confirm_export_entry;
  String loading_date;
  String confirm_bill;
  String etd;
  String etd1;
  String user_edit_etd1;
  String user_edit_etd_date1;
  String etd2;
  String user_edit_etd2;
  String user_edit_etd_date2;
  String etd3;
  String user_edit_etd3;
  String user_edit_etd_date3;
  String confirm_insurance;
  String post_and_qc;
  String send_document;
  String issue_invoice;
  String receive_shipping;
  String status;
  String status_date;
  String status_due;
  String final_due;
  String user_input;
  String user_input_date;
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'po_no': po_no,
      'customer_id': customer_id,
      'custfull': custfull,
      'custshort': custshort,
      'mat_no': mat_no,
      'mat_description': mat_description,
      'mat_type': mat_type,
      'mat_lead_time': mat_lead_time,
      'quantity': quantity,
      'uom': uom,
      'eta': eta,
      'shipment_type': shipment_type,
      'receive_po_date': receive_po_date,
      'sale_order': sale_order,
      'proforma': proforma,
      'book_shipment': book_shipment,
      'receive_booking': receive_booking,
      'receive_booking1': receive_booking1,
      'user_edit_booking1': user_edit_booking1,
      'user_edit_booking_date1': user_edit_booking_date1,
      'receive_booking2': receive_booking2,
      'user_edit_booking2': user_edit_booking2,
      'user_edit_booking_date2': user_edit_booking_date2,
      'receive_booking3': receive_booking3,
      'user_edit_booking3': user_edit_booking3,
      'user_edit_booking_date3': user_edit_booking_date3,
      'acknowledgement': acknowledgement,
      'delivery_order': delivery_order,
      'loading_sheet': loading_sheet,
      'confirm_export_entry': confirm_export_entry,
      'loading_date': loading_date,
      'confirm_bill': confirm_bill,
      'etd': etd,
      'etd1': etd1,
      'user_edit_etd1': user_edit_etd1,
      'user_edit_etd_date1': user_edit_etd_date1,
      'etd2': etd2,
      'user_edit_etd2': user_edit_etd2,
      'user_edit_etd_date2': user_edit_etd_date2,
      'etd3': etd3,
      'user_edit_etd3': user_edit_etd3,
      'user_edit_etd_date3': user_edit_etd_date3,
      'confirm_insurance': confirm_insurance,
      'post_and_qc': post_and_qc,
      'send_document': send_document,
      'issue_invoice': issue_invoice,
      'receive_shipping': receive_shipping,
      'status': status,
      'status_date': status_date,
      'status_due': status_due,
      'final_due': final_due,
      'user_input': user_input,
      'user_input_date': user_input_date
    };
  }

  factory P01INPUTDATAGETDATAclass.fromJson(Map<String, dynamic> json) {
    return P01INPUTDATAGETDATAclass(
      id: json['Id'] ?? '',
      po_no: json['po_no'] ?? '',
      customer_id: json['customer_id'] ?? '',
      custfull: json['custfull'] ?? '',
      custshort: json['custshort'] ?? '',
      mat_no: json['mat_no'] ?? '',
      mat_description: json['mat_description'] ?? '',
      mat_type: json['mat_type'] ?? '',
      mat_lead_time: json['mat_lead_time'] ?? '',
      quantity: json['quantity'] ?? '',
      uom: json['uom'] ?? '',
      eta: json['eta'] ?? '',
      shipment_type: json['shipment_type'] ?? '',
      receive_po_date: json['receive_po_date'] ?? '',
      sale_order: json['sale_order'] ?? '',
      proforma: json['proforma'] ?? '',
      book_shipment: json['book_shipment'] ?? '',
      receive_booking: json['receive_booking'] ?? '',
      receive_booking1: json['receive_booking1'] ?? '',
      user_edit_booking1: json['user_edit_booking1'] ?? '',
      user_edit_booking_date1: json['user_edit_booking_date1'] ?? '',
      receive_booking2: json['receive_booking2'] ?? '',
      user_edit_booking2: json['user_edit_booking2'] ?? '',
      user_edit_booking_date2: json['user_edit_booking_date2'] ?? '',
      receive_booking3: json['receive_booking3'] ?? '',
      user_edit_booking3: json['user_edit_booking3'] ?? '',
      user_edit_booking_date3: json['user_edit_booking_date3'] ?? '',
      acknowledgement: json['acknowledgement'] ?? '',
      delivery_order: json['delivery_order'] ?? '',
      loading_sheet: json['loading_sheet'] ?? '',
      confirm_export_entry: json['confirm_export_entry'] ?? '',
      loading_date: json['loading_date'] ?? '',
      confirm_bill: json['confirm_bill'] ?? '',
      etd: json['etd'] ?? '',
      etd1: json['etd1'] ?? '',
      user_edit_etd1: json['user_edit_etd1'] ?? '',
      user_edit_etd_date1: json['user_edit_etd_date1'] ?? '',
      etd2: json['etd2'] ?? '',
      user_edit_etd2: json['user_edit_etd2'] ?? '',
      user_edit_etd_date2: json['user_edit_etd_date2'] ?? '',
      etd3: json['etd3'] ?? '',
      user_edit_etd3: json['user_edit_etd3'] ?? '',
      user_edit_etd_date3: json['user_edit_etd_date3'] ?? '',
      confirm_insurance: json['confirm_insurance'] ?? '',
      post_and_qc: json['post_and_qc'] ?? '',
      send_document: json['send_document'] ?? '',
      issue_invoice: json['issue_invoice'] ?? '',
      receive_shipping: json['receive_shipping'] ?? '',
      status: json['status'] ?? '',
      status_date: json['status_date'] ?? '',
      status_due: json['status_due'] ?? '',
      final_due: json['final_due'] ?? '',
      user_input: json['user_input'] ?? '',
      user_input_date: json['user_input_date'] ?? '',
    );
  }
}

class StatusManager {
  static const Map<String, String> statusNext = {
    'Receive PO': 'Sale Order in SAP',
    'Sale Order in SAP': 'Proforma.INV+PL',
    'Proforma.INV+PL': 'Book shipment',
    'Book shipment': 'Receive booking confirmation',
    'Receive booking confirmation': 'Acknowledgement',
    'Acknowledgement': 'Delivery Order in SAP',
    'Delivery Order in SAP': 'Loading Sheet',
    'Loading Sheet': 'Confirm Export Entry',
    'Confirm Export Entry': 'Loading Date',
    'Loading Date': 'Confirm Bill of Loading (B/L)',
    'Confirm Bill of Loading (B/L)': 'ETD',
    'ETD': 'Confirm Insurance',
    'Confirm Insurance': 'Post goods issue & QC report',
    'Post goods issue & QC report': 'Send shipping document to customer',
    'Send shipping document to customer': 'Issue invoice for accounting',
    'Issue invoice for accounting': 'Receive shipping&forwarder billing',
    'Receive shipping&forwarder billing': 'Completed',
  };

  // เพิ่ม Map สำหรับ status_due
  static const Map<String, String> statusToDateColumn = {
    'Receive PO': 'receive_po_date',
    'Sale Order in SAP': 'sale_order',
    'Proforma.INV+PL': 'proforma',
    'Book shipment': 'book_shipment',
    'Receive booking confirmation': 'receive_booking',
    'Acknowledgement': 'acknowledgement',
    'Delivery Order in SAP': 'delivery_order',
    'Loading Sheet': 'loading_sheet',
    'Confirm Export Entry': 'confirm_export_entry',
    'Loading Date': 'loading_date',
    'Confirm Bill of Loading (B/L)': 'confirm_bill',
    'ETD': 'etd',
    'Confirm Insurance': 'confirm_insurance',
    'Post goods issue & QC report': 'post_and_qc',
    'Send shipping document to customer': 'send_document',
    'Issue invoice for accounting': 'issue_invoice',
    'Receive shipping&forwarder billing': 'receive_shipping',
  };

  static String? getNextStatus(String currentStatus) {
    return statusNext[currentStatus];
  }

  // ดึงชื่อ column ของวันที่ตาม status
  static String? getDateColumnName(String status) {
    return statusToDateColumn[status];
  }

  // ดึงค่าวันที่จาก item ตาม status
  static String? getStatusDueDate(P01INPUTDATAGETDATAclass item, String status) {
    String? columnName = getDateColumnName(status);
    if (columnName == null) return null;

    // ใช้ reflection หรือ switch case เพื่อดึงค่าจาก property
    switch (columnName) {
      case 'receive_po_date':
        return item.receive_po_date;
      case 'sale_order':
        return item.sale_order;
      case 'proforma':
        return item.proforma;
      case 'book_shipment':
        return item.book_shipment;
      case 'receive_booking':
        return item.receive_booking;
      case 'acknowledgement':
        return item.acknowledgement;
      case 'delivery_order':
        return item.delivery_order;
      case 'loading_sheet':
        return item.loading_sheet;
      case 'confirm_export_entry':
        return item.confirm_export_entry;
      case 'loading_date':
        return item.loading_date;
      case 'confirm_bill':
        return item.confirm_bill;
      case 'etd':
        return item.etd;
      case 'confirm_insurance':
        return item.confirm_insurance;
      case 'post_and_qc':
        return item.post_and_qc;
      case 'send_document':
        return item.send_document;
      case 'issue_invoice':
        return item.issue_invoice;
      case 'receive_shipping':
        return item.receive_shipping;
      default:
        return null;
    }
  }
}

// อัพเดท status และ status_due พร้อมกัน
void updateItemStatus(P01INPUTDATAGETDATAclass item) {
  String? nextStatus = StatusManager.getNextStatus(item.status);

  if (nextStatus != null) {
    item.status = nextStatus;

    // อัพเดท status_due ด้วย
    String? dueDate = StatusManager.getStatusDueDate(item, nextStatus);
    item.status_due = dueDate ?? '';
  }
}

// หรือถ้าต้องการแค่อัพเดท status_due โดยไม่เปลี่ยน status
void updateStatusDue(P01INPUTDATAGETDATAclass item) {
  String? dueDate = StatusManager.getStatusDueDate(item, item.status);
  item.status_due = dueDate ?? '';
}

class HistoryItem {
  final String value;
  final String editedBy;
  final String editedDate;
  final int version;

  HistoryItem({
    required this.value,
    required this.editedBy,
    required this.editedDate,
    required this.version,
  });
}
