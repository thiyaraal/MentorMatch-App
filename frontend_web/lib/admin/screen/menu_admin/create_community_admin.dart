import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/screen/dasboard_admin_screen.dart';
import 'package:my_flutter_app/admin/service/community_service.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class CreateNewCommunityScreen extends StatefulWidget {
  CreateNewCommunityScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewCommunityScreen> createState() =>
      _CreateNewCommunityScreenState();
}

class _CreateNewCommunityScreenState extends State<CreateNewCommunityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  Future<void> createCommunity() async {
    String name = nameController.text;
    String link = linkController.text;
    String imageUrl = imageUrlController.text;

    try {
      await CommunityService().createCommunity(
        name: name,
        link: link,
        imageUrl: imageUrl,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Community created successfully'),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => DashboardAdminScreen(
                  selectedMenu: 'Community',
                )),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create Community: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Community',
          style: FontFamily().titleText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 24,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TittleTextField(
                  title: 'New Community Name',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                TextFieldWidget(
                  hintText: "Community Name",
                  controller: nameController,
                ),
                TittleTextField(
                  title: 'Link Community',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                TextFieldWidget(
                  hintText: "Community Link",
                  controller: linkController,
                ),
                TittleTextField(
                  title: 'Community Image Link',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                TextFieldWidget(
                  hintText: "image Link",
                  controller: imageUrlController,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: RegularElevatedButtonWidget(
                    text: "Create",
                    onPressed: createCommunity,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
