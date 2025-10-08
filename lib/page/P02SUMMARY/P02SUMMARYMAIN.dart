// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02SUMMARY.dart';
import '../../data/global.dart';
import 'Function/showDialog.dart';

late BuildContext P02SUMMARYcontext;

class P02SUMMARYMAIN extends StatefulWidget {
  P02SUMMARYMAIN({
    super.key,
    this.data,
  });
  List<P02SUMMARYGETDATAclass>? data;

  @override
  State<P02SUMMARYMAIN> createState() => _P02SUMMARYMAINState();
}

class _P02SUMMARYMAINState extends State<P02SUMMARYMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P02SUMMARYGETDATA_Bloc>().add(P02SUMMARYGETDATA_GET());
    PageName = 'SHIPMENT PROGRESS ROAD MAP';
  }

  @override
  Widget build(BuildContext context) {
    P02SUMMARYcontext = context;
    List<P02SUMMARYGETDATAclass> data = widget.data ?? [];

    Map<String, List<P02SUMMARYGETDATAclass>> statusMap = {};

    for (var item in data) {
      if (item.status != null && item.status.isNotEmpty) {
        statusMap.putIfAbsent(item.status, () => []);
        statusMap[item.status]!.add(item);
      }
    }

    List<P02SUMMARYGETDATAclass> getDataForStep(String stepName) {
      return statusMap[stepName] ?? [];
    }

    String getQuantity(String stepName) {
      int count = statusMap[stepName]?.length ?? 0;
      return count > 0 ? '$count PO' : '';
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        // width: MediaQuery.of(context).size.width * 0.9,
        // constraints: BoxConstraints(
        //   maxHeight: MediaQuery.of(context).size.height * 0.85,
        // ),
        // padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Center(
            //   child: Text(
            //     'Shipment Progress Road Map',
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                // padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _buildRoadMapRow(
                      context,
                      data,
                      setState,
                      isLeftToRight: true,
                      steps: [
                        RoadMapStep(
                          number: 1,
                          title: 'Receive PO',
                          quantity: getQuantity('Receive PO'),
                          icon: Icons.shopping_cart,
                          color: Colors.teal,
                          isCompleted: getQuantity('Receive PO').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Receive PO',
                            getDataForStep('Receive PO'),
                            Colors.teal,
                            Icons.shopping_cart,
                          ),
                        ),
                        RoadMapStep(
                          number: 2,
                          title: 'Sale Order',
                          quantity: getQuantity('Sale Order in SAP'),
                          icon: Icons.description,
                          color: Colors.teal,
                          isCompleted: getQuantity('Sale Order in SAP').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Sale Order in SAP',
                            getDataForStep('Sale Order in SAP'),
                            Colors.teal,
                            Icons.description,
                          ),
                        ),
                        RoadMapStep(
                          number: 3,
                          title: 'Proforma',
                          quantity: getQuantity('Proforma.INV+PL'),
                          icon: Icons.receipt_long,
                          color: Colors.teal,
                          isCompleted: getQuantity('Proforma.INV+PL').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Proforma.INV+PL',
                            getDataForStep('Proforma.INV+PL'),
                            Colors.teal,
                            Icons.receipt_long,
                          ),
                        ),
                        RoadMapStep(
                          number: 4,
                          title: 'Book Shipment',
                          quantity: getQuantity('Book shipment'),
                          icon: Icons.book_online,
                          color: Colors.teal,
                          isCompleted: getQuantity('Book shipment').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Book shipment',
                            getDataForStep('Book shipment'),
                            Colors.teal,
                            Icons.book_online,
                          ),
                        ),
                        RoadMapStep(
                          number: 5,
                          title: 'Receive Booking',
                          quantity: getQuantity('Receive booking confirmation'),
                          icon: Icons.calendar_today,
                          color: Colors.teal,
                          isCompleted: getQuantity('Receive booking confirmation').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Receive booking confirmation',
                            getDataForStep('Receive booking confirmation'),
                            Colors.teal,
                            Icons.calendar_today,
                          ),
                        ),
                        RoadMapStep(
                          number: 6,
                          title: 'Acknowledgement',
                          quantity: getQuantity('Acknowledgement'),
                          icon: Icons.check_circle,
                          color: Colors.teal,
                          isCompleted: getQuantity('Acknowledgement').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Acknowledgement',
                            getDataForStep('Acknowledgement'),
                            Colors.teal,
                            Icons.check_circle,
                          ),
                          showDownArrow: true,
                        ),
                      ],
                    ),
                    _buildRoadMapRow(
                      context,
                      data,
                      setState,
                      isLeftToRight: false,
                      steps: [
                        RoadMapStep(
                          number: 7,
                          title: 'Delivery Order',
                          quantity: getQuantity('Delivery Order in SAP'),
                          icon: Icons.local_shipping,
                          color: Colors.teal,
                          isCompleted: getQuantity('Delivery Order in SAP').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Delivery Order in SAP',
                            getDataForStep('Delivery Order in SAP'),
                            Colors.teal,
                            Icons.local_shipping,
                          ),
                        ),
                        RoadMapStep(
                          number: 8,
                          title: 'Loading Sheet',
                          quantity: getQuantity('Loading Sheet'),
                          icon: Icons.assignment,
                          color: Colors.teal,
                          isCompleted: getQuantity('Loading Sheet').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Loading Sheet',
                            getDataForStep('Loading Sheet'),
                            Colors.teal,
                            Icons.assignment,
                          ),
                        ),
                        RoadMapStep(
                          number: 9,
                          title: 'Export Entry',
                          quantity: getQuantity('Confirm Export Entry'),
                          icon: Icons.flight_takeoff,
                          color: Colors.teal,
                          isCompleted: getQuantity('Confirm Export Entry').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Confirm Export Entry',
                            getDataForStep('Confirm Export Entry'),
                            Colors.teal,
                            Icons.flight_takeoff,
                          ),
                        ),
                        RoadMapStep(
                          number: 10,
                          title: 'Loading Date',
                          quantity: getQuantity('Loading Date'),
                          icon: Icons.local_shipping,
                          color: Colors.teal,
                          isCompleted: getQuantity('Loading Date').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Loading Date',
                            getDataForStep('Loading Date'),
                            Colors.teal,
                            Icons.local_shipping,
                          ),
                        ),
                        RoadMapStep(
                          number: 11,
                          title: 'Bill of Loading',
                          quantity: getQuantity('Confirm Bill of Loading (B/L)'),
                          icon: Icons.description,
                          color: Colors.teal,
                          isCompleted: getQuantity('Confirm Bill of Loading (B/L)').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Confirm Bill of Loading (B/L)',
                            getDataForStep('Confirm Bill of Loading (B/L)'),
                            Colors.teal,
                            Icons.description,
                          ),
                        ),
                        RoadMapStep(
                          number: 12,
                          title: 'ETD',
                          quantity: getQuantity('ETD'),
                          icon: Icons.flight,
                          color: Colors.teal,
                          isCompleted: getQuantity('ETD').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'ETD',
                            getDataForStep('ETD'),
                            Colors.teal,
                            Icons.flight,
                          ),
                          showDownArrow: true,
                        ),
                      ],
                    ),
                    _buildRoadMapRow(
                      context,
                      data,
                      setState,
                      isLeftToRight: true,
                      steps: [
                        RoadMapStep(
                          number: 13,
                          title: 'Confirm Insurance',
                          quantity: getQuantity('Confirm Insurance'),
                          icon: Icons.verified_user,
                          color: Colors.teal,
                          isCompleted: getQuantity('Confirm Insurance').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Confirm Insurance',
                            getDataForStep('Confirm Insurance'),
                            Colors.teal,
                            Icons.verified_user,
                          ),
                        ),
                        RoadMapStep(
                          number: 14,
                          title: 'Post & QC',
                          quantity: getQuantity('Post goods issue & QC report'),
                          icon: Icons.fact_check,
                          color: Colors.teal,
                          isCompleted: getQuantity('Post goods issue & QC report').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Post goods issue & QC report',
                            getDataForStep('Post goods issue & QC report'),
                            Colors.teal,
                            Icons.fact_check,
                          ),
                        ),
                        RoadMapStep(
                          number: 15,
                          title: 'Send Document',
                          quantity: getQuantity('Send shipping document to customer'),
                          icon: Icons.send,
                          color: Colors.teal,
                          isCompleted: getQuantity('Send shipping document to customer').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Send shipping document to customer',
                            getDataForStep('Send shipping document to customer'),
                            Colors.teal,
                            Icons.send,
                          ),
                        ),
                        RoadMapStep(
                          number: 16,
                          title: 'Issue Invoice',
                          quantity: getQuantity('Issue invoice for accounting'),
                          icon: Icons.receipt,
                          color: Colors.teal,
                          isCompleted: getQuantity('Issue invoice for accounting').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Issue invoice for accounting',
                            getDataForStep('Issue invoice for accounting'),
                            Colors.teal,
                            Icons.receipt,
                          ),
                        ),
                        RoadMapStep(
                          number: 17,
                          title: 'Receive Billing',
                          quantity: getQuantity('Receive shipping&forwarder billing'),
                          icon: Icons.payment,
                          color: Colors.teal,
                          isCompleted: getQuantity('Receive shipping&forwarder billing').isNotEmpty,
                          onTap: () => showStepDetailsDialog(
                            context,
                            'Receive shipping&forwarder billing',
                            getDataForStep('Receive shipping&forwarder billing'),
                            Colors.teal,
                            Icons.payment,
                          ),
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
  }
}

