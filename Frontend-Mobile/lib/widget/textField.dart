import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';

import '../style/font_style.dart';

class TextFieldWidget extends StatefulWidget {
  final bool? readOnly;
  final void Function()? ontap;
  final Widget? suffixIcon;
  final String? Function(String?)? validator; // Tambahkan validator
  final String? hintText;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final bool? enabled; // tambahkan properti enabled
  final String? errorText;
  final int? maxLines;

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.formKey,
    this.controller,
    this.enabled = true,
    this.suffixIcon,
    this.errorText,
    this.validator,
    this.ontap,
    this.readOnly,
    this.maxLines,
    Function(String p1)? onChanged, // inisialisasi properti enabled
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          constraints:
              const BoxConstraints(minHeight: 40), // Set a minimum height
          child: TextFormField(
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Set autovalidateMode
            validator: widget.validator,
            readOnly: widget.readOnly ?? false,
            controller: widget.controller,
            enabled: widget.enabled, // gunakan properti enabled
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              hintText: widget.hintText,

              hintStyle: FontFamily().regularText.copyWith(
                    color: ColorStyle().disableColors,
                  ),
              errorText: widget.errorText, // Set error text
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 12.0), // Add padding
            ),
            onTap: widget.ontap,
            maxLines: widget.maxLines,
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }
}

class TextFieldWidgetBig extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator; // Tambahkan validator
  final TextEditingController descriptionController;

  TextFieldWidgetBig(
      {Key? key,
      required this.title,
      required this.descriptionController,
      this.validator})
      : super(key: key);

  @override
  State<TextFieldWidgetBig> createState() => _TextFieldWidgetBigState();
}

class _TextFieldWidgetBigState extends State<TextFieldWidgetBig> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.descriptionController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: ColorStyle().tertiaryColors, // Ganti warna latar belakang
          hintText: widget.title,
          hintStyle: FontFamily().regularText,
        ),
        maxLines: 5,
      ),
    );
  }
}
