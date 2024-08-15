import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:my_flutter_app/mentor/Screens/create_class_and_session/create_class/contoh_premium_class.dart';
import 'package:my_flutter_app/mentor/Screens/create_class_and_session/create_class/succes_create_class.dart';
import 'package:my_flutter_app/mentor/provider/create_class_provider.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:my_flutter_app/widget/text_field_dropdown.dart';
import 'package:my_flutter_app/widget/time_picker_widget.dart';
import 'package:provider/provider.dart';

class FormCreatePremiumClassScreen extends StatefulWidget {
  const FormCreatePremiumClassScreen({super.key});

  @override
  State<FormCreatePremiumClassScreen> createState() =>
      _FormCreatePremiumClassScreenState();
}

class _FormCreatePremiumClassScreenState
    extends State<FormCreatePremiumClassScreen> {
  bool _isLoading = false;
  String selectedLocation = 'Offline';
  /////////////////////// Dropdown Widget ///////////////////////
  String selectedEducationLevel = '';
  List<String> selectedFields = [];
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

  List<String> selectedDaysList = [];

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

  List<String> getDaysInRange(DateTime start, DateTime end) {
    List<String> days = [];
    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      String day = DateFormat('EEEE').format(currentDate);
      if (!days.contains(day)) {
        days.add(day);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return days;
  }

  void showMultiSelect(BuildContext context) {
    if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
      showTopSnackBar(
          context, 'Isi tanggal mulai dan tanggal selesai terlebih dahulu',
          leftBarIndicatorColor: ColorStyle().errorColors);

      return;
    }

    DateTime startDate =
        DateFormat('yyyy-MM-dd').parse(startDateController.text);
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(endDateController.text);
    List<String> validDays = getDaysInRange(startDate, endDate);

    // Sort validDays in order: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    List<String> daysOrder = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    validDays.sort((a, b) {
      return daysOrder.indexOf(a) - daysOrder.indexOf(b);
    });

    validDays = validDays.map((day) {
      switch (day) {
        case 'Monday':
          return 'Senin';
        case 'Tuesday':
          return 'Selasa';
        case 'Wednesday':
          return 'Rabu';
        case 'Thursday':
          return 'Kamis';
        case 'Friday':
          return 'Jumat';
        case 'Saturday':
          return 'Sabtu';
        case 'Sunday':
          return 'Minggu';
        default:
          return day;
      }
    }).toList();

    showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          confirmText: Text(
            'OK',
            style: FontFamily().boldText.copyWith(
                  fontSize: 16,
                  color: ColorStyle().primaryColors,
                ),
          ),
          cancelText: Text(
            'Cancel',
            style: FontFamily().boldText.copyWith(
                  fontSize: 16,
                  color: ColorStyle().primaryColors,
                ),
          ),
          items: validDays
              .map((day) => MultiSelectItem<String>(day, day))
              .toList(),
          initialValue: scheduleController.text.isEmpty
              ? []
              : scheduleController.text
                  .split(', ')
                  .map((e) => e.trim())
                  .toList(),
          onConfirm: (values) {
            List selectedDays = values.map((day) {
              switch (day) {
                case 'Senin':
                  return 'Monday';
                case 'Selasa':
                  return 'Tuesday';
                case 'Rabu':
                  return 'Wednesday';
                case 'Kamis':
                  return 'Thursday';
                case 'Jumat':
                  return 'Friday';
                case 'Sabtu':
                  return 'Saturday';
                case 'Minggu':
                  return 'Sunday';
                default:
                  return day;
              }
            }).toList();

            selectedDays.sort((a, b) {
              return daysOrder.indexOf(a) - daysOrder.indexOf(b);
            });

            List sortedDays = selectedDays.map((day) {
              switch (day) {
                case 'Monday':
                  return 'Senin';
                case 'Tuesday':
                  return 'Selasa';
                case 'Wednesday':
                  return 'Rabu';
                case 'Thursday':
                  return 'Kamis';
                case 'Friday':
                  return 'Jumat';
                case 'Saturday':
                  return 'Sabtu';
                case 'Sunday':
                  return 'Minggu';
                default:
                  return day;
              }
            }).toList();

            setState(() {
              scheduleController.text = sortedDays.join(', ');
              selectedDaysList = sortedDays.cast<String>();
            });
          },
        );
      },
    );
  }

  void onSubmit(BuildContext context) async {
    try {
      // Set isLoading to true to show loading indicator
      setState(() {
        _isLoading = true;
      });

      int capacitymentee = 0;
      if (maxParticipantsController.text.isNotEmpty) {
        capacitymentee = int.parse(maxParticipantsController.text);
      }

      /// Check if all required fields are filled
      if (selectedEducationLevel.isEmpty ||
          selectedField.isEmpty ||
          nameController.text.isEmpty ||
          priceController.text.isEmpty ||
          durationInDaysController.text.isEmpty ||
          descriptionCobtroller.text.isEmpty ||
          selectedDaysList.isEmpty ||
          (selectedLocation == 'Offline' && addressController.text.isEmpty) ||
          capacitymentee == 0 ||
          startDateController.text.isEmpty ||
          endDateController.text.isEmpty ||
          targetLearningController
              .any((controller) => controller.text.isEmpty) ||
          termsController.any((controller) => controller.text.isEmpty)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Error",
                style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors,
                      fontSize: 16,
                    ),
              ),
              content: Text(
                "Semua field harus diisi",
                style: FontFamily().regularText,
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Using Provider to call submitClass method from CreateClassProvider dan final errorMessage = createClassProvider.getErrorMessage, 200
      final createClassProvider =
          Provider.of<CreateClassProvider>(context, listen: false);
      final isSubmitted = await createClassProvider.submitClass(
        context: context,
        address: addressController.text,
        targetLearning: targetLearningController
            .map((controller) => controller.text)
            .toList(),
        schedule: scheduleController.text,
        location: selectedLocation,
        endDate: DateFormat('yyyy-MM-dd').parse(endDateController.text),
        startDate: DateFormat('yyyy-MM-dd').parse(startDateController.text),
        capacitymentee: capacitymentee,
        educationLevel: selectedEducationLevel,
        category: selectedField,
        name: nameController.text,
        description: descriptionCobtroller.text,
        terms: termsController.map((controller) => controller.text).toList(),
        price: int.parse(priceController.text),
        durationInDays: int.parse(durationInDaysController.text),
      );

      /// ketika isSubmitted true maka akan diarahkan ke halaman succes create class kalau gagal maka tampilkan error message final errorMessage = createClassProvider.getErrorMessage//
      if (isSubmitted) {
        Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => SuccesCreateClassScreen()),
            (route) => false);
      }
      //// jika gagal maka tampilkan error message ///
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    } finally {
      // Set isLoading to false after submit process finished
      setState(() {
        _isLoading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create Premium Class",
              style: FontFamily().regularText.copyWith(
                    fontSize: 16,
                    color: ColorStyle().primaryColors,
                  ))),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 32, right: 32, bottom: 12),
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
                        'Buat Kelas Mentoring Anda Sendiri dan temukan kesempatan untuk membimbing serta mendukung orang lain dalam mencapai tujuan mereka. Jadilah sumber inspirasi bagi mereka yang mencari bimbingan dan arahan .',
                        style: FontFamily().regularText,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 400,
                        child: ElevetadButtonWithIcon(
                          title: 'Panduan Pembuatan Kelas',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContohPremiumClass(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Tingkat Pendidikan",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyDropdownWidget(
                    items: const ['SD', 'SMP', 'SMA', 'Kuliah', 'Karier'],
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Bidang & Minat",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (selectedEducationLevel.isEmpty) {
                        showTopSnackBar(
                          context,
                          'Silakan pilih tingkat pendidikan terlebih dahulu',
                          leftBarIndicatorColor: ColorStyle().errorColors,
                        );
                      }
                    },
                    child: MyDropdownWidget(
                      items: selectedFields,
                      onChanged: (value) {
                        setState(() {
                          selectedField = value.toString();
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Nama Kelas",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: nameController,
                    hintText: "input nama kelas",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Harga",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: priceController,
                    hintText: "input harga",
                    validator: validatorCapacity,
                  ),
                ),

                ///kapasitas mentee///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Kapasitas Mentee",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: maxParticipantsController,
                    hintText: "input kapasitas mentee",
                    validator: validatorCapacity,
                  ),
                ),

                //startDate///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Tanggal Mulai",
                    color: ColorStyle().secondaryColors,
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Tanggal Selesai",
                    color: ColorStyle().secondaryColors,
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Periode Kegiatan",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: durationInDaysController,
                    hintText: 'Periode kelas',
                    readOnly: true,
                  ),
                ),
                //hari ///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Jadwal Hari",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: scheduleController,
                    hintText: "input jadwal hari",
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    ontap: () => showMultiSelect(context),
                    validator: (value) {
                      // Periksa apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Field ini tidak boleh kosong';
                      }

                      return null;
                    },
                    readOnly: true,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TittleTextField(
                        title: "Rincian Kegiatan",
                        color: ColorStyle().secondaryColors,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContohPremiumClass(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.help,
                          color: ColorStyle().secondaryColors,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFieldWidgetBig(
                    title: 'Deskripsi Kegiatan',
                    validator: (value) {
                      // Periksa apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Field ini tidak boleh kosong';
                      }

                      return null;
                    },
                    descriptionController: descriptionCobtroller),

                /// Location///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TittleTextField(
                    title: "Lokasi",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MyDropdownWidget(
                        items: const ['Offline', 'Online'],
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value.toString();
                          });
                        },
                      ),
                    ),
                    if (selectedLocation == "Offline") ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TittleTextField(
                          title: "Alamat",
                          color: ColorStyle().secondaryColors,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFieldWidget(
                          controller: addressController,
                          hintText: "input alamat ",
                        ),
                      ),
                    ],
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TittleTextField(
                        title: "Target Pembelajaran",
                        color: ColorStyle().secondaryColors,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContohPremiumClass(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.help,
                          color: ColorStyle().secondaryColors,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
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
                                const EdgeInsets.only(top: 8.0, bottom: 12),
                            child: TextFieldWidget(
                              validator: (value) {
                                // Periksa apakah field kosong
                                if (value == null || value.isEmpty) {
                                  return 'Field ini tidak boleh kosong';
                                }

                                return null;
                              },
                              controller: targetLearningController[i],
                              hintText: "input target pembelajaran",
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                      ],
                    ),
                  ),
                ),
                ////syarat ketentuan///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TittleTextField(
                        title: "Syarat & Ketentuan",
                        color: ColorStyle().secondaryColors,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContohPremiumClass(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.help,
                          color: ColorStyle().secondaryColors,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
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
                                const EdgeInsets.only(top: 8.0, bottom: 12),
                            child: TextFieldWidget(
                              validator: (value) {
                                // Periksa apakah field kosong
                                if (value == null || value.isEmpty) {
                                  return 'Field ini tidak boleh kosong';
                                }

                                return null;
                              },
                              controller: termsController[i],
                              hintText: "input syarat & ketentuan",
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: ColorStyle().primaryColors,
                              ),
                              onPressed: () => deleteTextField(
                                  termsController, termsController.length - 1),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: ColorStyle().primaryColors,
                              ),
                              onPressed: () => addTextField(termsController),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: ColorStyle()
                              .secondaryColors) // Tampilkan CircularProgressIndicator jika isLoading true
                      : ElevatedButtonWidget(
                          onPressed: () => onSubmit(context),
                          title: "Kirim Pengajuan",
                        ),
                )
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
