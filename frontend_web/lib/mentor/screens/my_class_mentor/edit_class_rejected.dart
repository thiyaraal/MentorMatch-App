import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:my_flutter_app/mentor/Screens/create_class_and_session/create_class/contoh_premium_class.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/screens/homepage_mentor.dart';
import 'package:my_flutter_app/mentor/service/edit_pengajuan_class_service_.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field_dropdown.dart';
import 'package:my_flutter_app/widget/time_picker_widget.dart';

import '../../../widget/flushsBar_widget.dart';
import '../../../widget/text_field.dart';

class EditRejectedClass extends StatefulWidget {
  final AllClass classData;
  EditRejectedClass({Key? key, required this.classData}) : super(key: key);

  @override
  State<EditRejectedClass> createState() => _EditRejectedClassState();
}

class _EditRejectedClassState extends State<EditRejectedClass> {
  String selectedLocation = 'Offline';
  String selectedEducationLevel = 'SD';
  List<String> selectedFields = ['bahasa', 'matematika', 'IPA', 'IPS'];
  String selectedField = '';
  Map<String, List<String>> fieldOptions = {
    'SD': ["Matematika", "Bahasa", "Pengetahuan", "Teknologi"],
    'SMP': [
      "Matematika",
      "Bahasa",
      "Teknologi",
      "Biologi",
      "Ekonomi",
      "Fisika",
      "Geografi",
      "Kimia"
    ],
    'SMA': [
      "Matematika",
      "Bahasa",
      "Teknologi",
      "Biologi",
      "Ekonomi",
      "Fisika",
      "Geografi",
      "Kimia"
    ],
    'Kuliah': [
      "Computer Science",
      "Desain",
      "Teknik Elektro",
      "Ilmu Komunikasi",
      "Teknik Informasi",
      "Manajemen",
      "Psikologi",
      "Pendidikan Guru"
    ],
    'Karier': [
      "Back End",
      "Data Analyst",
      "Finance",
      "Marketing",
      "Quality Assurance",
      "Security Engineer",
      "Desain",
      "Front End",
    ],
  };

  bool _isLoading = false;
  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];
  List<String> selectedDays = [];

  TextEditingController scheduleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController maxParticipantsController = TextEditingController();
  TextEditingController educationLevelController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<TextEditingController> targetLearningController = [
    TextEditingController()
  ];
  List<TextEditingController> termsController = [TextEditingController()];
  TextEditingController durationInDaysController = TextEditingController();
  TextEditingController descriptionCobtroller = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  /// delete and add textfield ///
  void deleteTextField(List<TextEditingController> controllers, int index) {
    setState(() {
      // Pastikan untuk memanggil dispose pada controller yang akan dihapus
      controllers[index].dispose();
      // Kemudian hapus controller dari list
      controllers.removeAt(index);
    });
  }

  void addTextField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  //// dispose controller ///
  @override
  void dispose() {
    for (var controller in targetLearningController) {
      controller.dispose();
    }
    // Dispose controllers when widget is removed from the widget tree
    nameController.dispose();
    priceController.dispose();
    durationInDaysController.dispose();
    descriptionCobtroller.dispose();
    for (var controller in termsController) {
      controller.dispose();
    }
    maxParticipantsController.dispose();
    super.dispose();
  }

  ///////////// inistatte?///
  @override
  void initState() {
    super.initState();

    // Inisialisasi untuk text controllers dengan nilai dari classData
    targetLearningController = widget.classData.targetLearning!
        .map((target) => TextEditingController(text: target))
        .toList();
    termsController = widget.classData.terms!
        .map((term) => TextEditingController(text: term))
        .toList();

    // Pengaturan nilai berdasarkan classData
    selectedEducationLevel = widget.classData.educationLevel.toString();
    selectedField = widget.classData.category.toString();
    selectedLocation = widget.classData.location.toString();
    selectedFields = fieldOptions[selectedEducationLevel] ?? [];

    // Memecah schedule menjadi list of selectedDays
    selectedDays = widget.classData.schedule!.split(', ');

    // Mengatur nilai controllers dengan nilai dari classData
    scheduleController.text = widget.classData.schedule.toString();
    locationController.text = widget.classData.location.toString();
    addressController.text = widget.classData.address.toString();
    maxParticipantsController.text =
        widget.classData.maxParticipants.toString();
    nameController.text = widget.classData.name.toString();
    priceController.text = widget.classData.price.toString();
    durationInDaysController.text = widget.classData.durationInDays.toString();
    descriptionCobtroller.text = widget.classData.description.toString();

    // Mengatur nilai startDate dan endDate dengan format yang benar
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if (widget.classData.startDate != null) {
      startDateController.text =
          formatter.format(DateTime.parse(widget.classData.startDate!));
    }
    if (widget.classData.endDate != null) {
      endDateController.text =
          formatter.format(DateTime.parse(widget.classData.endDate!));
    }
  }

