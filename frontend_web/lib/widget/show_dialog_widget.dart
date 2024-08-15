import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class CustomConfirmationDialog extends StatelessWidget {
  final String aksi;
  final String aksi2;
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomConfirmationDialog({
    Key? key,
    required this.aksi,
    required this.aksi2,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: FontFamily().boldText.copyWith(
                fontSize: 18,
                color: ColorStyle().secondaryColors,
              )),
      content: Text(content,
          style: FontFamily().regularText.copyWith(
                fontSize: 14,
              )),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            aksi2,
            style: FontFamily().regularText.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            aksi,
            style: FontFamily()
                .boldText
                .copyWith(color: ColorStyle().primaryColors, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
