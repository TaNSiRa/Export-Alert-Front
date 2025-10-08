// // ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/global.dart';
// import '../../page/P03SUMMARYMAIL/P03SUMMARYMAILMAIN.dart';
// import '../../widget/common/ErrorPopup.dart';
// import '../../widget/function/FormatDateTime.dart';
// import '../../widget/function/SaveNull.dart';

// //-------------------------------------------------

// abstract class P03SUMMARYMAILGETDATA_Event {}

// class P03SUMMARYMAILGETDATA_GET extends P03SUMMARYMAILGETDATA_Event {}

// class P03SUMMARYMAILGETDATA_GET2 extends P03SUMMARYMAILGETDATA_Event {}

// class P03SUMMARYMAILGETDATA_GET3 extends P03SUMMARYMAILGETDATA_Event {}

// class P03SUMMARYMAILGETDATA_FLUSH extends P03SUMMARYMAILGETDATA_Event {}

// class P03SUMMARYMAILGETDATA_Bloc extends Bloc<P03SUMMARYMAILGETDATA_Event, List<P03SUMMARYMAILGETDATAclass>> {
//   P03SUMMARYMAILGETDATA_Bloc() : super([]) {
//     on<P03SUMMARYMAILGETDATA_GET>((event, emit) {
//       return _P03SUMMARYMAILGETDATA_GET([], emit);
//     });
// /*
//     on<P03SUMMARYMAILGETDATA_GET2>((event, emit) {
//       return _P03SUMMARYMAILGETDATA_GET2([], emit);
//     });
//     on<P03SUMMARYMAILGETDATA_GET3>((event, emit) {
//       return _P03SUMMARYMAILGETDATA_GET3([], emit);
//     });
//     on<P03SUMMARYMAILGETDATA_FLUSH>((event, emit) {
//       return _P03SUMMARYMAILGETDATA_FLUSH([], emit);
//     }); */
//   }

//   Future<void> _P03SUMMARYMAILGETDATA_GET(
//       List<P03SUMMARYMAILGETDATAclass> toAdd, Emitter<List<P03SUMMARYMAILGETDATAclass>> emit) async {
//     // FreeLoadingTan(P03SUMMARYMAILcontext);
//     List<P03SUMMARYMAILGETDATAclass> output = [];
//     //-------------------------------------------------------------------------------------
//     try {
//       final response = await Dio().post("$ToServer/03SENDMAIL/previewEmail", data: {}, options: dioOption);
//       var input = [];
//       if (response.statusCode == 200) {
//         var databuff = response.data;
//         input = databuff;
//         // print(input);
//         List<P03SUMMARYMAILGETDATAclass> outputdata = input.map((data) {
//           return P03SUMMARYMAILGETDATAclass(
//             id: savenull(data['id']),
//             po_no: savenull(data['po_no']),
//             customer_id: savenull(data['customer_id']),
//             custfull: savenull(data['custfull']),
//             custshort: savenull(data['custshort']),
//             mat_no: savenull(data['mat_no']),
//             mat_description: savenull(data['mat_description']),
//             mat_type: savenull(data['mat_type']),
//             mat_lead_time: savenull(data['mat_lead_time']),
//             quantity: savenull(data['quantity']),
//             uom: savenull(data['uom']),
//             eta: formatDate(data['eta'] ?? ''),
//             shipment_type: savenull(data['shipment_type']),
//             receive_po_date: formatDate(data['receive_po_date'] ?? ''),
//             sale_order: formatDate(data['sale_order'] ?? ''),
//             proforma: formatDate(data['proforma'] ?? ''),
//             book_shipment: formatDate(data['book_shipment'] ?? ''),
//             receive_booking: formatDate(data['receive_booking'] ?? ''),
//             receive_booking1: formatDate(data['receive_booking1'] ?? ''),
//             user_edit_booking1: savenull(data['user_edit_booking1']),
//             user_edit_booking_date1: formatDateTime(data['user_edit_booking_date1'] ?? ''),
//             receive_booking2: formatDate(data['receive_booking2'] ?? ''),
//             user_edit_booking2: savenull(data['user_edit_booking2']),
//             user_edit_booking_date2: formatDateTime(data['user_edit_booking_date2'] ?? ''),
//             receive_booking3: formatDate(data['receive_booking3'] ?? ''),
//             user_edit_booking3: savenull(data['user_edit_booking3']),
//             user_edit_booking_date3: formatDateTime(data['user_edit_booking_date3'] ?? ''),
//             acknowledgement: formatDate(data['acknowledgement'] ?? ''),
//             delivery_order: formatDate(data['delivery_order'] ?? ''),
//             loading_sheet: formatDate(data['loading_sheet'] ?? ''),
//             confirm_export_entry: formatDate(data['confirm_export_entry'] ?? ''),
//             loading_date: formatDate(data['loading_date'] ?? ''),
//             confirm_bill: formatDate(data['confirm_bill'] ?? ''),
//             etd: formatDate(data['etd'] ?? ''),
//             etd1: formatDate(data['etd1'] ?? ''),
//             user_edit_etd1: savenull(data['user_edit_etd1']),
//             user_edit_etd_date1: formatDateTime(data['user_edit_etd_date1'] ?? ''),
//             etd2: formatDate(data['etd2'] ?? ''),
//             user_edit_etd2: savenull(data['user_edit_etd2']),
//             user_edit_etd_date2: formatDateTime(data['user_edit_etd_date2'] ?? ''),
//             etd3: formatDate(data['etd3'] ?? ''),
//             user_edit_etd3: savenull(data['user_edit_etd3']),
//             user_edit_etd_date3: formatDateTime(data['user_edit_etd_date3'] ?? ''),
//             confirm_insurance: formatDate(data['confirm_insurance'] ?? ''),
//             post_and_qc: formatDate(data['post_and_qc'] ?? ''),
//             send_document: formatDate(data['send_document'] ?? ''),
//             issue_invoice: formatDate(data['issue_invoice'] ?? ''),
//             receive_shipping: formatDate(data['receive_shipping'] ?? ''),
//             status: savenull(data['status']),
//             status_date: formatDate(data['status_date'] ?? ''),
//             status_due: formatDate(data['status_due'] ?? ''),
//             final_due: formatDate(data['final_due'] ?? ''),
//             user_input: savenull(data['user_input']),
//             user_input_date: formatDateTime(data['user_input_date']),
//           );
//         }).toList();

