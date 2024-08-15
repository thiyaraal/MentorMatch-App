import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/mentee_model.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/detail_mentee_admin.dart';
import 'package:my_flutter_app/admin/service/mentee_service.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class MenteeScreen extends StatefulWidget {
  @override
  State<MenteeScreen> createState() => _MenteeScreenState();
}

class _MenteeScreenState extends State<MenteeScreen> {
  late Future<List<Mentee>> _menteeFuture;
  final TextEditingController _searchController = TextEditingController();

  List<Mentee> _allMentees = [];
  List<Mentee> _filteredMentees = [];

  @override
  void initState() {
    super.initState();
    _menteeFuture = MenteeService().fetchMentees();
    _searchController.addListener(_filterMentees);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMentees() {
    setState(() {
      _filteredMentees = _allMentees
          .where((mentee) => mentee.name!
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
                labelText: 'Search by mentee name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Mentee>>(
          future: _menteeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (snapshot.hasData) {
              _allMentees = snapshot.data!;
              // Initialize _filteredMentees to the full list when data is received
              if (_filteredMentees.isEmpty && _searchController.text.isEmpty) {
                _filteredMentees = _allMentees;
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _filteredMentees.map((mentees) {
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
                                  child: Text(mentees.name ?? ''),
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
                                                DetailMenteeAdmin(
                                                    menteeDetail: mentees),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorStyle().tertiaryColors,
                  ),
                  width: 800,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Tidak ada data mentee')),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
