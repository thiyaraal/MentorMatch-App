import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/unverified_mentor_model.dart';
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/verifikasi_mentor_screen.dart';
import 'package:my_flutter_app/admin/service/unverified_mentor_service.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class PengajuanMentorAdminScreen extends StatefulWidget {
  PengajuanMentorAdminScreen({Key? key}) : super(key: key);

  @override
  State<PengajuanMentorAdminScreen> createState() =>
      _PengajuanMentorAdminScreenState();
}

class _PengajuanMentorAdminScreenState
    extends State<PengajuanMentorAdminScreen> {
  late Future<List<Mentor>> _unverifiedMentorsFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Mentor> _filteredMentors = [];
  List<Mentor> _allMentors = [];

  @override
  void initState() {
    super.initState();
    _unverifiedMentorsFuture =
        UnverifiedMentorService().fetchUnverifiedMentors();
    _searchController.addListener(_filterMentors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMentors() {
    setState(() {
      _filteredMentors = _allMentors
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
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Mentor>>(
          future: _unverifiedMentorsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (snapshot.hasData) {
              _allMentors = snapshot.data!;
              _filteredMentors =
                  _filteredMentors.isEmpty && _searchController.text.isEmpty
                      ? _allMentors
                      : _filteredMentors;

              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _filteredMentors.map((unverifiedMentor) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(unverifiedMentor.name ?? ''),
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
                                              VerifikasiMentorScreen(
                                            mentorDetail: unverifiedMentor,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          ColorStyle().primaryColors,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
              ));
            } else {
              return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Tidak ada pengajuan mentor')),
                  ));
            }
          },
        ),
      ],
    );
  }
}