//         // Navigator.pop(P01INPUTDATAcontext);

//         output = outputdata;
//         emit(output);
//       } else {
//         // Navigator.pop(P01INPUTDATAcontext);
//         showErrorPopup(P03SUMMARYMAILcontext, response.toString());
//         output = [];
//         emit(output);
//       }
//     } on DioException catch (e) {
//       // Navigator.pop(P01INPUTDATAcontext);
//       if (e.type == DioExceptionType.sendTimeout) {
//         showErrorPopup(P03SUMMARYMAILcontext, "Send timeout");
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         showErrorPopup(P03SUMMARYMAILcontext, "Receive timeout");
//       } else {
//         showErrorPopup(P03SUMMARYMAILcontext, e.message ?? "Unknown Dio error");
//       }
//     } catch (e) {
//       // Navigator.pop(P01INPUTDATAcontext);
//       showErrorPopup(P03SUMMARYMAILcontext, e.toString());
//     }
//   }
// }

// class P03SUMMARYMAILGETDATAclass {
//   P03SUMMARYMAILGETDATAclass({
//     this.id = '',
//     this.po_no = '',
//     this.customer_id = '',
//     this.custfull = '',
//     this.custshort = '',
//     this.mat_no = '',
//     this.mat_description = '',
//     this.mat_type = '',
//     this.mat_lead_time = '',
//     this.quantity = '',
//     this.uom = '',
//     this.eta = '',
//     this.shipment_type = '',
//     this.receive_po_date = '',
//     this.sale_order = '',
//     this.proforma = '',
//     this.book_shipment = '',
//     this.receive_booking = '',
//     this.receive_booking1 = '',
//     this.user_edit_booking1 = '',
//     this.user_edit_booking_date1 = '',
//     this.receive_booking2 = '',
//     this.user_edit_booking2 = '',
//     this.user_edit_booking_date2 = '',
//     this.receive_booking3 = '',
//     this.user_edit_booking3 = '',
//     this.user_edit_booking_date3 = '',
//     this.acknowledgement = '',
//     this.delivery_order = '',
//     this.loading_sheet = '',
//     this.confirm_export_entry = '',
//     this.loading_date = '',
//     this.confirm_bill = '',
//     this.etd = '',
//     this.etd1 = '',
//     this.user_edit_etd1 = '',
//     this.user_edit_etd_date1 = '',
//     this.etd2 = '',
//     this.user_edit_etd2 = '',
//     this.user_edit_etd_date2 = '',
//     this.etd3 = '',
//     this.user_edit_etd3 = '',
//     this.user_edit_etd_date3 = '',
//     this.confirm_insurance = '',
//     this.post_and_qc = '',
//     this.send_document = '',
//     this.issue_invoice = '',
//     this.receive_shipping = '',
//     this.status = '',
//     this.status_date = '',
//     this.status_due = '',
//     this.final_due = '',
//     this.user_input = '',
//     this.user_input_date = '',
//   });

//   String id;
//   String po_no;
//   String customer_id;
//   String custfull;
//   String custshort;
//   String mat_no;
//   String mat_description;
//   String mat_type;
//   String mat_lead_time;
//   String quantity;
//   String uom;
//   String eta;
//   String shipment_type;
//   String receive_po_date;
//   String sale_order;
//   String proforma;
//   String book_shipment;
//   String receive_booking;
//   String receive_booking1;
//   String user_edit_booking1;
//   String user_edit_booking_date1;
//   String receive_booking2;
//   String user_edit_booking2;
//   String user_edit_booking_date2;
//   String receive_booking3;
//   String user_edit_booking3;
//   String user_edit_booking_date3;
//   String acknowledgement;
//   String delivery_order;
//   String loading_sheet;
//   String confirm_export_entry;
//   String loading_date;
//   String confirm_bill;
//   String etd;
//   String etd1;
//   String user_edit_etd1;
//   String user_edit_etd_date1;
//   String etd2;
//   String user_edit_etd2;
//   String user_edit_etd_date2;
//   String etd3;
//   String user_edit_etd3;
//   String user_edit_etd_date3;
//   String confirm_insurance;
//   String post_and_qc;
//   String send_document;
//   String issue_invoice;
//   String receive_shipping;
//   String status;
//   String status_date;
//   String status_due;
//   String final_due;
//   String user_input;
//   String user_input_date;
// }
