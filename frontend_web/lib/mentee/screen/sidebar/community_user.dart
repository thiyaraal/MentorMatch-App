import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/admin/service/community_service.dart';
import 'package:my_flutter_app/widget/community_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../admin/model/community_model.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late Future<CommunityModels> _communityModelsFuture;

  @override
  void initState() {
    super.initState();
    _communityModelsFuture = CommunityService().fetchCommunities();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CommunityModels>(
        future: _communityModelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery.of(context).size.height / 2.0,
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData &&
              snapshot.data!.communities!.isNotEmpty) {
            // Check for non-empty data
            List<Community> communities = snapshot.data!.communities!;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mari bergabung di dalam\nKomunitas kami",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Dengan bergabung kedalam komunitas\nkamu akan mendapatkan banyak\npengetahuan dan dapat berinteraksi\ndengan sesama rekan ataupun mentor\nkamu",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 200,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SizedBox(
                            width: 400,
                            child: Image.asset(
                              'assets/Handoff/community.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: ColorStyle().disableColors,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Row(
                        children: List.generate(communities.length, (index) {
                      return CardCommunity(
                        title: communities[index].name ?? '',
                        imagePath: communities[index].imageUrl ?? '',
                        onPressed: () {
                          _launchURL(communities[index].link ?? '');
                        },
                      );
                    })),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No Community Data'));
          }
        });
  }
}