class RoadMapStep {
  final int number;
  final String title;
  final String quantity;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final VoidCallback? onTap;
  final bool showDownArrow;

  RoadMapStep({
    required this.number,
    required this.title,
    required this.quantity,
    required this.icon,
    required this.color,
    required this.isCompleted,
    this.onTap,
    this.showDownArrow = false,
  });
}

// Build Road Map Row
Widget _buildRoadMapRow(
  BuildContext context,
  List<P02SUMMARYGETDATAclass> data,
  StateSetter setState, {
  required bool isLeftToRight,
  required List<RoadMapStep> steps,
}) {
  if (!isLeftToRight) {
    steps = steps.reversed.toList();
  }

  return IntrinsicHeight(
    child: Container(
      // margin: const EdgeInsets.symmetric(vertical: 16),
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.blue.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRoadMapCard(context, steps[i], setState),
              ],
            ),
            if (i < steps.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isLeftToRight ? Icons.arrow_forward : Icons.arrow_back,
                        color: Colors.blue.shade400,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    ),
  );
}

// Build Road Map Card
class _RoadMapCardState extends State<_RoadMapCard> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 170,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: InkWell(
            onTap: widget.step.onTap,
            borderRadius: BorderRadius.circular(24),
            splashColor: widget.step.color.withOpacity(0.3),
            highlightColor: widget.step.color.withOpacity(0.1),
            child: _buildContainer(_buildCardContent()),
          ),
        ),
        if (widget.step.showDownArrow)
          Container(
            // margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
              size: 28,
            ),
          ),
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
              ? [widget.step.color.withOpacity(0.9), widget.step.color]
              : [Colors.grey.shade300, Colors.grey.shade400],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                widget.step.isCompleted ? widget.step.color.withOpacity(0.4) : Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: widget.step.isCompleted ? Colors.white.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
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
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepBadge(),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.step.icon,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.step.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.inventory_2,
                      color: Colors.white,
                      size: 13,
                    ),
                    if (widget.step.isCompleted) ...[
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.step.quantity.isNotEmpty ? widget.step.quantity : 'Tap to view',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.step.isCompleted)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_circle,
                color: widget.step.color,
                size: 24,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag,
            size: 12,
            color: widget.step.color,
          ),
          const SizedBox(width: 4),
          Text(
            'Step ${widget.step.number}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: widget.step.color,
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
