import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentor/screens/register_mentor/verification_page.dart';
import 'package:my_flutter_app/mentor/service/register_mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterMentorScreen extends StatefulWidget {
  const RegisterMentorScreen({super.key});

  @override
  State<RegisterMentorScreen> createState() => _RegisterMentorScreenState();
}

class _RegisterMentorScreenState extends State<RegisterMentorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _portofolioController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final List<Map<String, String>> _skills = [];
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _experienceCompanyController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _email = "";
  String _name = "";
  String _photoUrl = "";
  String _selectedGender = '';
  String job = "";
  String company = "";
  String location = "";
  String linkedin = "";
  String about = "";
  String portofolio = "";
  String accountNumber = "";
  String accountName = "";
  List<String> skills = [];
  List<Map<String, String>> experiences = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _jobController.text = job;
    _companyController.text = company;
    _locationController.text = location;
    _linkedinController.text = linkedin;
    _aboutController.text = about;
    _portofolioController.text = portofolio;
    _accountNumberController.text = accountNumber;
    _accountNameController.text = accountName;
    _emailController.text = _email;
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? "";
      _name = prefs.getString('name') ?? "";
      _photoUrl = prefs.getString('photoUrl') ?? "";

      _emailController.text = _email;
      _nameController.text = _name;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _linkedinController.dispose();
    _aboutController.dispose();
    _portofolioController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  void _addSkill() {
    setState(() {
      _skills.add({'skill': _skillController.text});
      _skillController.clear();
    });
  }

  void _addExperience() {
    setState(() {
      experiences.add({
        'role': _roleController.text,
        'experienceCompany': _experienceCompanyController.text
      });
      _roleController.clear();
      _experienceCompanyController.clear();
    });
  }

  Future<void> _registerMentor(BuildContext context) async {
    List<String> skills = _skills.map((skill) => skill['skill']!).toList();

    // Check if any field is empty
    if (_genderController.text.isEmpty ||
        _aboutController.text.isEmpty ||
        _jobController.text.isEmpty ||
        _companyController.text.isEmpty ||
        skills.isEmpty ||
        _locationController.text.isEmpty ||
        _linkedinController.text.isEmpty ||
        _portofolioController.text.isEmpty ||
        experiences.isEmpty ||
        _accountNameController.text.isEmpty ||
        _accountNumberController.text.isEmpty) {
      // Show Snackbar
      showTopSnackBar(
        context,
        "Semua field harus diisi",
        leftBarIndicatorColor: Colors
            .red, // Atur warna indikator kiri ke merah untuk pesan kesalahan
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      // Instance of RegisterMentorService
      RegisterMentorService registerMentorService = RegisterMentorService();
      await registerMentorService.registerMentor(
        gender: _genderController.text,
        job: _jobController.text,
        company: _companyController.text,
        skills: skills,
        location: _locationController.text,
        about: _aboutController.text,
        linkedin: _linkedinController.text,
        portofolio: _portofolioController.text,
        experiences: experiences,
        accountName: _accountNameController.text,
        accountNumber: _accountNumberController.text,
      );

      // Registration successful, show Snackbar
      showTopSnackBar(
        context,
        "Registration successful",
        leftBarIndicatorColor: Colors
            .green, // Atur warna indikator kiri ke hijau untuk pesan sukses
      );
      print('Snackbar shown: Registration successful');

      // Navigate to the verification page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      // Registration failed, show Snackbar
      showTopSnackBar(
        context,
        "Registration failed: ${e.toString()}",
        leftBarIndicatorColor: Colors.red,
      );
      print('Snackbar shown: Registration failed: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, right: 200, left: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete the Form to Become a Mentor',
                        style: FontFamily().titleText.copyWith(fontSize: 24),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "We're excited that you're interested in becoming a mentor! Please complete the form below to apply. Your contribution is invaluable in guiding and supporting our community.",
                        style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              150), // Setengah dari lebar atau tinggi container yang baru
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: ColorStyle()
                                .tertiaryColors, // Ganti dengan warna yang sesuai
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/blank_profile.jpg',
                              fit: BoxFit.cover,
                            ),
                            imageUrl: _photoUrl,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _textFieldWithTitle(
                                "Name", _nameController, "Your name",
                                enabled: false),
                            const SizedBox(
                              height: 12,
                            ),
                            _textFieldWithTitle(
                                "Email", _emailController, "Your email",
                                enabled: false),
                            const SizedBox(
                              height: 12,
                            ),
                            _genderDropdownField(),
                            const SizedBox(
                              height: 12,
                            ),
                            _textFieldWithTitle("Location", _locationController,
                                "Enter your location", onChanged: (value) {
                              setState(() {
                                company = value;
                              });
                            }, validator: (value) {
                              if (value!.isEmpty) {
                                return 'Location is required';
                              }
                              return null;
                            }, maxLines: 1),
                            const SizedBox(
                              height: 12,
                            ),
                            _textFieldWithTitle(
                              "About",
                              _aboutController,
                              "Tell us something about yourself",
                              onChanged: (value) {
                                setState(
                                  () {
                                    about = value;
                                  },
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'About is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Occupation",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xffE78938),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:
                                  120, // Set a fixed height to keep alignment
                              child: _textFieldWithTitle(
                                "Job title",
                                _jobController,
                                "Enter your current job title",
                                onChanged: (value) {
                                  setState(() {
                                    job = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Job/Title is required';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:
                                  120, // Set a fixed height to keep alignment
                              child: _textFieldWithTitle(
                                "Company",
                                _companyController,
                                "Enter your current company",
                                onChanged: (value) {
                                  setState(() {
                                    company = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Company is required';
                                  }
                                  if (_jobController.text.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _skillField(),
                  _skillChips(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Experience",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xffE78938),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _experienceField(),
                  _experienceChips(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Referensi Karier",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xffE78938),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _textFieldWithTitle(
                    "LinkedIn",
                    _linkedinController,
                    "Enter your linkedIn URL",
                    onChanged: (value) {
                      setState(() {
                        linkedin = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'LinkedIn URL is required';
                      }
                      // Regular expression to validate a URL
                      const urlPattern =
                          r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
                      final urlRegExp = RegExp(urlPattern);

                      if (!urlRegExp.hasMatch(value)) {
                        return 'Insert link URL: https://www.linkedin.com/in/yourname';
                      }

                      return null;
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFieldWithTitle(
                    "Portofolio",
                    _portofolioController,
                    "Enter your portofolio URL",
                    onChanged: (value) {
                      setState(() {
                        portofolio = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your portofolio URL';
                      }
                      const urlPattern =
                          r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
                      final urlRegExp = RegExp(urlPattern);

                      if (!urlRegExp.hasMatch(value)) {
                        return 'Insert valid URL Ex: https://www.portofolio.com/yourname';
                      }
                      return null;
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Rekening Bank (BCA)",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xffE78938),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: _textFieldWithTitle(
                              "Account Number",
                              _accountNumberController,
                              "Enter your account number",
                              onChanged: (value) {
                                setState(() {
                                  accountNumber = value;
                                });
                              },
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Account number is required';
                                }
                                final numericRegex = RegExp(r'^[0-9]+$');
                                if (!numericRegex.hasMatch(value)) {
                                  return 'Please enter a valid number';
                                }
                                // check space
                                if (value.contains(' ')) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: _textFieldWithTitle(
                              "Account Name",
                              _accountNameController,
                              "Enter your account name",
                              onChanged: (value) {
                                setState(() {
                                  accountName = value;
                                });
                              },
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Account Name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _applyButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldWithTitle(
      String title, TextEditingController controller, String hintText,
      {bool enabled = true,
      Function(String)? onChanged,
      int? maxLines,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(title: title, color: ColorStyle().secondaryColors),
        const SizedBox(
          height: 8,
        ),
        TextFieldWidget(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged, // Add this line
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _skillField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TittleTextField(
                title: "Skill", color: ColorStyle().secondaryColors),
          ],
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          maxLines: 1,
          controller: _skillController,
          hintText: "Skill",
          validator: (value) {
            if (value!.isNotEmpty) {
              return "Press the add button to add the skill";
            } else if (_skills.isEmpty) {
              return "You must have at least one skill";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              if (_skillController.text.isEmpty) {
                _formKey.currentState!.validate();
                showTopSnackBar(context, "Please enter a skill",
                    leftBarIndicatorColor: Colors.red);
              } else if (_skills
                  .any((skill) => skill['skill'] == _skillController.text)) {
                showTopSnackBar(context, "Skill already added",
                    leftBarIndicatorColor: Colors.red);
              } else {
                _addSkill();
              }
            },
            icon: const Icon(Icons.add, size: 16),
            label: Text("Add Skill", style: FontFamily().regularText),
          ),
        ),
      ],
    );
  }

  Widget _skillChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _skills.map((skill) => _buildSkillChip(skill)).toList(),
      ),
    );
  }

  Widget _buildSkillChip(Map<String, String> skill) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: Chip(
        label: Text(
          skill['skill']!,
          style: FontFamily().regularText.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorStyle().primaryColors,
        deleteIcon: const Icon(Icons.close, size: 12),
        onDeleted: () {
          setState(() => _skills.remove(skill));
        },
      ),
    );
  }

  Widget _experienceField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TittleTextField(
                      title: "Role", color: ColorStyle().secondaryColors),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    controller: _roleController,
                    hintText: "Enter your experience role",
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TittleTextField(
                      title: "Company", color: ColorStyle().secondaryColors),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    controller: _experienceCompanyController,
                    hintText: "Enter your experience company",
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              if (_roleController.text.isEmpty ||
                  _experienceCompanyController.text.isEmpty) {
                _formKey.currentState!.validate();
                showTopSnackBar(context, "Role and Company must be filled",
                    leftBarIndicatorColor: Colors.red);
              } else {
                _addExperience();
              }
            },
            icon: const Icon(Icons.add, size: 16),
            label: Text("Add Experience", style: FontFamily().regularText),
          ),
        ),
      ],
    );
  }

  Widget _experienceChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: experiences.map((exp) => _buildExperienceChip(exp)).toList(),
      ),
    );
  }

  Widget _buildExperienceChip(Map<String, String> exp) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: Chip(
        label: Text(
          "${exp['role']!} at ${exp['experienceCompany']!}",
          style: FontFamily().regularText.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorStyle().primaryColors,
        deleteIcon: const Icon(Icons.close, size: 12),
        onDeleted: () {
          setState(() => experiences.remove(exp));
        },
      ),
    );
  }

  Widget _genderDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(
          title: "Gender",
          color: ColorStyle().secondaryColors,
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<String>(
          value: _selectedGender.isEmpty ? null : _selectedGender,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorStyle().tertiaryColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
          hint: const Text("Select your gender"),
          style: FontFamily().regularText.copyWith(
                color: ColorStyle().disableColors,
              ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
              _genderController.text =
                  newValue; // Update the controller if needed
            });
          },
          items: <String>['Pria', 'Wanita']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your gender';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _applyButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: isLoading
          ? const CircularProgressIndicator()
          : ElevatedButtonWidget(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _registerMentor(context);
                }
              },
              title: 'Daftar',
            ),
    );
  }
}
