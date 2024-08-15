import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/unverified_transaction.dart'; // Adjust the import path as necessary
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/tabel_pengajuan_pembayaran.dart';
import 'package:my_flutter_app/admin/service/unverified_transaction_service.dart'; // Adjust the import path as necessary
import 'package:my_flutter_app/widget/menucategory.dart';

class PengajuanPembayaraAdminScreenState extends StatefulWidget {
  PengajuanPembayaraAdminScreenState({Key? key}) : super(key: key);

  @override
  State<PengajuanPembayaraAdminScreenState> createState() =>
      _PengajuanPembayaraAdminScreenStateState();
}

class _PengajuanPembayaraAdminScreenStateState
    extends State<PengajuanPembayaraAdminScreenState> {
  final UnverifiedTransactionService _unverifiedTransactionService =
      UnverifiedTransactionService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 700,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().tertiaryColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Transaction>>(
                future:
                    _unverifiedTransactionService.fetchUnverifiedTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height / 2.0,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return Text("${snapshot.data!.length} Pengajuan");
                  } else {
                    return const Text("0 Pengajuan");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 180,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabelVerifikasiPembayaran(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorStyle().primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Lihat Pembayaran"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
