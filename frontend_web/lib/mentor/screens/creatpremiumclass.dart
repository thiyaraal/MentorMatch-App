import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/widget/custombutton.dart';
import 'package:my_flutter_app/widget/form.dart';

class CreatePremiumClassPage extends StatefulWidget {
  const CreatePremiumClassPage({Key? key}) : super(key: key);

  @override
  _CreatePremiumClassPageState createState() => _CreatePremiumClassPageState();
}

class _CreatePremiumClassPageState extends State<CreatePremiumClassPage> {
  List<String> syaratKetentuanSubtitles = [''];
  String? selectedEducationLevel;
  List<String> currentBidangMinatOptions = []; // Initialize with an empty list

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
              'Buat Kelas',
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
                title: "Tingkat Pendidikan",
                fieldType: CustomFormFieldType.dropdown,
                dropdownItems: ["SD", "SMP", "SMA", "Kuliah", "Karier"],
                onDropdownChanged: _onEducationLevelChanged,
              ),
              CustomForm(
                title: "Bidang & Minat",
                fieldType: CustomFormFieldType.dropdown,
                dropdownItems: currentBidangMinatOptions,
                onDropdownChanged: (String? newValue) {
                  // Handle the dropdown value change for "Bidang & Minat"
                  print("Selected Bidang & Minat: $newValue");
                },
              ),
              CustomForm(title: "Nama Kelas", subtitle: "Bahasa Inggris"),
              CustomForm(title: "Harga", subtitle: "contoh : 500.000,00"),
              CustomForm(
                title: "Periode Kegiatan",
                fieldType: CustomFormFieldType.dropdown,
                dropdownItems: [
                  "3 Bulan",
                  "6 Bulan",
                  "12 Bulan",
                ], // Provide the dropdown options
                onDropdownChanged: (String? newValue) {
                  // Handle the dropdown value change
                  print("Selected Gender: $newValue");
                },
              ),
              CustomForm(
                  title: "Rincian Kegiatan",
                  subtitle:
                      "contoh :  \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore \nmagnanaliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magnanaliqua. Ut enim ad minim veniam, quis nostrud exercitation \nullamco laboris nisi ut aliquip ex ea commodo consequat. "),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Syarat & Ketentuan",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              ...syaratKetentuanSubtitles
                  .map((subtitle) => CustomForm(title: "", subtitle: subtitle))
                  .toList(),
              TextButton(
                onPressed: addNewSyaratKetentuanSubtitle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.blue),
                    Text(
                      "Tambah Syarat & Ketentuan",
                      style: GoogleFonts.poppins(color: Colors.blue),
                    ),
                  ],
                ),
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
