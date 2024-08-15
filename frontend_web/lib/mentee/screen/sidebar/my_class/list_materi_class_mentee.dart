import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class MateriMyClass extends StatefulWidget {
  final List<LearningMaterialMyClass> learningMaterial;
  const MateriMyClass({
    Key? key,
    required this.learningMaterial,
  }) : super(key: key);

  @override
  State<MateriMyClass> createState() => _MateriMyClassState();
}

class _MateriMyClassState extends State<MateriMyClass> {
  final TextEditingController _materiPembelajaranController =
      TextEditingController();
  final TextEditingController _linkMateriPembelajaranController =
      TextEditingController();
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
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
              child: Image.asset(
                'assets/Handoff/ilustrator/empty_learning_material.png',
                height: 300,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 250,
                      maxCrossAxisExtent: 250),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildGridItem(index);
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
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
      ),
    );
  }
}
