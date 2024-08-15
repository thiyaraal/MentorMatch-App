import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/admin/model/list_class_model.dart';
import 'package:my_flutter_app/admin/service/list_class_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class SDListPremiumClassAdminScreenState extends StatefulWidget {
  SDListPremiumClassAdminScreenState({Key? key}) : super(key: key);

  @override
  State<SDListPremiumClassAdminScreenState> createState() =>
      _SDListPremiumClassAdminScreenStateState();
}

class _SDListPremiumClassAdminScreenStateState
    extends State<SDListPremiumClassAdminScreenState> {
  late Future<List<Class>> _listClassesFuture;
  @override
  void initState() {
    super.initState();
    _listClassesFuture = ListClassService().fetchClassesByEducationLevel('SD');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "SD",
        style: FontFamily().titleText.copyWith(
              fontSize: 12,
            ),
      )),
      body: FutureBuilder<List<Class>>(
        future: _listClassesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading classes'),
            );
          } else {
            final classes = snapshot.data!;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final Class classData = classes[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorStyle().tertiaryColors,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  child: CachedNetworkImage(
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/blank_profile.jpg',
                                  fit: BoxFit.cover,
                                ),
                                imageUrl: classData.mentor?.photoUrl ?? '',
                                width: 100,
                                height: 100,
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      classData.name ?? '',
                                      style: FontFamily().titleText.copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                    Text(
                                      "${classData.durationInDays} Bulan",
                                      style: FontFamily().regularText.copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                    Text("Mentor: ${classData.mentor?.name}",
                                        style:
                                            FontFamily().regularText.copyWith(
                                                  fontSize: 12,
                                                )),
                                    Text(
                                      "Mentee: ${classData.transactions?.isNotEmpty ?? false ? classData.transactions!.map((e) => e.user?.name).join(', ') : 'Belum ada Mentee'}",
                                      style: FontFamily().regularText.copyWith(
                                            fontSize: 12,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  classData.zoomLink ??
                                      'Link Zoom belum tersedia',
                                  style: FontFamily().regularText.copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              IconButton(
                                onPressed: () {
                                  // Menyalin teks ke clipboard
                                  Clipboard.setData(
                                    ClipboardData(
                                        text: classData.zoomLink ?? ''),
                                  );

                                  // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      backgroundColor:
                                          ColorStyle().tertiaryColors,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'Link disalin',
                                        style:
                                            FontFamily().regularText.copyWith(
                                                  fontSize: 12,
                                                ),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
