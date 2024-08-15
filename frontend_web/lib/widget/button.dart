import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
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

class SmallElevatedButtonWidget extends StatefulWidget {
  final String text;
  final void Function()? onPressed;
  SmallElevatedButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SmallElevatedButtonWidget> createState() =>
      _SmallElevatedButtonWidgetState();
}

class _SmallElevatedButtonWidgetState extends State<SmallElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle().primaryColors,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 12, color: ColorStyle().whiteColors),
        ),
      ),
    );
  }
}

class SmallOutlineButtonWidget extends StatefulWidget {
  final String text;
  final void Function()? onPressed;
  SmallOutlineButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SmallOutlineButtonWidget> createState() =>
      _SmallOutlineButtonWidgetState();
}

class _SmallOutlineButtonWidgetState extends State<SmallOutlineButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorStyle().primaryColors),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 15, color: ColorStyle().primaryColors),
      ),
    );
  }
}

class RegularElevatedButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String text;

  RegularElevatedButtonWidget({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  State<RegularElevatedButtonWidget> createState() =>
      _RegularElevatedButtonWidgetState();
}

class _RegularElevatedButtonWidgetState
    extends State<RegularElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle().primaryColors,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(425, 65), // Atur lebar dan tinggi tombol di sini
        ),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 15, color: ColorStyle().whiteColors),
        ),
      ),
    );
  }
}

class RegularOutlineButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String text;

  RegularOutlineButtonWidget({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  State<RegularOutlineButtonWidget> createState() =>
      _RegularOutlineButtonWidgetState();
}

class _RegularOutlineButtonWidgetState
    extends State<RegularOutlineButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: ColorStyle()
                  .primaryColors), // Atur warna garis pinggir tombol di sini
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(400, 65), // Atur lebar dan tinggi tombol di sini
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: 15,
              color:
                  ColorStyle().primaryColors), // Atur warna teks tombol di sini
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
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
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


class ElevatedButtonWidget2 extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final Color? color;
  const ElevatedButtonWidget2({Key? key, this.onPressed, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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


class SmallElevatedButton2 extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final String title;
  final Color color; // Keep this if you want to allow custom colors
  final TextStyle? style;

  const SmallElevatedButton2({
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