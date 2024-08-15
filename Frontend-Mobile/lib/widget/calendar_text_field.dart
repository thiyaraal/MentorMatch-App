// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CalendarTextField extends StatefulWidget {
//   @override
//   _CalendarTextFieldState createState() => _CalendarTextFieldState();
// }

// class _CalendarTextFieldState extends State<CalendarTextField> {
//   TextEditingController _dateController = TextEditingController();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015),
//       lastDate: DateTime(2050),
//     );
//     if (picked != null) {
//       _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _dateController,
//       readOnly: true,
//       decoration: InputDecoration(
//         hintText: 'Select a date',
//         suffixIcon: IconButton(
//           icon: Icon(Icons.calendar_today),
//           onPressed: () => _selectDate(context),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../style/color_style.dart';
import '../style/font_style.dart';

class CalendarTextField extends StatefulWidget {
  final Function(String) onDateSelected;

  CalendarTextField({Key? key, required this.onDateSelected}) : super(key: key);
  @override
  _CalendarTextFieldState createState() => _CalendarTextFieldState();
}

class _CalendarTextFieldState extends State<CalendarTextField> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only( bottom: 8.0),
        child: SizedBox(
          height: 38,
          child: TextFormField(
            controller: _dateController,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              hintText: 'Select a date',
              hintStyle: FontFamily().regularText.copyWith(
                color: ColorStyle().disableColors,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
                color: ColorStyle().disableColors, // Adjust color as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
