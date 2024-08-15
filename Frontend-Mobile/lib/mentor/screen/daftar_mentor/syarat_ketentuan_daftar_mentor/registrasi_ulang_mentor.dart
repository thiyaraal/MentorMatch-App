import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/profile_model.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';
import 'package:mentormatch_apps/mentor/service/profile_service.dart';
import 'package:mentormatch_apps/mentor/service/reregistration_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUlangMentorScreen extends StatefulWidget {
  RegisterUlangMentorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterUlangMentorScreen> createState() =>
      _RegisterUlangMentorScreenState();
}

class _RegisterUlangMentorScreenState extends State<RegisterUlangMentorScreen> {
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
  // experience with role and experienceCompany
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _experienceCompanyController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  bool isLoading = false;

  String _name = "";
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
  // list experience with role and experienceCompany
  List<Map<String, String>> experiences = [];

  /// ambil data profile
  final ProfileService mentorService = ProfileService();

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
    _genderController.text = _selectedGender;
  }

  //  //// dispose controller ///
  @override
  void dispose() {
    _genderController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _linkedinController.dispose();
    _aboutController.dispose();
    _portofolioController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _skillController.dispose();
    _roleController.dispose();
    _experienceCompanyController.dispose();

    super.dispose();
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final profileData = await mentorService.getMentorProfile();

    setState(() {
      _name = prefs.getString('name') ?? "";
      //gender
      _selectedGender = profileData.user!.gender ?? '';
      _jobController.text = profileData.user!.experiences
              ?.firstWhere((element) => element.isCurrentJob == true,
                  orElse: () => ExperienceMentor())
              .jobTitle ??
          '';
      _companyController.text = profileData.user!.experiences
              ?.firstWhere((element) => element.isCurrentJob == true,
                  orElse: () => ExperienceMentor())
              .company ??
          '';
      _locationController.text = profileData.user?.location ?? '';
      _linkedinController.text = profileData.user?.linkedin ?? '';
      _aboutController.text = profileData.user?.about ?? '';
      _portofolioController.text = profileData.user?.portofolio ?? '';
      _accountNumberController.text = profileData.user?.accountNumber ?? '';
      _accountNameController.text = profileData.user?.accountName ?? '';
      _skills.addAll(
          profileData.user?.skills?.map((skill) => {'skill': skill}) ?? []);
      experiences.addAll(profileData.user?.experiences
              ?.where((experience) => experience.isCurrentJob == false)
              .map((exp) => {
                    'role': exp.jobTitle ?? '',
                    'experienceCompany': exp.company ?? ''
                  }) ??
          []);
    });
  }

  void _addSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _skills.add({'skill': _skillController.text});
        _skillController.clear();
      });
    }
  }

  void _addExperience() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        experiences.add({
          'role': _roleController.text,
          'experienceCompany': _experienceCompanyController.text
        });
        _roleController.clear();
        _experienceCompanyController.clear();
      });
    }
  }

  void _updateMentor() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        if (mounted) {
          await MentorUpdateService().updateMentor(
            gender: _selectedGender,
            job: _jobController.text,
            company: _companyController.text,
            location: _locationController.text,
            skills: _skills.map((skill) => skill['skill']!).toList(),
            linkedin: _linkedinController.text,
            portfolio: _portofolioController.text,
            about: _aboutController.text,
            accountNumber: _accountNumberController.text,
            accountName: _accountNameController.text,
            experiences: experiences,
          );

          showTopSnackBar(context, "Registration successful",
              leftBarIndicatorColor: ColorStyle().succesColors);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationFormRegistScreen(),
            ),
            (route) => false,
          );
        }
      } catch (error) {
        print('Error updating mentor profile: $error');
        showTopSnackBar(
          context,
          "Failed to update mentor profile",
          leftBarIndicatorColor: ColorStyle().errorColors,
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Show Snackbar if the form is not valid
      showTopSnackBar(
        context,
        "Semua field harus diisi",
        leftBarIndicatorColor: ColorStyle().errorColors,
      );
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
          padding: const EdgeInsets.all(20),
          children: [
            Image.asset('assets/Handoff/ilustrator/mentor in zoom.png'),
            const SizedBox(height: 24),
            Text(
              'Hello $_name, \nComplete the form to become a mentor',
              style: FontFamily().titleText.copyWith(fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            _formFields(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        _genderDropdownField(),
        _textFieldWithTitle(
          "Job title",
          _jobController,
          "Enter your current job title",
          onChanged: (value) {
            setState(() {
              job = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Job/Title is required';
            }
            return null;
          },
          maxLines: 1,
        ),
        _textFieldWithTitle(
          "Company",
          _companyController,
          "Enter your current company",
          onChanged: (value) {
            setState(() {
              company = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Company is required';
            }
            return null;
          },
          maxLines: 1,
        ),
        _textFieldWithTitle(
          "Location",
          _locationController,
          "Enter Your Location",
          onChanged: (value) {
            setState(() {
              company = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Location is required';
            }
            return null;
          },
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: TittleTextField(
            title: "Rekening Bank",
            color: ColorStyle().secondaryColors,
          ),
        ),
        Padding(
          // Add padding left to the column
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TittleTextField(
                title: "Bank",
                color: ColorStyle().secondaryColors,
              ),
              const TextFieldWidget(
                enabled: false,
                hintText: "BCA",
              ),
              _textFieldWithTitle(
                "Account Name",
                _accountNameController,
                "Enter your account name",
                onChanged: (value) {
                  setState(() {
                    accountName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Account Name is required';
                  }
                  return null;
                },
                maxLines: 1,
              ),
              _textFieldWithTitle(
                "Account Number",
                _accountNumberController,
                "Enter your account number",
                onChanged: (value) {
                  setState(() {
                    accountNumber = value;
                  });
                },
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
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _skillField(),
        _skillChips(),
        const SizedBox(height: 12),
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
        _textFieldWithTitle(
          "About",
          _aboutController,
          "Enter Your About",
          onChanged: (value) {
            setState(() {
              about = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        _textFieldWithTitle(
          "Portofolio",
          _portofolioController,
          "Enter Your portofolio",
          onChanged: (value) {
            setState(() {
              portofolio = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }

            // Regular expression to validate a URL
            const urlPattern =
                r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
            final urlRegExp = RegExp(urlPattern);

            if (!urlRegExp.hasMatch(value)) {
              return 'Please enter a valid URL';
            }

            return null;
          },
          maxLines: 1,
        ),
        _experienceField(),
        _experienceChips(),
        const SizedBox(height: 12),
        _applyButton(),
      ],
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
        TextFieldWidget(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
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
        TextFieldWidget(
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
          maxLines: 1,
        ),
        const SizedBox(height: 8),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TittleTextField(
                title: "Experience", color: ColorStyle().secondaryColors),
          ],
        ),
        TextFieldWidget(
          controller: _roleController,
          hintText: "Role",
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        TextFieldWidget(
          controller: _experienceCompanyController,
          hintText: "Company",
          validator: (value) {
            if (_roleController.text.isNotEmpty &&
                _experienceCompanyController.text.isEmpty) {
              return "role and company must be filled together";
            } else if (_roleController.text.isNotEmpty &&
                _experienceCompanyController.text.isNotEmpty) {
              return "add experience using the add experience button";
            }
            return null;
          },
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              if (_roleController.text.isEmpty ||
                  _experienceCompanyController.text.isEmpty) {
                _formKey.currentState!.validate();
                showTopSnackBar(context, "Please fill all fields",
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
          exp['role']! + " at " + exp['experienceCompany']!,
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
            title: "What your gender", color: ColorStyle().secondaryColors),
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
          hint: const Text("Select Your Gender"),
          style: FontFamily().regularText.copyWith(
                color: ColorStyle().disableColors,
              ),
          //  buat waktu dropdown di klik stylenya sama dengan textfield
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
        ),
      ],
    );
  }

  Widget _applyButton() {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : ElevatedButtonWidget(
              onPressed: () {
                _updateMentor();
              },
              title: "Daftar Ulang",
            ),
    );
  }
}
