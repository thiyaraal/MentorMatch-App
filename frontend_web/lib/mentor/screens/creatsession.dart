import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/widget/custombutton.dart';
import 'package:my_flutter_app/widget/form.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({Key? key}) : super(key: key);

  @override
  _CreateSessionPageState createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  List<String> syaratKetentuanSubtitles = [''];
  String? selectedEducationLevel;
  List<String> currentBidangMinatOptions = []; // Initialize with an empty list
  DateTime selectedDate = DateTime.now(); // Added for date picker

  final Map<String, List<String>> bidangMinatOptions = {
    "SD": ["Bahasa", "Ilmu Pengetahuan", "Teknologi Informasi", "Matematika"],
    "SMP": [
      "Bahasa",
      "Fisika",
      "Biologi",
      "Kimia",
      "Matematika",
      "Teknologi",
      "Geografi",
      "Ekonomi"
    ],
    "SMA": [
      "Bahasa",
      "Fisika",
      "Biologi",
      "Kimia",
      "Matematika",
      "Teknologi",
      "Geografi",
      "Ekonomi"
    ],
    "Kuliah": [
      "Sastra Bahasa",
      "Computer Science",
      "Manajemen",
      "Pendidikan Guru",
      "Ilmu Komunikasi",
      "Design",
      "Teknik Elektro",
      "Sistem Informasi",
      "Psikiologi"
    ],
    "Karier": [
      "Front End Engineer",
      "Back End Engineer",
      "Design",
      "Data Analys",
      "Security Engineer",
      "Quality Assurance",
      "Marketing",
      "Finance"
    ],
  };

  void _onEducationLevelChanged(String? newValue) {
    setState(() {
      selectedEducationLevel = newValue;
      // Update the options for "Bidang & Minat" based on the selected education level
      currentBidangMinatOptions = bidangMinatOptions[newValue] ?? [];
    });
  }

  void addNewSyaratKetentuanSubtitle() {
    setState(() {
      syaratKetentuanSubtitles.add('');
    });
  }

  // Method to display date picker and update selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 55.0),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MentorHomePage()));
              },
            ),
            title: Text(
              'Buat Session',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(85.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomForm(
                title: "Topic Session",
                fieldType: CustomFormFieldType.dropdown,
                dropdownItems: [
                  "SD",
                  "SMP",
                  "SMA",
                  "Kuliah",
                  "Karier"
                ], // Provide the dropdown options
                onDropdownChanged: (String? newValue) {
                  // Handle the dropdown value change
                  print("Selected Gender: $newValue");
                },
              ),
              CustomDatePicker(
                title: "Tanggal",
                selectedDate:
                    selectedDate, // Ensure you have a selectedDate variable in your state
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomForm(
                      title: "Mulai",
                      subtitle: "08:00 AM",
                      fieldType: CustomFormFieldType
                          .text, // Assuming a text type for demonstration
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between the two forms
                  Expanded(
                    child: CustomForm(
                      title: "Selesai",
                      subtitle: "10:00 AM",
                      fieldType: CustomFormFieldType
                          .text, // Assuming a text type for demonstration
                    ),
                  ),
                ],
              ),
              CustomForm(
                title: "Kapasitas",
                fieldType: CustomFormFieldType.dropdown,
                dropdownItems: [
                  "150 Peserta",
                  "300 Peserta",
                  "450 Peserta",
                  "600 Peserta",
                  "750 Peserta"
                ], // Provide the dropdown options
                onDropdownChanged: (String? newValue) {
                  // Handle the dropdown value change
                  print("Selected Gender: $newValue");
                },
              ),
              SizedBox(height: 85),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 650,
                    child: CustomButton(
                      buttonText: "Kirim",
                      onPressed: () {
                        // Your onPressed function here
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
