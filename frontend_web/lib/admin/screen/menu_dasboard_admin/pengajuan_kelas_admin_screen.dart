import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/unverified_class_model.dart';
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/detail_pengajuan_verifikasi_kelas.dart';
import 'package:my_flutter_app/admin/service/unverified_class_service.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class PengajuanKelasAdminScreen extends StatefulWidget {
  @override
  _PengajuanKelasAdminScreenState createState() =>
      _PengajuanKelasAdminScreenState();
}

class _PengajuanKelasAdminScreenState extends State<PengajuanKelasAdminScreen> {
  late Future<List<Class>> _unverifiedClassesFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Class> _allClasses = [];
  List<Class> _filteredClasses = [];

  @override
  void initState() {
    super.initState();
    _unverifiedClassesFuture =
        UnverifiedClassService().fetchUnverifiedClasses();
    _searchController.addListener(_filterClasses);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterClasses() {
    setState(() {
      _filteredClasses = _allClasses
          .where((unverifiedClass) => unverifiedClass.name!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 800,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by class name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Class>>(
            future: _unverifiedClassesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error.toString()}'));
              } else if (snapshot.hasData) {
                _allClasses = snapshot.data!;
                _filteredClasses =
                    _filteredClasses.isEmpty && _searchController.text.isEmpty
                        ? _allClasses
                        : _filteredClasses;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _filteredClasses.map((unverifiedClass) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorStyle().tertiaryColors,
                              ),
                              width: 800,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(unverifiedClass.name ?? ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 160,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPengajuanKelasScreen(
                                                      classDetail:
                                                          unverifiedClass),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              ColorStyle().primaryColors,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text("Lihat Detail"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              } else {
                return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Tidak ada pengajuan kelas')),
                    ));
              }
            }),
      ],
    );
  }
}
