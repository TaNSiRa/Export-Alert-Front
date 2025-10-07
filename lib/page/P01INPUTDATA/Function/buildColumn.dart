import 'package:flutter/material.dart';

DataColumn buildSortableColumn(
    String label, int columnIndex, void Function(int columnIndex, bool ascending) sortData) {
  return DataColumn(
    label: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    onSort: (columnIndex, ascending) => sortData(columnIndex, ascending),
  );
}

DataColumn buildStyledColumn(String title) {
  return DataColumn(
    label: Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
