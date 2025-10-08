// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use, use_build_context_synchronously, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../data/global.dart';

class P03SUMMARYMAILMAIN extends StatefulWidget {
  const P03SUMMARYMAILMAIN({super.key});

  @override
  State<P03SUMMARYMAILMAIN> createState() => _P03SUMMARYMAILMAINState();
}

class _P03SUMMARYMAILMAINState extends State<P03SUMMARYMAILMAIN> {
  List<dynamic> allData = [];
  Map<String, List<dynamic>> statusMap = {};
  bool isLoading = true;
  String errorMessage = '';

  final List<Map<String, dynamic>> statusConfig = [
    {'name': 'Receive PO', 'icon': '🛒', 'color': Color(0xFF4CAF50)},
    {'name': 'Sale Order in SAP', 'icon': '📋', 'color': Color(0xFF2196F3)},
    {'name': 'Proforma.INV+PL', 'icon': '📄', 'color': Color(0xFFFF9800)},
    {'name': 'Book shipment', 'icon': '📦', 'color': Color(0xFF9C27B0)},
    {'name': 'Receive booking confirmation', 'icon': '📅', 'color': Color(0xFF00BCD4)},
    {'name': 'Acknowledgement', 'icon': '✅', 'color': Color(0xFF009688)},
    {'name': 'Delivery Order in SAP', 'icon': '🚚', 'color': Color(0xFF3F51B5)},
    {'name': 'Loading Sheet', 'icon': '📊', 'color': Color(0xFF795548)},
    {'name': 'Confirm Export Entry', 'icon': '✈️', 'color': Color(0xFFFF5722)},
    {'name': 'Loading Date', 'icon': '🚛', 'color': Color(0xFFE91E63)},
    {'name': 'Confirm Bill of Loading (B/L)', 'icon': '📃', 'color': Color(0xFFCDDC39)},
    {'name': 'ETD', 'icon': '🛫', 'color': Color(0xFFF44336)},
    {'name': 'Confirm Insurance', 'icon': '🛡️', 'color': Color(0xFF607D8B)},
    {'name': 'Post goods issue & QC report', 'icon': '✔️', 'color': Color(0xFFFFC107)},
    {'name': 'Send shipping document to customer', 'icon': '📤', 'color': Color(0xFF673AB7)},
    {'name': 'Issue invoice for accounting', 'icon': '🧾', 'color': Color(0xFF4CAF50)},
    {'name': 'Receive shipping&forwarder billing', 'icon': '💰', 'color': Color(0xFF8BC34A)},
  ];

  @override
  void initState() {
    super.initState();
    PageName = 'SUMMARY DATA';
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('$ToServer/03SENDMAIL/getData'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          allData = data;
          statusMap = groupDataByStatus(data);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Map<String, List<dynamic>> groupDataByStatus(List<dynamic> data) {
    Map<String, List<dynamic>> grouped = {};

    for (var item in data) {
      String status = item['status']?.toString().trim() ?? '';
      if (status.isNotEmpty) {
        if (!grouped.containsKey(status)) {
          grouped[status] = [];
        }
        grouped[status]!.add(item);
      }
    }

    return grouped;
  }

  String formatDate(dynamic dateStr) {
    if (dateStr == null) return '-';
    try {
      DateTime date = DateTime.parse(dateStr.toString());
      return DateFormat('dd-MM-yy').format(date);
    } catch (e) {
      return '-';
    }
  }

  int getTotalShipments() {
    return statusMap.values.fold(0, (sum, items) => sum + items.length);
  }

  int getActiveStatuses() {
    return statusMap.keys.where((status) => !status.toLowerCase().contains('complete')).length;
  }

  int getCompleteStatuses() {
    int total = 0;
    statusMap.forEach((status, items) {
      if (status.toLowerCase().contains('complete')) {
        total += items.length;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text(errorMessage, style: TextStyle(color: Colors.red))),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    _buildSummaryStats(),
                    SizedBox(height: 30),
                    ...statusConfig.map((config) {
                      final statusData = statusMap[config['name']] ?? [];
                      if (statusData.isNotEmpty) {
                        return _buildStatusSection(
                          config['name'] as String,
                          config['icon'] as String,
                          config['color'] as Color,
                          statusData,
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '📊 Daily Shipment Progress Report in ${DateFormat('MMM yyyy').format(DateTime.now())}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Generated on ${DateFormat('MMMM dd, yyyy - HH:mm').format(DateTime.now())}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildStatCard(getTotalShipments().toString(), 'Total Shipments'),
        _buildStatCard(getActiveStatuses().toString(), 'Active Statuses'),
        _buildStatCard(getCompleteStatuses().toString(), 'Complete Statuses'),
      ],
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      constraints: BoxConstraints(minWidth: 150),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1976D2),
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(String statusName, String icon, Color color, List<dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(icon, style: TextStyle(fontSize: 36)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${data.length} Shipment${data.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.95),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: data.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return _buildShipmentCard(index + 1, item, color);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentCard(int index, dynamic item, Color color) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFF0F0F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Shipment $index',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item['custshort']?.toString() ?? '-',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFFAFAFA),
            child: Column(
              children: [
                _buildDetailRow('📋', 'PO Number', item['po_no']?.toString() ?? '-', color),
                SizedBox(height: 14),
                _buildDetailRow('✈️', 'ETD', formatDate(item['etd']), color),
                SizedBox(height: 14),
                _buildStatusInfo(item['status']?.toString() ?? '-', formatDate(item['status_due']), color),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfo(String status, String dueDate, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ℹ️', style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURRENT STATUS & DUE DATE',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [Color(0xFFF5F5F5), Color(0xFFEEEEEE)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.4), width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('📅', style: TextStyle(fontSize: 13)),
                          SizedBox(width: 6),
                          Text(
                            'Due: $dueDate',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF616161),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 2)),
      ),
      child: Column(
        children: [
          Text(
            '🔔 This is an automated daily report from Export Alert System',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF757575),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'For any questions, please contact the automation team.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF757575),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
