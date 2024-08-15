import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/admin/model/unverified_transaction.dart';
import 'package:my_flutter_app/admin/service/unverified_transaction_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class TabelVerifikasiPembayaran extends StatefulWidget {
  @override
  _TabelVerifikasiPembayaranState createState() {
    return _TabelVerifikasiPembayaranState();
  }
}

class _TabelVerifikasiPembayaranState extends State<TabelVerifikasiPembayaran> {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController rejectReasonController = TextEditingController();
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = UnverifiedTransactionService()
        .fetchUnverifiedTransactions()
        .then((transactions) {
      setState(() {
        _transactions = transactions;
        _filteredTransactions = transactions;
      });
      return transactions;
    });
    _searchController.addListener(_searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    rejectReasonController.dispose();
    super.dispose();
  }

  void _searchQuery() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = _transactions.where((transaction) {
        return transaction.user!.name!.toLowerCase().contains(query) ||
            transaction.transactionClass!.name!.toLowerCase().contains(query) ||
            transaction.transactionClass!.educationLevel!
                .toLowerCase()
                .contains(query) ||
            transaction.transactionClass!.mentor!.name!
                .toLowerCase()
                .contains(query);
      }).toList();
    });
  }

  void _showRejectDialog(String transactionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 160, minHeight: 500),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Text(
                            "Penolakan Transaksi",
                            style: FontFamily().titleText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 24,
                                ),
                          ),
                          Text(
                            "Silahkan isi alasan penolakan transaksi di bawah ini agar pengguna dapat mengetahui alasan transaksi ditolak.",
                            style: FontFamily().regularText.copyWith(
                                  color: ColorStyle().disableColors,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: rejectReasonController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                "Isi alasan penolakan transaksi disini...",
                            hintStyle: FontFamily().regularText.copyWith(
                                  color: ColorStyle().disableColors,
                                  fontSize: 12,
                                ),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RegularElevatedButtonWidget(
                      text: "Kirim",
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await UnverifiedTransactionService().rejectTransaction(
                          transactionId,
                          rejectReasonController.text,
                        );

                        setState(() {
                          rejectReasonController.clear();
                          _transactionsFuture = UnverifiedTransactionService()
                              .fetchUnverifiedTransactions()
                              .then((transactions) {
                            setState(() {
                              _transactions = transactions;
                              _filteredTransactions = transactions;
                            });
                            return transactions;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(String transactionId, bool isVerify) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isVerify ? 'Verifikasi Transaksi' : 'Tolak Transaksi'),
          content: Text(isVerify
              ? 'Apakah Anda yakin ingin memverifikasi transaksi ini?'
              : 'Apakah Anda yakin ingin menolak transaksi ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isVerify ? 'Verifikasi' : 'Tolak'),
              onPressed: () async {
                Navigator.of(context).pop();
                if (isVerify) {
                  await UnverifiedTransactionService()
                      .verifyTransaction(transactionId);
                } else {
                  _showRejectDialog(transactionId);
                }
                // Refresh the data
                setState(() {
                  _transactionsFuture = UnverifiedTransactionService()
                      .fetchUnverifiedTransactions()
                      .then((transactions) {
                    setState(() {
                      _transactions = transactions;
                      _filteredTransactions = transactions;
                    });
                    return transactions;
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Data Pembayaran Premium Class',
            style: FontFamily()
                .boldText
                .copyWith(fontSize: 20)
                .copyWith(color: ColorStyle().primaryColors),
          ),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _transactionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: const Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (_transactions.isEmpty) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: const Center(
                      child: Text('Tidak ada data transaksi yang tersedia.')));
            } else {
              return ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Search',
                              style:
                                  FontFamily().boldText.copyWith(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Search by name, class, level, mentor....',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _createDataTable(),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
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

  List<DataRow> _createRows() {
    return _filteredTransactions
        .map((transaction) => DataRow(cells: [
              DataCell(
                Text(transaction.user!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10)),
              ),
              DataCell(
                Text(transaction.transactionClass!.educationLevel!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10)),
              ),
              DataCell(
                Text(transaction.transactionClass!.category!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10)),
              ),
              DataCell(
                Text(transaction.transactionClass!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10)),
              ),
              DataCell(
                Text(transaction.transactionClass!.mentor!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10)),
              ),
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
                  SmallOutlineButtonWidget(
                    text: "Tolak",
                    onPressed: () {
                      // Show the reject dialog
                      _showRejectDialog(
                          transaction.id.toString()); // Pass the transaction ID
                    },
                  ),
                  SmallElevatedButtonWidget(
                    text: "Verifikasi",
                    onPressed: () => _showConfirmationDialog(
                        transaction.id.toString(),
                        true), // true for verification
                  ),
                ],
              )),
            ]))
        .toList();
  }
}
