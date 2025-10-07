// ignore_for_file: deprecated_member_use, avoid_print, file_names
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/01-01-P01INPUTDATA.dart';

import '../../../data/global.dart';
import '../../../widget/function/ShowDialog.dart';
import '../P01INPUTDATAMAIN.dart';
import '../P01INPUTDATAVAR.dart';
import 'api.dart';

final _formKey = GlobalKey<FormState>();

void showAddDialog(BuildContext context) {
  List<P01INPUTDATAGETDATAclass> data = [];
  data.add(P01INPUTDATAGETDATAclass());
  DateTime now = DateTime.now();
  String formattedDate =
      '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  data[0].receive_po_date = formattedDate;
  String oldLoadingDate = data[0].loading_date;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: 1200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        const Center(
                          child: Text(
                            'New PO',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 70,
                                    padding: const EdgeInsets.all(16),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'Input Data',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          const SizedBox(height: 10),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Receive Date",
                                            icon: Icons.calendar_month_rounded,
                                            value: data[0].receive_po_date,
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Customer Name",
                                            icon: Icons.people,
                                            value: data[0].custfull,
                                            dropdownItems: P01INPUTDATAVAR.dropdownCustomer,
                                            onChanged: (value) {
                                              setState(() {
                                                final parts = value.split('||');
                                                data[0].custfull = parts[0].trim();
                                                data[0].custshort = parts[1].trim();
                                                data[0].customer_id = parts[2].trim();
                                              });
                                            },
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Customer No.",
                                            icon: Icons.pin_rounded,
                                            value: data[0].customer_id,
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "PO no.",
                                            icon: Icons.assignment,
                                            value: data[0].po_no,
                                            onChanged: (value) {
                                              data[0].po_no = value;
                                            },
                                          ),
                                          Visibility(
                                            visible: data[0].mat_description.isNotEmpty,
                                            child: buildCustomField(
                                              context: context,
                                              labelText: "Estimate Loading date",
                                              icon: Icons.calendar_month_rounded,
                                              value: data[0].loading_date,
                                              loadingDate: oldLoadingDate,
                                              onChanged: (value) {
                                                data[0].loading_date = value;
                                              },
                                              onStateChanged: () => setState(() {}),
                                            ),
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Require ETD",
                                            icon: Icons.calendar_month_rounded,
                                            value: data[0].etd,
                                            onChanged: (value) {
                                              data[0].etd = value;
                                            },
                                            onStateChanged: () => setState(() {}),
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Require ETA",
                                            icon: Icons.calendar_month_rounded,
                                            value: data[0].eta,
                                            onChanged: (value) {
                                              data[0].eta = value;
                                            },
                                            onStateChanged: () => setState(() {}),
                                          ),
                                          buildCustomField(
                                            context: context,
                                            labelText: "Shipment type",
                                            icon: Icons.airplanemode_active_rounded,
                                            value: data[0].shipment_type,
                                            dropdownItems: P01INPUTDATAVAR.dropdownShipment,
                                            onChanged: (value) {
                                              data[0].shipment_type = value;
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  ConfirmationDialog.show(
                                                    context,
                                                    icon: Icons.assignment,
                                                    iconColor: Colors.blue,
                                                    title: 'Add new PO',
                                                    content: 'Did you add new PO?',
                                                    confirmText: 'Confirm',
                                                    confirmButtonColor: Colors.blue,
                                                    cancelText: 'Cancel',
                                                    cancelButtonColor: Colors.blue,
                                                    onConfirm: () async {
                                                      // ส่งทั้ง data หลักและ data
                                                      for (var i = 0; i < data.length; i++) {
                                                        data[i].receive_po_date = data[0].receive_po_date;
                                                        data[i].custfull = data[0].custfull;
                                                        data[i].custshort = data[0].custshort;
                                                        data[i].customer_id = data[0].customer_id;
                                                        data[i].po_no = data[0].po_no;
                                                        data[i].loading_date = data[0].loading_date;
                                                        data[i].etd = data[0].etd;
                                                        data[i].eta = data[0].eta;
                                                        data[i].shipment_type = data[0].shipment_type;
                                                        data[i].sale_order = formatDateToDMY(
                                                            addBusinessDays(data[0].receive_po_date, 3));
                                                        data[i].proforma = calculateDateByShipment(
                                                            data[0].receive_po_date, data[0].shipment_type,
                                                            isProforma: true);
                                                        data[i].book_shipment = calculateDateByShipment(
                                                            data[0].receive_po_date, data[0].shipment_type,
                                                            isProforma: false);
                                                        data[i].final_due = data[0].loading_date;
                                                        data[i].user_input = USERDATA.NAME;
                                                      }
                                                      P01INPUTDATAVAR.SendDataToAPI =
                                                          data.map((item) => item.toJson()).toList();
                                                      // print(P01INPUTDATAVAR.SendDataToAPI);
                                                      await addNewPO(context);
                                                    },
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.green,
                                                shadowColor: Colors.greenAccent,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  side: const BorderSide(color: Colors.green, width: 2),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                spacing: 5,
                                                children: [
                                                  Text(
                                                    'Add New PO',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.add_alert_rounded,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Right side - Material Table
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  // Header
                                  Container(
                                    height: 70,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Material Items',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              data.add(P01INPUTDATAGETDATAclass());
                                            });
                                          },
                                          icon: const Icon(Icons.add, size: 18),
                                          label: const Text('Add Material'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Table
                                  Expanded(
                                    child: data.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No materials added yet',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: DataTable(
                                                columnSpacing: 20,
                                                headingRowColor: MaterialStateProperty.all(
                                                  Colors.grey.shade100,
                                                ),
                                                columns: const [
                                                  DataColumn(
                                                    label: Text(
                                                      'Material Description',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Material No.',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Quantity',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'UOM',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Action',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                                rows: List.generate(
                                                  data.length,
                                                  (index) {
                                                    final item = data[index];
                                                    return DataRow(
                                                      cells: [
                                                        DataCell(
                                                          DropdownSearch<String>(
                                                            key: Key("mat_${index}_${item.mat_description}"),
                                                            items: P01INPUTDATAVAR.dropdownMat,
                                                            selectedItem: item.mat_description,
                                                            dropdownDecoratorProps:
                                                                const DropDownDecoratorProps(
                                                              dropdownSearchDecoration: InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    horizontal: 8, vertical: 8),
                                                                border: OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            popupProps: PopupProps.menu(
                                                              showSearchBox: true,
                                                              searchFieldProps: TextFieldProps(
                                                                decoration: InputDecoration(
                                                                  hintText: 'Search...',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10)),
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                ),
                                                              ),
                                                              menuProps: const MenuProps(
                                                                backgroundColor: Colors.white,
                                                              ),
                                                            ),
                                                            dropdownBuilder: (context, selectedItem) {
                                                              return Text(
                                                                selectedItem != null
                                                                    ? selectedItem.split('||')[0].trim()
                                                                    : '',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(fontSize: 14),
                                                              );
                                                            },
                                                            onChanged: (value) {
                                                              if (value != null) {
                                                                setState(() {
                                                                  final parts = value.split('||');
                                                                  item.mat_description = parts[0].trim();
                                                                  item.mat_no =
                                                                      parts.length > 1 ? parts[1].trim() : '';
                                                                  item.mat_lead_time =
                                                                      parts.length > 2 ? parts[2].trim() : '';

                                                                  int maxLeadTime = data
                                                                      .map((e) =>
                                                                          int.tryParse(e.mat_lead_time) ?? 0)
                                                                      .fold(
                                                                          0,
                                                                          (prev, next) =>
                                                                              next > prev ? next : prev);

                                                                  if (data[0].receive_po_date.isNotEmpty) {
                                                                    DateTime? newLoadingDate =
                                                                        addBusinessDays(
                                                                            data[0].receive_po_date,
                                                                            maxLeadTime);
                                                                    data[0].loading_date =
                                                                        formatDateToDMY(newLoadingDate!);
                                                                    oldLoadingDate =
                                                                        formatDateToDMY(newLoadingDate);
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            validator: (value) {
                                                              if (value == null || value.isEmpty) {
                                                                return 'Please select material';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        DataCell(Text(item.mat_no)),
                                                        DataCell(
                                                          SizedBox(
                                                            width: 80,
                                                            child: TextFormField(
                                                              initialValue: item.quantity,
                                                              keyboardType: TextInputType.number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                              ],
                                                              decoration: const InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    horizontal: 8, vertical: 8),
                                                              ),
                                                              onChanged: (value) {
                                                                item.quantity = value;
                                                              },
                                                              validator: (value) {
                                                                if (value == null || value.isEmpty) {
                                                                  return 'Please fill quantity';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          DropdownSearch<String>(
                                                            key: Key("uom_${index}_${item.uom}"),
                                                            items: P01INPUTDATAVAR.dropdownUOM,
                                                            selectedItem: item.uom.isEmpty ? null : item.uom,
                                                            dropdownDecoratorProps:
                                                                const DropDownDecoratorProps(
                                                              dropdownSearchDecoration: InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    horizontal: 8, vertical: 8),
                                                                border: OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            popupProps: PopupProps.menu(
                                                              showSearchBox: true,
                                                              searchFieldProps: TextFieldProps(
                                                                decoration: InputDecoration(
                                                                  hintText: 'Search...',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10)),
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                ),
                                                              ),
                                                              menuProps: const MenuProps(
                                                                backgroundColor: Colors.white,
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              if (value != null) {
                                                                setState(() {
                                                                  item.uom = value;
                                                                });
                                                              }
                                                            },
                                                            validator: (value) {
                                                              if (value == null || value.isEmpty) {
                                                                return 'Please select UOM';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Visibility(
                                                            visible: data.length > 1,
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons.delete_forever_rounded,
                                                                color: Colors.red,
                                                                size: 20,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  for (var i = 0; i < data.length; i++) {
                                                                    data[i].receive_po_date =
                                                                        data[0].receive_po_date;
                                                                    data[i].custfull = data[0].custfull;
                                                                    data[i].custshort = data[0].custshort;
                                                                    data[i].customer_id = data[0].customer_id;
                                                                    data[i].po_no = data[0].po_no;
                                                                    data[i].loading_date =
                                                                        data[0].loading_date;
                                                                    data[i].etd = data[0].etd;
                                                                    data[i].eta = data[0].eta;
                                                                    data[i].shipment_type =
                                                                        data[0].shipment_type;
                                                                  }
                                                                  data.removeAt(index);
                                                                  int maxLeadTime = data
                                                                      .map((e) =>
                                                                          int.tryParse(e.mat_lead_time) ?? 0)
                                                                      .fold(
                                                                          0,
                                                                          (prev, next) =>
                                                                              next > prev ? next : prev);

                                                                  if (data[0].receive_po_date.isNotEmpty) {
                                                                    DateTime? newLoadingDate =
                                                                        addBusinessDays(
                                                                            data[0].receive_po_date,
                                                                            maxLeadTime);

                                                                    data[0].loading_date =
                                                                        formatDateToDMY(newLoadingDate!);
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void showN2Dialog(BuildContext context, P01INPUTDATAGETDATAclass originalData, {bool? editAction}) {
  final data = P01INPUTDATAGETDATAclass.fromJson(originalData.toJson());
  String loadingDate = data.loading_date;
  String etd = data.etd;
  P01INPUTDATAVAR.stepAction = [];

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      const Center(
                        child: Text(
                          'Shipment Progress Road Map',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            data.receive_booking = '';
                            data.acknowledgement = '';
                            data.delivery_order = '';
                            data.loading_sheet = '';
                            data.confirm_export_entry = '';
                            data.loading_date = loadingDate;
                            data.confirm_bill = '';
                            data.etd = etd;
                            data.confirm_insurance = '';
                            data.post_and_qc = '';
                            data.send_document = '';
                            data.issue_invoice = '';
                            data.receive_shipping = '';

                            P01INPUTDATAcontext.read<P01INPUTDATAGETDATA_Bloc>()
                                .add(P01INPUTDATAGETDATA_GET());
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // PO Number
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.receipt_long,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PO Number',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.po_no,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Divider
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.blue.shade300,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                          ),

                          // Customer
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.business,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 600),
                                    child: Text(
                                      data.custfull,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Row 1: ซ้าย -> ขวา
                          _buildRoadMapRow(
                            context,
                            data,
                            setState,
                            isLeftToRight: true,
                            steps: [
                              RoadMapStep(
                                number: 1,
                                title: 'Receive PO',
                                date: data.receive_po_date,
                                icon: Icons.shopping_cart,
                                color: Colors.green,
                                isCompleted: data.receive_po_date.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 2,
                                title: 'Sale Order',
                                date: data.sale_order,
                                icon: Icons.description,
                                color: Colors.blue,
                                isCompleted: data.sale_order.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 3,
                                title: 'Proforma',
                                date: data.proforma,
                                icon: Icons.receipt_long,
                                color: Colors.orange,
                                isCompleted: data.proforma.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 4,
                                title: 'Book Shipment',
                                date: data.book_shipment,
                                icon: Icons.book_online,
                                color: Colors.purple,
                                isCompleted: data.book_shipment.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 5,
                                title: 'Receive Booking',
                                date: data.receive_booking,
                                icon: Icons.calendar_today,
                                color: Colors.cyan,
                                isCompleted: data.receive_booking.isNotEmpty,
                                isEditable: data.status == 'Book shipment' || editAction!,
                                onTap: () {
                                  _showDatePicker(context, setState, (value) {
                                    data.receive_booking = value;
                                    data.acknowledgement = formatDateToDMY(addBusinessDays(value, 2));
                                    data.delivery_order = formatDateToDMY(addBusinessDays(value, 5));
                                    data.loading_sheet = formatDateToDMY(addBusinessDays(value, 6));
                                    data.confirm_export_entry = formatDateToDMY(addBusinessDays(value, 7));
                                    data.loading_date = formatDateToDMY(addBusinessDays(value, 11));
                                    data.confirm_bill = formatDateToDMY(addBusinessDays(value, 12));
                                    data.etd = formatDateToDMY(addBusinessDays(value, 15));
                                    data.confirm_insurance = formatDateToDMY(addBusinessDays(value, 16));
                                    data.post_and_qc = formatDateToDMY(addBusinessDays(value, 17));
                                    data.send_document = formatDateToDMY(addBusinessDays(value, 18));
                                    data.issue_invoice = formatDateToDMY(addBusinessDays(value, 20));
                                    data.receive_shipping = formatDateToDMY(addBusinessDays(value, 22));
                                    if (data.receive_booking1 == data.receive_booking ||
                                        data.receive_booking2 == data.receive_booking ||
                                        data.receive_booking3 == data.receive_booking) {
                                      P01INPUTDATAVAR.stepAction.remove('Receive Booking');
                                    } else if (!P01INPUTDATAVAR.stepAction.contains('Receive Booking')) {
                                      P01INPUTDATAVAR.stepAction.add('Receive Booking');
                                    }
                                    // print(P01INPUTDATAVAR.stepAction);
                                  });
                                },
                              ),
                              RoadMapStep(
                                number: 6,
                                title: 'Acknowledgement',
                                date: data.acknowledgement,
                                icon: Icons.check_circle,
                                color: Colors.teal,
                                isCompleted: data.acknowledgement.isNotEmpty,
                                isEditable: false,
                                showDownArrow: true,
                              ),
                            ],
                          ),
                          // Row 2: ขวา -> ซ้าย
                          _buildRoadMapRow(
                            context,
                            data,
                            setState,
                            isLeftToRight: false,
                            steps: [
                              RoadMapStep(
                                number: 7,
                                title: 'Delivery Order',
                                date: data.delivery_order,
                                icon: Icons.local_shipping,
                                color: Colors.indigo,
                                isCompleted: data.delivery_order.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 8,
                                title: 'Loading Sheet',
                                date: data.loading_sheet,
                                icon: Icons.assignment,
                                color: Colors.brown,
                                isCompleted: data.loading_sheet.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 9,
                                title: 'Export Entry',
                                date: data.confirm_export_entry,
                                icon: Icons.flight_takeoff,
                                color: Colors.deepOrange,
                                isCompleted: data.confirm_export_entry.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 10,
                                title: 'Loading Date',
                                date: data.loading_date,
                                icon: Icons.local_shipping,
                                color: Colors.pink,
                                isCompleted: data.loading_date.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 11,
                                title: 'Bill of Loading',
                                date: data.confirm_bill,
                                icon: Icons.description,
                                color: Colors.lime,
                                isCompleted: data.confirm_bill.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 12,
                                title: 'ETD',
                                date: data.etd,
                                icon: Icons.flight,
                                color: Colors.red,
                                isCompleted: data.etd.isNotEmpty,
                                isEditable: data.status == 'Confirm Bill of Loading (B/L)' || editAction!,
                                showDownArrow: true,
                                onTap: () {
                                  _showDatePicker(context, setState, (value) {
                                    data.etd = value;
                                    data.confirm_insurance = formatDateToDMY(addBusinessDays(value, 1));
                                    data.post_and_qc = formatDateToDMY(addBusinessDays(value, 2));
                                    data.send_document = formatDateToDMY(addBusinessDays(value, 3));
                                    data.issue_invoice = formatDateToDMY(addBusinessDays(value, 5));
                                    data.receive_shipping = formatDateToDMY(addBusinessDays(value, 7));
                                    if (data.etd1 == data.etd ||
                                        data.etd2 == data.etd ||
                                        data.etd3 == data.etd) {
                                      P01INPUTDATAVAR.stepAction.remove('ETD');
                                    } else if (!P01INPUTDATAVAR.stepAction.contains('ETD')) {
                                      P01INPUTDATAVAR.stepAction.add('ETD');
                                    }
                                    // print(P01INPUTDATAVAR.stepAction);
                                  });
                                },
                              ),
                            ],
                          ),

                          // Row 4: ขวา -> ซ้าย
                          _buildRoadMapRow(
                            context,
                            data,
                            setState,
                            isLeftToRight: true,
                            steps: [
                              RoadMapStep(
                                number: 13,
                                title: 'Confirm Insurance',
                                date: data.confirm_insurance,
                                icon: Icons.verified_user,
                                color: Colors.blueGrey,
                                isCompleted: data.confirm_insurance.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 14,
                                title: 'Post & QC',
                                date: data.post_and_qc,
                                icon: Icons.fact_check,
                                color: Colors.amber,
                                isCompleted: data.post_and_qc.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 15,
                                title: 'Send Document',
                                date: data.send_document,
                                icon: Icons.send,
                                color: Colors.deepPurple,
                                isCompleted: data.send_document.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 16,
                                title: 'Issue Invoice',
                                date: data.issue_invoice,
                                icon: Icons.receipt,
                                color: Colors.green,
                                isCompleted: data.issue_invoice.isNotEmpty,
                                isEditable: false,
                              ),
                              RoadMapStep(
                                number: 17,
                                title: 'Receive Billing',
                                date: data.receive_shipping,
                                icon: Icons.payment,
                                color: Colors.greenAccent,
                                isCompleted: data.receive_shipping.isNotEmpty,
                                isEditable: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Confirm Button
                          if (data.receive_booking.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (editAction == true) {
                                        ConfirmationDialog.show(
                                          context,
                                          icon: Icons.check_circle,
                                          iconColor: Colors.green,
                                          title: 'Confirm edit',
                                          content: 'Did you Confirm edit?',
                                          confirmText: 'Confirm',
                                          confirmButtonColor: Colors.green,
                                          cancelText: 'Cancel',
                                          cancelButtonColor: Colors.grey,
                                          onConfirm: () async {
                                            if (data.receive_booking.isNotEmpty) {
                                              if (originalData.receive_booking1.isEmpty) {
                                                data
                                                  ..receive_booking1 = originalData.receive_booking
                                                  ..user_edit_booking1 = USERDATA.NAME;
                                              } else if (originalData.receive_booking2.isEmpty) {
                                                data
                                                  ..receive_booking2 = originalData.receive_booking
                                                  ..user_edit_booking2 = USERDATA.NAME;
                                              } else {
                                                data
                                                  ..receive_booking3 = originalData.receive_booking
                                                  ..user_edit_booking3 = USERDATA.NAME;
                                              }
                                            }

                                            if (data.etd.isNotEmpty) {
                                              if (originalData.etd1.isEmpty) {
                                                data
                                                  ..etd1 = originalData.etd
                                                  ..user_edit_etd1 = USERDATA.NAME;
                                              } else if (originalData.etd2.isEmpty) {
                                                data
                                                  ..etd2 = originalData.etd
                                                  ..user_edit_etd2 = USERDATA.NAME;
                                              } else {
                                                data
                                                  ..etd3 = originalData.etd
                                                  ..user_edit_etd3 = USERDATA.NAME;
                                              }
                                            }
                                            P01INPUTDATAVAR.SendDataToAPI = data.toJson();
                                            // print(P01INPUTDATAVAR.SendDataToAPI);
                                            await updateEdit(context);
                                          },
                                        );
                                      } else {
                                        ConfirmationDialog.show(
                                          context,
                                          icon: Icons.check_circle,
                                          iconColor: Colors.green,
                                          title: 'Confirm & Next Plan',
                                          content: 'Did you Confirm & Next Plan?',
                                          confirmText: 'Confirm',
                                          confirmButtonColor: Colors.green,
                                          cancelText: 'Cancel',
                                          cancelButtonColor: Colors.grey,
                                          onConfirm: () async {
                                            updateItemStatus(data);
                                            updateStatusDue(data);
                                            P01INPUTDATAVAR.SendDataToAPI = data.toJson();
                                            // print(P01INPUTDATAVAR.SendDataToAPI);
                                            await updateN2(context);
                                          },
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      elevation: 8,
                                      shadowColor: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(editAction! ? Icons.edit : Icons.rocket_launch, size: 24),
                                        const SizedBox(width: 10),
                                        Text(
                                          editAction! ? 'Confirm edit' : 'Confirm & Next Plan',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    _showHistoryDialog(context, data);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    elevation: 8,
                                    shadowColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  ),
                                  child: const Icon(Icons.history, size: 24),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget buildCustomField({
  required BuildContext context,
  required String labelText,
  required String value,
  required IconData icon,
  String? hintText,
  List<String>? dropdownItems,
  String? loadingDate,
  void Function(String)? onChanged,
  VoidCallback? onStateChanged,
}) {
  if (labelText == "Estimate Loading date" ||
      labelText == "Require ETD" ||
      labelText == "Require ETA" ||
      labelText == "Receive booking confirmation") {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) => buildDatePickerTheme(context, child),
          );
          if (date != null) {
            final formattedDate =
                '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';

            if (onChanged != null) {
              onChanged(formattedDate);
            }
            if (onStateChanged != null) {
              onStateChanged(); // refresh UI
            }
          }
        },
        child: AbsorbPointer(
          child: Builder(
            builder: (context) {
              bool isOverLimit = false;
              if (labelText == "Estimate Loading date" && value.isNotEmpty) {
                try {
                  final parts = value.split("-");
                  // print(parts);
                  final selectedDate = DateTime(
                    int.parse(parts[2]),
                    int.parse(parts[1]),
                    int.parse(parts[0]),
                  );

                  final oldParts = loadingDate!.split("-");
                  // print(oldParts);
                  final oldDate = DateTime(
                    int.parse(oldParts[2]),
                    int.parse(oldParts[1]),
                    int.parse(oldParts[0]),
                  );

                  if (selectedDate.isAfter(oldDate)) {
                    isOverLimit = true;
                  }
                } catch (e) {
                  print("Error parsing date: $e");
                }
              }

              return TextFormField(
                key: ValueKey('$labelText-$value'),
                initialValue: value,
                style: TextStyle(
                  color: isOverLimit ? Colors.red : Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(icon, color: Colors.blue),
                  labelText: labelText,
                  hintText: hintText,
                  hintStyle: buildHintStyle(),
                  labelStyle: buildTextStyle(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill $labelText';
                  }
                  return null;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  if ((labelText == "Customer Name" ||
          labelText == "Material Description" ||
          labelText == "Shipment type" ||
          labelText == "UOM") &&
      dropdownItems != null) {
    return DropdownSearch<String>(
      key: Key(labelText + value),
      items: dropdownItems,
      selectedItem: value,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: labelText,
          labelStyle: buildTextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        menuProps: const MenuProps(
          backgroundColor: Colors.white,
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        fit: FlexFit.loose,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        );
      },
      onChanged: (v) {
        if (v != null) {
          value = v;
          if (onChanged != null) onChanged(v);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill $labelText';
        }
        return null;
      },
    );
  }
  if (labelText == "Customer No." ||
      labelText == "Material No." ||
      labelText == "Receive Date" ||
      labelText == "Acknowledgement" ||
      labelText == "Delivery Order in SAP" ||
      labelText == "Loading Sheet" ||
      labelText == "Confirm Export Entry" ||
      labelText == "Loading Date" ||
      labelText == "Confirm Bill of Loading (B/L)" ||
      labelText == "ETD" ||
      labelText == "Confirm Insurance" ||
      labelText == "Post goods issue & QC report" ||
      labelText == "Send shipping document to customer" ||
      labelText == "Issue invoice for accounting" ||
      labelText == "Receive shipping&forwarder billing") {
    return TextFormField(
      key: Key(labelText + value),
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: labelText,
        hintText: hintText,
        hintStyle: buildHintStyle(),
        labelStyle: buildTextStyleGrey(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill $labelText';
        }
        return null;
      },
    );
  }

  if (labelText == "Quantity") {
    return TextFormField(
      key: Key(labelText + value),
      initialValue: value,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: labelText,
        hintText: hintText,
        hintStyle: buildHintStyle(),
        labelStyle: buildTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill $labelText';
        }
        return null;
      },
    );
  }

  return TextFormField(
    key: Key(labelText + value),
    initialValue: value,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue),
      labelText: labelText,
      hintText: hintText,
      hintStyle: buildHintStyle(),
      labelStyle: buildTextStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    onChanged: onChanged,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill $labelText';
      }
      return null;
    },
  );
}

TextStyle buildTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle buildTextStyleGrey() {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle buildHintStyle() {
  return TextStyle(
    color: Colors.grey.shade400,
    fontSize: 14,
  );
}

Widget buildDatePickerTheme(BuildContext context, Widget? child) {
  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.blue, // สี Header และปุ่ม OK
        onPrimary: Colors.white, // สีข้อความบนปุ่ม OK
        onSurface: Colors.black, // สีข้อความทั่วไป
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue, // สีปุ่ม CANCEL และ OK
        ),
      ),
      dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
    ),
    child: child!,
  );
}

Widget buildDropdownSearchField({
  required String labelText,
  required String value,
  required IconData icon,
  required List<String> dropdownItems,
  void Function(String)? onChanged,
}) {
  return DropdownSearch<String>(
    key: Key(labelText + value),
    items: dropdownItems,
    selectedItem: value.isEmpty ? null : value,
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: labelText,
        labelStyle: buildTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
    popupProps: PopupProps.menu(
      showSearchBox: true,
      menuProps: const MenuProps(
        backgroundColor: Colors.white,
      ),
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      fit: FlexFit.loose,
    ),
    dropdownBuilder: (context, selectedItem) {
      return Text(
        selectedItem ?? '',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14),
      );
    },
    onChanged: (v) {
      if (v != null) {
        if (onChanged != null) onChanged(v);
      }
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill $labelText';
      }
      return null;
    },
  );
}

// ฟังก์ชันช่วยคำนวณวันโดยไม่นับเสาร์อาทิตย์
DateTime? addBusinessDays(String startDate, int daysToAdd) {
  DateTime? date = parseCustomDate(startDate);
  int addedDays = 0;

  while (addedDays < daysToAdd) {
    date = date!.add(const Duration(days: 1));
    // ข้ามเสาร์(6) และอาทิตย์(7)
    if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
      addedDays++;
    }
  }
  return date;
}

DateTime? parseCustomDate(String dateStr) {
  try {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
  } catch (e) {
    debugPrint("Parse error: $e");
  }
  return null;
}

String formatDateToDMY(DateTime? date) {
  return '${date!.day.toString().padLeft(2, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.year}';
}

String calculateDateByShipment(String startDate, String shipmentType, {bool isProforma = true}) {
  int daysToAdd = 0;

  switch (shipmentType.toLowerCase()) {
    case "air":
      daysToAdd = isProforma ? 5 : 7;
      break;
    case "sea":
      daysToAdd = isProforma ? 10 : 12;
      break;
    case "truck":
      daysToAdd = isProforma ? 10 : 10;
      break;
  }

  DateTime? result = addBusinessDays(startDate, daysToAdd);
  return formatDateToDMY(result!);
}

// Road Map Step Model
class RoadMapStep {
  final int number;
  final String title;
  final String date;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isEditable;
  final VoidCallback? onTap;
  final bool showDownArrow;

  RoadMapStep({
    required this.number,
    required this.title,
    required this.date,
    required this.icon,
    required this.color,
    required this.isCompleted,
    this.isEditable = false,
    this.onTap,
    this.showDownArrow = false,
  });
}

// Build Road Map Row
Widget _buildRoadMapRow(
  BuildContext context,
  P01INPUTDATAGETDATAclass data,
  StateSetter setState, {
  required bool isLeftToRight,
  required List<RoadMapStep> steps,
}) {
  if (!isLeftToRight) {
    steps = steps.reversed.toList();
  }

  return IntrinsicHeight(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          // การ์ดชิดบน
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRoadMapCard(context, steps[i], setState),
            ],
          ),

          // ลูกศรอยู่กลาง
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLeftToRight ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.blue.shade300,
                    size: 30,
                  ),
                ],
              ),
            ),
        ],
      ],
    ),
  );
}

// Build Road Map Card
class _RoadMapCardState extends State<_RoadMapCard> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.step.isEditable) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..repeat(reverse: true);

      _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
      );
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 160,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: widget.step.isEditable ? widget.step.onTap : null,
            borderRadius: BorderRadius.circular(20),
            child: widget.step.isEditable && _animationController != null
                ? AnimatedBuilder(
                    animation: _animationController!,
                    builder: (context, child) {
                      return _buildContainer(child!);
                    },
                    child: _buildCardContent(),
                  )
                : _buildContainer(_buildCardContent()),
          ),
        ),
        if (widget.step.showDownArrow) const Icon(Icons.arrow_downward, color: Colors.blue, size: 28),
      ],
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.step.isCompleted
              ? [widget.step.color.withOpacity(0.8), widget.step.color]
              : [Colors.grey.shade300, Colors.grey.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
        border: widget.step.isEditable && _opacityAnimation != null
            ? Border.all(
                color: Colors.amber.withOpacity(_opacityAnimation!.value),
                width: 3,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color:
                widget.step.isCompleted ? widget.step.color.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
          if (widget.step.isEditable && _opacityAnimation != null)
            BoxShadow(
              color: Colors.amber.withOpacity(_opacityAnimation!.value * 0.5),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCardContent() {
    return Stack(
      children: [
        // Background Pattern
        Positioned(
          right: -20,
          top: -20,
          child: Icon(
            widget.step.icon,
            size: 100,
            color: Colors.white.withOpacity(0.1),
          ),
        ),

        // Animated Pulse Border
        if (widget.step.isEditable && _animationController != null)
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(_opacityAnimation!.value * 0.5),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),

        // Content
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Number Badge with Pulse
              widget.step.isEditable && _animationController != null
                  ? AnimatedBuilder(
                      animation: _animationController!,
                      builder: (context, child) => _buildStepBadge(),
                    )
                  : _buildStepBadge(),

              const SizedBox(height: 8),

              // Icon with Pulsing Badge
              Stack(
                children: [
                  Icon(
                    widget.step.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ],
              ),

              const Spacer(),

              // Title
              Row(
                children: [
                  if (widget.step.isEditable)
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      widget.step.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: widget.step.isEditable ? FontWeight.w900 : FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Date
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      widget.step.isEditable ? Colors.amber.withOpacity(0.3) : Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 12,
                    ),
                    if (widget.step.isCompleted || widget.step.isEditable) ...[
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.step.date.isNotEmpty ? widget.step.date : 'Click to set',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (widget.step.isEditable)
                      const Icon(
                        Icons.touch_app,
                        color: Colors.white,
                        size: 14,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Completed Check
        if (widget.step.isCompleted)
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
          ),

        // Corner Ribbon
        if (widget.step.isEditable)
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade400, Colors.amber.shade600],
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.step.isEditable ? Colors.amber : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: widget.step.isEditable && _opacityAnimation != null
            ? [
                BoxShadow(
                  color: Colors.amber.withOpacity(_opacityAnimation!.value * 0.7),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.step.isEditable)
            const Icon(
              Icons.touch_app,
              size: 12,
              color: Colors.black87,
            ),
          if (widget.step.isEditable) const SizedBox(width: 4),
          Text(
            'Step ${widget.step.number}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: widget.step.isEditable ? Colors.black87 : widget.step.color,
            ),
          ),
        ],
      ),
    );
  }
}

// StatefulWidget
class _RoadMapCard extends StatefulWidget {
  final RoadMapStep step;
  final StateSetter parentSetState;

  const _RoadMapCard({
    required this.step,
    required this.parentSetState,
  });

  @override
  State<_RoadMapCard> createState() => _RoadMapCardState();
}

// Function wrapper
Widget _buildRoadMapCard(BuildContext context, RoadMapStep step, StateSetter setState) {
  return _RoadMapCard(step: step, parentSetState: setState);
}

// Date Picker Helper
void _showDatePicker(BuildContext context, StateSetter setState, Function(String) onDateSelected) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) => buildDatePickerTheme(context, child),
  ).then((pickedDate) {
    if (pickedDate != null) {
      String formattedDate =
          '${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year.toString().substring(2)}';
      setState(() {
        onDateSelected(formattedDate);
      });
    }
  });
}

void _showHistoryDialog(BuildContext context, P01INPUTDATAGETDATAclass data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 600,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Edit History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Receive Booking History
                      _buildHistorySection(
                        title: 'Receive Booking History',
                        icon: Icons.calendar_today,
                        color: Colors.cyan,
                        currentValue: data.receive_booking,
                        histories: [
                          if (data.receive_booking1.isNotEmpty)
                            HistoryItem(
                              value: data.receive_booking1,
                              editedBy: data.user_edit_booking1,
                              editedDate: data.user_edit_booking_date1,
                              version: 1,
                            ),
                          if (data.receive_booking2.isNotEmpty)
                            HistoryItem(
                              value: data.receive_booking2,
                              editedBy: data.user_edit_booking2,
                              editedDate: data.user_edit_booking_date2,
                              version: 2,
                            ),
                          if (data.receive_booking3.isNotEmpty)
                            HistoryItem(
                              value: data.receive_booking3,
                              editedBy: data.user_edit_booking3,
                              editedDate: data.user_edit_booking_date3,
                              version: 3,
                            ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ETD History
                      _buildHistorySection(
                        title: 'ETD History',
                        icon: Icons.flight,
                        color: Colors.red,
                        currentValue: data.etd,
                        histories: [
                          if (data.etd1.isNotEmpty)
                            HistoryItem(
                              value: data.etd1,
                              editedBy: data.user_edit_etd1,
                              editedDate: data.user_edit_etd_date1,
                              version: 1,
                            ),
                          if (data.etd2.isNotEmpty)
                            HistoryItem(
                              value: data.etd2,
                              editedBy: data.user_edit_etd2,
                              editedDate: data.user_edit_etd_date2,
                              version: 2,
                            ),
                          if (data.etd3.isNotEmpty)
                            HistoryItem(
                              value: data.etd3,
                              editedBy: data.user_edit_etd3,
                              editedDate: data.user_edit_etd_date3,
                              version: 3,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Build History Section
Widget _buildHistorySection({
  required String title,
  required IconData icon,
  required Color color,
  required String currentValue,
  required List<HistoryItem> histories,
}) {
  // print(histories);
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withOpacity(0.3), width: 2),
      borderRadius: BorderRadius.circular(15),
      color: color.withOpacity(0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Current Value
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Current',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  currentValue.isNotEmpty ? currentValue : '-',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Icon(Icons.check_circle, color: color, size: 20),
            ],
          ),
        ),

        // History Timeline
        if (histories.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Previous Changes:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ...histories.map((history) => _buildHistoryCard(history, color)),
        ] else ...[
          const SizedBox(height: 12),
          Center(
            child: Text(
              'No edit history',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

// Build History Card
Widget _buildHistoryCard(HistoryItem history, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Version Badge
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              'V${history.version}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history.value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    history.editedBy.isNotEmpty ? history.editedBy : 'Unknown',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    history.editedDate.isNotEmpty ? history.editedDate : '-',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Arrow Icon
        Icon(
          Icons.arrow_upward,
          color: color.withOpacity(0.5),
          size: 20,
        ),
      ],
    ),
  );
}
