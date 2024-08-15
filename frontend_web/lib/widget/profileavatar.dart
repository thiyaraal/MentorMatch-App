import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

// ignore: must_be_immutable
class ProfileAvatar extends StatefulWidget {
  final String imageUrl;
  double? radius;
  ProfileAvatar({Key? key, required this.imageUrl, this.radius})
      : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 126, // Tingkatkan ukuran untuk mengakomodasi border di luar
        height: 126, // Tingkatkan ukuran untuk mengakomodasi border di luar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              63), // Setengah dari lebar atau tinggi container yang baru
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
            color:
                ColorStyle().tertiaryColors, // Ganti dengan warna yang sesuai
            width: 3,
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/blank_profile.jpg',
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}
