import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/mentor_model.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/detail_mentor_admin.dart';
import 'package:my_flutter_app/admin/service/mentor_service.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  late Future<List<Mentor>> _mentorFuture;
  final TextEditingController _searchController = TextEditingController();

  List<Mentor> _allMentors = [];
  List<Mentor> _filteredMentors = [];

  @override
  void initState() {
    super.initState();
    _mentorFuture = MentorService().fetchMentors();
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
          .where((mentor) => mentor.name!
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
                labelText: 'Search by mentor name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Mentor>>(
          future: _mentorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (snapshot.hasData) {
              _allMentors = snapshot.data!;
              if (_filteredMentors.isEmpty && _searchController.text.isEmpty) {
                _filteredMentors = _allMentors;
              }
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _filteredMentors.map((mentors) {
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
                                child: Text(mentors.name ?? ''),
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
                                              DetailMentorAdmin(
                                                  mentorDetail: mentors),
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
                      child: Center(child: Text('Tidak ada data mentor')),
                    )),
              );
            }
          },
        ),
      ],
    );
  }
}
