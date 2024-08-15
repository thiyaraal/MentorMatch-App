import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/admin/model/transaction_model.dart';
import 'package:my_flutter_app/admin/service/transaction_service.dart';

class PembayaranAdminScreen extends StatefulWidget {
  @override
  _PembayaranAdminScreenState createState() => _PembayaranAdminScreenState();
}

class _PembayaranAdminScreenState extends State<PembayaranAdminScreen> {
  late Future<List<Transaction>> _transactionsFuture;
  @override
  void initState() {
    super.initState();
    _transactionsFuture = TransactionService().fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: _transactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada data transaksi yang tersedia.'));
        } else {
          List<Transaction> transactions = snapshot.data!;
          return SingleChildScrollView(
            child: _createDataTable(transactions),
          );
        }
      },
    );
  }

  DataTable _createDataTable(List<Transaction> transactions) {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(
        transactions,
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Name',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Tingkat Pendidikan',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Bidang & Minat',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Nama Kelas',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Nama Mentor',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Kode Transaksi',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Tanggal Transaksi',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
      DataColumn(
        label: Container(
          width: 100, // Maximum width
          child: Text(
            'Status',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createRows(List<Transaction> transactions) {
    return transactions.map((transaction) {
      return DataRow(cells: [
        DataCell(Text(
          transaction.user?.name ?? '',
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          transaction.transactionClass?.educationLevel ?? '',
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          transaction.transactionClass?.category ?? '',
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          transaction.transactionClass?.name ?? '',
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          transaction.transactionClass?.mentor?.name ?? '',
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          transaction.uniqueCode.toString(),
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Text(
          DateFormat('dd MMMM yyyy')
              .format(DateTime.parse(transaction.createdAt ?? '')),
          style: TextStyle(fontSize: 10), // Set font size to 10
        )),
        DataCell(Row(
          children: [
            Container(
              width: 100, // Maximum width
              child: Text(
                transaction.paymentStatus ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        )),
      ]);
    }).toList();
  }
}