///////////////// hari ///

  void showMultiSelect(BuildContext context) async {
    final List<String>? tempSelectedValues = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        // Asumsikan MultiSelectDialog adalah widget dialog yang Anda buat
        // yang memungkinkan pengguna memilih beberapa item
        return MultiSelectDialog(
          items: days.map((day) => MultiSelectItem(day, day)).toList(),
          initialValue: selectedDays,
          onConfirm: (values) {
            // Ini adalah callback yang dipanggil dengan nilai yang dipilih pengguna
          },
        );
      },
    );

    // Memberikan nilai default [] jika hasil dialog adalah null
    final List<String> selectedValues = tempSelectedValues ?? [];

    setState(() {
      selectedDays = selectedValues;
      scheduleController.text = selectedDays.join(', ');
    });
  }

  //// count duration ///
  void calculateDuration() {
    if (startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateTime startDate = formatter.parse(startDateController.text);
      final DateTime endDate = formatter.parse(endDateController.text);
      final int duration = endDate.difference(startDate).inDays +
          1; // Tambahkan 1 untuk termasuk hari terakhir

      if (duration >= 0) {
        durationInDaysController.text = duration.toString();
      } else {
        // Tampilkan pesan error jika endDate lebih awal dari startDate
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "Tanggal selesai harus lebih akhir dari tanggal mulai."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> updateClass() async {
    setState(() {
      _isLoading = true;
    });
    final service = ClassUpdateService();
    String result = await service.updateClass(
      classId: widget.classData.id.toString(),
      educationLevel: selectedEducationLevel,
      category: selectedField,
      name: nameController.text,
      description: descriptionCobtroller.text,
      terms: termsController.map((e) => e.text).toList(),
      targetLearning: targetLearningController.map((e) => e.text).toList(),
      price: int.parse(priceController.text),
      durationInDays: int.parse(durationInDaysController.text),
      startDate: startDateController.text,
      endDate: endDateController.text,
      schedule: scheduleController.text,
      address: addressController.text,
      location: selectedLocation,
      maxParticipants: int.parse(maxParticipantsController.text),
    );

    setState(() {
      _isLoading = false;
    });
    // Tampilkan snackbar dengan hasil
    showTopSnackBar(context, result,
        leftBarIndicatorColor: ColorStyle().succesColors);
    // navigate to home
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MentorHomePage(
                  selectedMenu: "Class",
                )),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Kelas Ditolak',
              style: FontFamily().boldText.copyWith(
                    fontSize: 16,
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
                    Text(
                      'Maaf, permintaan kelas Anda telah ditolak karena tidak memenuhi syarat. Berikut alasan mengapa kelas yang anda ajukan tidak dapat disetujui silahkan perbaiki dan susun kembali pengajuan kelas dibawah ini :',
                      style: FontFamily().regularText,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: ColorStyle().tertiaryColors, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rejected :",
                              style: FontFamily().boldText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().errorColors),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.classData.rejectReason.toString(),
                              style: FontFamily().regularText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevetadButtonWithIcon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContohPremiumClass(),
                            ),
                          );
                        },
                        title: "Lihat Contoh Premium Class",
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TittleTextField(
                      title: "Tingkat Pendidikan",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MyDropdownWidget(
                        initialValue: selectedEducationLevel,
                        items: ['SD', 'SMP', 'SMA', 'Kuliah', 'Karier'],
                        onChanged: (value) {
                          setState(() {
                            selectedEducationLevel = value.toString();
                            selectedFields =
                                fieldOptions[selectedEducationLevel] ?? [];
                            selectedField =
                                ''; // Reset selectedField when education level changes
                          });
                        },
                      ),
                    ),
                    TittleTextField(
                      title: "Bidang & Minat",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MyDropdownWidget(
                        initialValue: selectedField,
                        items: selectedFields,
                        onChanged: (value) {
                          setState(() {
                            selectedField = value.toString();
                          });
                        },
                      ),
                    ),
                    TittleTextField(
                      title: "Nama Kelas",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFieldWidget(
                        controller: nameController,
                        validator: (value) {
                          // Periksa apakah field kosong
                          if (value == null || value.isEmpty) {
                            return 'Field ini tidak boleh kosong';
                          }

                          return null;
                        },
                      ),
                    ),

                    ///// harga ////
                    TittleTextField(
                      title: "Harga",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFieldWidget(
                        controller: priceController,
                        validator: validatorCapacity,
                      ),
                    ),

                    ///kapasitas mentee///
                    TittleTextField(
                      title: "Kapasitas Mentee",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFieldWidget(
                        controller: maxParticipantsController,
                        validator: validatorCapacity,
                      ),
                    ),

                    //startDate///
                    TittleTextField(
                      title: "Tanggal Mulai",
                      color: ColorStyle().secondaryColors,
                    ),
                    DatePickerClassWidget(
                      onDateSelected: (date) {
                        startDateController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                        calculateDuration();
                      },
                      controller: startDateController,
                    ),

                    ///endDate///
                    TittleTextField(
                      title: "Tanggal Selesai",
                      color: ColorStyle().secondaryColors,
                    ),
                    DatePickerClassWidget(
                      onDateSelected: (date) {
                        endDateController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                        calculateDuration();
                      },
                      controller: endDateController,
                    ),
                    //durations////
                    TittleTextField(
                      title: "Periode Kegiatan",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFieldWidget(
                        controller: durationInDaysController,
                        readOnly: true,
                      ),
                    ),
                    //hari ///
                    TittleTextField(
                      title: "Jadwal Hari",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFieldWidget(
                        controller: scheduleController,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        ontap: () => showMultiSelect(context),
                        validator: (value) {
                          // Periksa apakah field kosong
                          if (value == null || value.isEmpty) {
                            return 'Field ini tidak boleh kosong';
                          }

                          return null;
                        },
                      ),
                    ),

                    ////rician kegiatan///
                    TittleTextField(
                      title: "Rincian Kegiatan",
                      color: ColorStyle().secondaryColors,
                    ),
                    TextFieldWidgetBig(
                        title: 'input Rincian Kegiatan',
                        validator: (value) {
                          // Periksa apakah field kosong
                          if (value == null || value.isEmpty) {
                            return 'Field ini tidak boleh kosong';
                          }

                          return null;
                        },
                        descriptionController: descriptionCobtroller),

                    /// Location///
                    TittleTextField(
                      title: "Lokasi",
                      color: ColorStyle().secondaryColors,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: MyDropdownWidget(
                            initialValue: selectedLocation,
                            items: ['Offline', 'Online'],
                            onChanged: (value) {
                              setState(() {
                                selectedLocation = value.toString();
                              });
                            },
                          ),
                        ),
                        if (selectedLocation == "Offline") ...[
                          TittleTextField(
                            title: "Alamat",
                            color: ColorStyle().secondaryColors,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFieldWidget(
                              controller: addressController,
                            ),
                          ),
                        ],
                      ],
                    ),

                    //// target learning///
                    TittleTextField(
                      title: "Target Pembelajaran",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0;
                                i < targetLearningController.length;
                                i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 24),
                                child: TextFieldWidget(
                                  controller: targetLearningController[i],
                                  hintText: 'Input Target Pembelajaran',
                                ),
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: ColorStyle().primaryColors,
                                    ),
                                    onPressed: () => deleteTextField(
                                        targetLearningController,
                                        targetLearningController.length - 1),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: ColorStyle().primaryColors,
                                    ),
                                    onPressed: () =>
                                        addTextField(targetLearningController),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ////syarat ketentuan///
                    TittleTextField(
                      title: "Syarat & Ketentuan",
                      color: ColorStyle().secondaryColors,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < termsController.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 24),
                                child: TextFieldWidget(
                                  controller: termsController[i],
                                  hintText: 'Input Syarat & Ketentuan',
                                ),
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: ColorStyle().primaryColors,
                                    ),
                                    onPressed: () => deleteTextField(
                                        termsController,
                                        termsController.length - 1),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: ColorStyle().primaryColors,
                                    ),
                                    onPressed: () =>
                                        addTextField(termsController),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonWidget(
                          onPressed: () async {
                            await updateClass();
                          },
                          title: "Kirim Ulang Pengajuan Kelas",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //  add loading
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
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
