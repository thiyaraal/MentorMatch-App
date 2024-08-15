import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/community_model.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/create_community_admin.dart';
import 'package:my_flutter_app/admin/service/community_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/community_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({Key? key}) : super(key: key);

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Community List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewCommunityScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add, color: ColorStyle().whiteColors),
                label: Text(
                  'Add Community',
                  style: TextStyle(
                    color: ColorStyle().whiteColors,
                    fontSize: 12,
                    fontFamily: FontFamily().titleText.fontFamily,
                  ),
                ),
                // style
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle().primaryColors,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<CommunityModels>(
          future: _communityModelsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (snapshot.hasData &&
                snapshot.data!.communities!.isNotEmpty) {
              // Check for non-empty data
              List<Community> communities = snapshot.data!.communities!;

              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: communities.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CardCommunity(
                          title: communities[index].name ?? '',
                          imagePath: communities[index].imageUrl ?? '',
                          onPressed: () {
                            _launchURL(communities[index].link ?? '');
                          });
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text('No Community Data'));
            }
          },
        ),
      ],
    );
  }
}
