import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Payment Method')),
                  DataColumn(label: Text('Date')), // Updated column header
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Employee')),
                ],
                rows: _createRows(), // Generate table rows
                columnSpacing: 16, // Adjust spacing between columns
                dataRowHeight: 60, // Adjust height of data rows
                headingRowHeight: 50, // Adjust height of heading row
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _createRows() {
    // Example data
    final transactions = [
      {
        'date': '2024-09-01',
        'description': 'Sale 001',
        'amount': '\$100.00',
        'status': 'Completed',
        'payment_method': 'Credit Card',
        'date': '2024-09-01', // Updated data
        'customer': 'John Doe',
        'employee': 'Alice Smith',
      },
      {
        'date': '2024-09-02',
        'description': 'Sale 002',
        'amount': '\$150.00',
        'status': 'Pending',
        'payment_method': 'Cash',
        'date': '2024-09-02', // Updated data
        'customer': 'Jane Roe',
        'employee': 'Bob Johnson',
      },
      // Add more rows as needed
    ];

    return transactions.map((transaction) {
      return DataRow(
        cells: [
          DataCell(Text(transaction['date']!)),
          DataCell(Text(transaction['description']!)),
          DataCell(Text(transaction['amount']!)),
          DataCell(Text(transaction['status']!)),
          DataCell(Text(transaction['payment_method']!)),
          DataCell(Text(transaction['date']!)), // Updated data
          DataCell(Text(transaction['customer']!)),
          DataCell(Text(transaction['employee']!)),
        ],
      );
    }).toList();
  }
}