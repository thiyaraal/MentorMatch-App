import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class TimePickerWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final void Function(DateTime time) onTimeSelected;

  TimePickerWidget(
      {Key? key,
      required this.controller,
      required this.onTimeSelected,
      required this.title})
      : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day, // Tidak termasuk tanggal saat ini
        picked.hour,
        picked.minute,
      );
      widget.controller.text = DateFormat.Hm().format(selectedDateTime);
      widget.onTimeSelected(selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              icon: Icon(
                Icons.timer,
                color: ColorStyle().primaryColors,
              ),
              labelText: widget.title,
              labelStyle: FontFamily().regularText),
          readOnly: true,
          onTap: _pickTime,
        ),
      ),
    );
  }
}

class DatePickerClassWidget extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;
  final TextEditingController controller;

  DatePickerClassWidget(
      {required this.onDateSelected,
      required this.controller,
      this.labelText = "Pilih Tanggal"});

  @override
  _DatePickerClassWidgetState createState() => _DatePickerClassWidgetState();
}

class _DatePickerClassWidgetState extends State<DatePickerClassWidget> {
  final TextEditingController selecDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
  final DateTime now = DateTime.now();
  final DateTime firstSelectableDate = now.add(Duration(days: 2));

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate.isBefore(firstSelectableDate)
        ? firstSelectableDate
        : selectedDate,
    firstDate: firstSelectableDate,
    lastDate: DateTime(2050),
  );

  if (picked != null) {
    widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
    widget.onDateSelected(picked);
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              icon: Icon(
                Icons.calendar_today,
                color: ColorStyle().primaryColors,
              ),
              labelText: widget.labelText,
              labelStyle: FontFamily().regularText),
          readOnly: true,
          onTap: () => _selectDate(context),
        ));
    // ElevatedButton(
    //   onPressed: () => _selectDate(context),
    //   child: Text('Pilih Tanggal'),
    // );
  }
}



class DatePickerSessionsWidget extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;
  final TextEditingController controller;

  DatePickerSessionsWidget(
      {required this.onDateSelected,
      required this.controller,
      this.labelText = "Pilih Tanggal"});

  @override
  _DatePickerSessionsWidgetState createState() => _DatePickerSessionsWidgetState();
}

class _DatePickerSessionsWidgetState extends State<DatePickerSessionsWidget> {
  final TextEditingController selecDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstSelectableDate = now.add(Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(firstSelectableDate)
          ? firstSelectableDate
          : selectedDate,
      firstDate: firstSelectableDate,
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
      widget.onDateSelected(picked);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorStyle().tertiaryColors,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              icon: Icon(
                Icons.calendar_today,
                color: ColorStyle().primaryColors,
              ),
              labelText: widget.labelText,
              labelStyle: FontFamily().regularText),
          readOnly: true,
          onTap: () => _selectDate(context),
        ));
    // ElevatedButton(
    //   onPressed: () => _selectDate(context),
    //   child: Text('Pilih Tanggal'),
    // );
  }
}