import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/provider/create_session_provider.dart';
import 'package:mentormatch_apps/mentor/screen/create_class_and_session/success_create_session.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:mentormatch_apps/widget/text_field_dropdown.dart';
import 'package:mentormatch_apps/widget/time_picker_widget.dart';
import 'package:provider/provider.dart';

class FormCreateSessionScreen extends StatefulWidget {
  FormCreateSessionScreen({Key? key}) : super(key: key);

  @override
  State<FormCreateSessionScreen> createState() =>
      _FormCreateSessionScreenState();
}

class _FormCreateSessionScreenState extends State<FormCreateSessionScreen> {
  bool _isLoading = false;
  TextEditingController topicController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

///////////dropdown/////
  List<String> selectedFields = [
    "Back End",
    "Data Analyst",
    "Finance",
    "Marketing",
    "Quality Assurance",
    "Security Engineer",
    "Desain",
    "Front End",
  ];

  @override
  void dispose() {
    categoryController.dispose();
    topicController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    capacityController.dispose();
    descriptionController.dispose();
    endTimeController.dispose();

    super.dispose();
  }

  void submitSession() async {
    DateTime? date;
    DateTime startTime;
    DateTime endTime;

    try {
      setState(() {
        _isLoading = true;
      });

      // Parse date from the dateController
      date = DateFormat('yyyy-MM-dd').parse(dateController.text);

      // Parse String time from startTimeController and endTimeController into DateTime objects
      DateTime selectedDate =
          DateFormat('yyyy-MM-dd').parse(dateController.text);
      DateTime startTimeParsed =
          DateFormat.Hm().parse(startTimeController.text);
      DateTime endTimeParsed = DateFormat.Hm().parse(endTimeController.text);

      // Combine selectedDate with parsed times to get the full DateTime objects
      startTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, startTimeParsed.hour, startTimeParsed.minute);
      endTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, endTimeParsed.hour, endTimeParsed.minute);
    } catch (e) {
      // Stop showing CircularProgressIndicator and show Snackbar for required fields
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua field harus diisi')));
      return;
    }

    // Check if all text fields are filled
    if (categoryController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        topicController.text.isEmpty ||
        dateController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      // If any text field is empty, show top snackbar with the message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Semua field harus diisi'),
        behavior: SnackBarBehavior.floating,
      ));
      // Stop showing CircularProgressIndicator
      setState(() {
        _isLoading = false;
      });
      return;
    }

    bool success =
        await Provider.of<CreateSessionProvider>(context, listen: false)
            .submitSession(
      context: context,
      category: categoryController.text,
      date: date,
      startTime: startTime,
      endTime: endTime,
      maxParticipants: int.tryParse(capacityController.text) ?? 0,
      description: descriptionController.text,
      title: topicController.text,
    );

    // Check if success and if there was no error already handled by provider
    if (success && context != null && ScaffoldMessenger.of(context).mounted) {
      // Navigation is only done if context is available and still mounted
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SuccesCreateSessionScreen()),
        (route) => false,
      );
    } else {
      // Stop showing CircularProgressIndicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Session",
          style: FontFamily().regularText.copyWith(
                fontSize: 20,
                color: ColorStyle().primaryColors,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buat Pengalaman Mentorship Anda",
                        style: FontFamily().boldText.copyWith(
                              fontSize: 24,
                              color: ColorStyle().secondaryColors,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Buat Sesi Anda Sendiri dan jelajahi peluang untuk membimbing dan mendukung orang lain dalam mencapai tujuan mereka. Jadilah sumber inspirasi bagi mereka yang mencari bimbingan dan arahan',
                        style: FontFamily().regularText,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Topic Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidget(
                  controller: topicController,
                  hintText: "input your topic session",
                  validator: (value) {
                    // Periksa apakah field kosong
                    if (value == null || value.isEmpty) {
                      return 'Field ini tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                TittleTextField(
                  title: "Category Session",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyDropdownWidgetSession(
                    items: selectedFields,
                    selectedValue: categoryController.text.isNotEmpty
                        ? categoryController.text
                        : null,
                    onChanged: (value) {
                      setState(() {
                        categoryController.text = value ?? '';
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Description Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidgetBig(
                  descriptionController: descriptionController,
                  title: "input your description session",
                  validator: (value) {
                    // Periksa apakah field kosong
                    if (value == null || value.isEmpty) {
                      return 'Field ini tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Tanggal Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                DatePickerSessionsWidget(
                  controller: dateController,
                  onDateSelected: (date) {
                    dateController.text = DateFormat('yyyy-MM-dd').format(date);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Jadwal Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Row(
                  children: [
                    TimePickerWidget(
                      title: "Start Time",
                      onTimeSelected: (time) {
                        print(time); // Pastikan bahwa ini adalah objek DateTime
                        startTimeController.text = DateFormat.Hm().format(time);
                      },
                      controller: startTimeController,
                    ),
                    TimePickerWidget(
                      title: "End Time",
                      onTimeSelected: (time) {
                        print(time); // Pastikan bahwa ini adalah objek DateTime
                        endTimeController.text = DateFormat.Hm().format(time);
                      },
                      controller: endTimeController,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "capacity Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidget(
                  hintText: "input your capacity session",
                  controller: capacityController,
                  validator: validatorCapacity,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButtonWidget(
                          onPressed: () {
                            submitSession();
                          },
                          title: "Kirim",
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String? validatorCapacity(String? value) {
    // Pertama, periksa apakah value null atau tidak, karena parameter bertipe String?
    if (value == null || value.isEmpty) {
      return 'tidak boleh kosong';
    }
    // Gunakan ekspresi reguler untuk memeriksa apakah value hanya berisi angka
    final isDigitsOnly = RegExp(r'^\d+$').hasMatch(value);
    if (!isDigitsOnly) {
      return ' hanya boleh berisi angka';
    }
    return null;
  }
}
