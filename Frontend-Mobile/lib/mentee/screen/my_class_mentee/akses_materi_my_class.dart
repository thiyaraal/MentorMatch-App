import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterMyClass extends StatefulWidget {
  final List<LearningMaterialMyClass> learningMaterial;
  const MaterMyClass({
    Key? key,
    required this.learningMaterial,
  }) : super(key: key);

  @override
  State<MaterMyClass> createState() => _MaterMyClassState();
}

class _MaterMyClassState extends State<MaterMyClass> {
  final TextEditingController _materiPembelajaranController =
      TextEditingController();
  final TextEditingController _linkMateriPembelajaranController =
      TextEditingController();

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  @override
  void dispose() {
    _materiPembelajaranController.dispose();
    _linkMateriPembelajaranController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Materi Pembelajaran",
            style: FontFamily()
                .titleText
                .copyWith(color: ColorStyle().primaryColors),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => NotificationMenteeScreen(),
              //   ),
              // );
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ColorStyle().secondaryColors,
            ),
          ),
        ],
      )),
      body: widget.learningMaterial.isEmpty
          ? Center(
              child: Text(
                "Materials are currently empty",
                style: FontFamily().regularText,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3.5,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildGridItem(index),
                      );
                    },
                    childCount: widget.learningMaterial.length,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildGridItem(int materialIndex) {
    // Kode untuk membangun tiap item di grid
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: ColorStyle().tertiaryColors,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Materi ${materialIndex + 1}",
                  style: FontFamily().boldText),
            ),
            const SizedBox(
              height: 8,
            ),
            Image.asset('assets/Handoff/icon/MyClass/materi_icon.png'),
            const SizedBox(
              height: 8,
            ),
            Text(widget.learningMaterial[materialIndex].title ?? '',
                style: FontFamily().regularText),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorStyle().secondaryColors),
              ),
              onPressed: () {
                final linkEvaluasi =
                    widget.learningMaterial[materialIndex].link ?? '';
                _launchURL(linkEvaluasi);
              },
              child: Text(
                'Lihat Materi',
                style: FontFamily().buttonText.copyWith(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
