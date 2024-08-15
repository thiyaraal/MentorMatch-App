import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';


class ElevatedButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final Color? color;
  const ElevatedButtonWidget({Key? key, this.onPressed, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 396,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorStyle().primaryColors)),

        onPressed: onPressed,
        // },
        child: Text(
          title!,
          style: FontFamily().buttonText.copyWith(
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}



class OutlineButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final Color? color;
  const OutlineButtonWidget({Key? key, this.onPressed, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 396,
      height: 48,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Color(0xffE78938)), // Warna garis outline
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title!,
          style: FontFamily()
              .buttonText
              .copyWith(color: ColorStyle().primaryColors),
        ),
      ),
    );
  }
}

/////////////////////////////////////// SMALL BUTTON /////////////////////////

/////Elevated Button////////

class SmallElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final String title;
  final Color color; // Keep this if you want to allow custom colors
  final TextStyle? style;

  const SmallElevatedButton({
    Key? key,
    this.onPressed,
    this.title = "", // Provide a default value for title
    this.color = Colors.blue, // This will be overridden if not used
    this.style, // You may provide a default style or handle it in the build method
    this.height = 32,
    this.width = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color to use, defaulting to ColorStyle().primaryColors if color is Colors.blue
    final buttonColor = color == Colors.blue
        ? MaterialStateProperty.all<Color>(ColorStyle().primaryColors)
        : MaterialStateProperty.all<Color>(color);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          backgroundColor: buttonColor, // Use the determined color
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: style, // Use the provided style or a default one
        ),
      ),
    );
  }
}

/////otline Button////////

class SmallOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final String title;
  final Color color;
  final TextStyle? style;

  const SmallOutlinedButton({
    Key? key,
    this.onPressed,
    this.title = "",
    this.color = Colors.blue,
    this.style,
    this.height = 32,
    this.width = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
                color: ColorStyle().primaryColors), // Set the border color
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

/////////////////////////////////////// BUTTON DETAIL /////////////////////////
class ButtonDetailKegiatan extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback? onTap;

  const ButtonDetailKegiatan({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorStyle().primaryColors,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(firstText, style: FontFamily().buttonText),
              SizedBox(width: 8.0),
              Text(secondText, style: FontFamily().buttonText),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ColorStyle().whiteColors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonEducationLevels extends StatefulWidget {
  final String title;
  final Function() onPressed;
  ButtonEducationLevels(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  State<ButtonEducationLevels> createState() => _ButtonEducationLevelsState();
}

class _ButtonEducationLevelsState extends State<ButtonEducationLevels> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 4.0),
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // warna bayangan
              spreadRadius: 0, // jarak penyebaran bayangan
              blurRadius: 5, // intensitas blur bayangan
              offset: Offset(0, 3), // posisi bayangan (horizontal, vertical)
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.title,
            style: FontFamily()
                .buttonText
                .copyWith(color: ColorStyle().secondaryColors),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyle().tertiaryColors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}

class ElevetadButtonWithIcon extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  ElevetadButtonWithIcon(
      {Key? key, required this.title, required this.onPressed, this.color})
      : super(key: key);

  @override
  State<ElevetadButtonWithIcon> createState() => _ElevetadButtonWithIconState();
}

class _ElevetadButtonWithIconState extends State<ElevetadButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(8), // Sesuaikan border radius menjadi 8
        // Tambahkan border jika perlu
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.color ??
              ColorStyle()
                  .primaryColors), // Gunakan properti color jika tersedia, jika tidak gunakan warna default
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.only( top :12.0, bottom: 12.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: FontFamily().buttonText.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
