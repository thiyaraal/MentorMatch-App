import 'package:flutter/material.dart';
import 'package:my_flutter_app/Mentee/service/profile_service.dart';
import 'package:my_flutter_app/login/choose_role_service.dart';
import 'package:my_flutter_app/mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileMenteeScreen extends StatefulWidget {
  final List<String> skills;
  final String linkedin;
  final String about;
  final String location;
  final String currentJob;
  final String currentCompany;
  final List<Map<String, String>> experiences;
  final String selectedMenu;
  final String? selectedRole;

  const EditProfileMenteeScreen({
    Key? key,
    required this.skills,
    required this.linkedin,
    required this.about,
    required this.location,
    required this.currentJob,
    required this.currentCompany,
    required this.experiences,
    required this.selectedMenu,
    this.selectedRole,
  }) : super(key: key);

  @override
  _EditProfileMenteeScreenState createState() =>
      _EditProfileMenteeScreenState();
}

class _EditProfileMenteeScreenState extends State<EditProfileMenteeScreen> {
  final ChooseRoleService chooseRoleService = ChooseRoleService();

  final TextEditingController _skillController = TextEditingController();
  List<Map<String, String>> _skills = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _experienceCompanyController =
      TextEditingController();
  bool _isLoading = false;

  String _email = "";
  String _name = "";
  String _photoUrl = "";
  String job = '';
  String company = '';
  List<String> skills = []; // Consider how you'll collect and manage list input
  String location = '';
  String about = '';
  String linkedin = '';
  List<Map<String, String>> experiences = [];

  @override
  void initState() {
    super.initState();
    _skills = widget.skills.map((skill) => {"skill": skill}).toList();
    _linkedinController.text = widget.linkedin;
    _aboutController.text = widget.about;
    _locationController.text = widget.location;
    _jobController.text = widget.currentJob;
    _companyController.text = widget.currentCompany;
    experiences = widget.experiences
        .map((exp) =>
            {'role': exp['jobTitle']!, 'experienceCompany': exp['company']!})
        .toList();
    _loadProfileData();
    _emailController.text = _email;
    _nameController.text = _name;
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

  Future<void> _updateUserProfile() async {
    skills = _skills.map((skill) => skill['skill']!).toList();
    // Instance of ProfileService
    ProfileService profileService = ProfileService();
    await profileService.updateProfile(
      job: _jobController.text,
      company: _companyController.text,
      skills: skills,
      location: _locationController.text,
      about: _aboutController.text,
      linkedin: _linkedinController.text,
      experiences: experiences,
    );
  }

  @override
  void dispose() {
    _skillController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _linkedinController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profileSection(),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _formFields(),
                            const SizedBox(height: 40),
                            Align(
                                alignment: Alignment.topRight,
                                child: _saveButton(context)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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

  Widget _profileSection() {
    return Center(
      child: Column(
        children: [
          ProfileAvatar(imageUrl: _photoUrl, radius: 80),
          Text(_name, style: FontFamily().titleText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        _textFieldWithTitle("Email", _emailController, "Your email",
            enabled: false,
            onChanged: (String value) {},
            validator:
                (String? value) {}), // Assuming you have an email controller
        _textFieldWithTitle("Name", _nameController, "Your name",
            enabled: false,
            onChanged: (String value) {},
            validator:
                (String? value) {}), // Assuming you have a name controller
        _textFieldWithTitle(
          "Job",
          _jobController,
          "Enter Your Job/Position",
          onChanged: (value) {
            setState(() {
              job = value;
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Job cannot be empty";
            }
            return null;
          },
        ),
        _textFieldWithTitle(
          "School/University/Company",
          _companyController,
          "Enter Your School/University/Company",
          onChanged: (value) {
            setState(() {
              company = value;
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Company cannot be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _skillField(),
        _skillChips(),
        const SizedBox(height: 12),
        _textFieldWithTitle(
            "Location", _locationController, "Enter Your Location",
            onChanged: (value) {
          setState(() {
            location = value;
          });
        }, validator: (value) {
          if (value!.isEmpty) {
            return "Location cannot be empty";
          }
          return null;
        }),
        _textFieldWithTitle("About", _aboutController, "Enter Your About",
            onChanged: (value) {
          setState(() {
            about = value;
          });
        }, validator: (value) {
          if (value!.isEmpty) {
            return "About cannot be empty";
          }
          return null;
        }),
        _textFieldWithTitle(
            "LinkedIn", _linkedinController, "Enter Your LinkedIn URL",
            onChanged: (value) {
          setState(() {
            linkedin = value;
          });
        }, validator: (value) {
          if (value!.isNotEmpty) {
            const urlPattern =
                r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
            final urlRegExp = RegExp(urlPattern);

            if (!urlRegExp.hasMatch(value!)) {
              return 'Please enter a valid URL';
            }
          }
          return null;
        }),
        const SizedBox(height: 12),
        _experienceField(),
        _experienceChips(),
      ],
    );
  }

  Widget _textFieldWithTitle(
    String title,
    TextEditingController controller,
    String hint, {
    required ValueChanged<String> onChanged,
    required FormFieldValidator<String> validator,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontFamily().titleTextField,
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          controller: controller,
          hintText: hint,
          onChanged: onChanged,
          validator: validator,
          enabled: enabled,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _skillField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skills",
          style: FontFamily().titleTextField,
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          controller: _skillController,
          hintText: "Enter Your Skill",
          validator: (value) {
            if (value!.isNotEmpty) {
              return "Press the add button to add the skill";
            } else if (_skills.isEmpty) {
              return "You must have at least one skill";
            }
            return null;
          },
        ),
        SizedBox(height: 8),
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

  Widget _experienceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience",
          style: FontFamily().titleTextField,
        ),
        SizedBox(height: 8),
        TextFieldWidget(
          controller: _roleController,
          hintText: "Enter Your Role",
          onChanged: (value) {
            setState(() {});
          },
        ),
        SizedBox(height: 8),
        TextFieldWidget(
          controller: _experienceCompanyController,
          hintText: "Enter Your Company",
          onChanged: (value) {
            setState(() {
              // Trigger a state update to check the conditions
            });
          },
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
        ),
        SizedBox(height: 8),
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
        children: experiences
            .map((experience) => _buildExperienceChip(experience))
            .toList(),
      ),
    );
  }

  Widget _buildExperienceChip(Map<String, String> experience) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: Chip(
        label: Text(
          '${experience['role']} at ${experience['experienceCompany']}',
          style: FontFamily().regularText.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorStyle().primaryColors,
        deleteIcon: const Icon(Icons.close, size: 12),
        onDeleted: () {
          setState(() => experiences.remove(experience));
        },
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return ElevatedButtonWidget(
      title: "Simpan",
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        if (_formKey.currentState!.validate()) {
          if (_skills.isEmpty) {
            showTopSnackBar(context, "You must have at least one skill",
                leftBarIndicatorColor: Colors.red);
            setState(() {
              _isLoading = false;
            });
            return;
          }

          // suruh mengklik tombol add experience jika role dan company terisi
          if (_roleController.text.isNotEmpty ||
              _experienceCompanyController.text.isNotEmpty) {
            showTopSnackBar(context,
                "experiences must be added using add experience button",
                leftBarIndicatorColor: Colors.red);
            setState(() {
              _isLoading = false;
            });
            return;
          }

          // validasi semua field
          if (_jobController.text.isEmpty ||
              _companyController.text.isEmpty ||
              _locationController.text.isEmpty ||
              _aboutController.text.isEmpty) {
            showTopSnackBar(context, "Please fill all required fields",
                leftBarIndicatorColor: Colors.red);
            setState(() {
              _isLoading = false;
            });
            return;
          }

          await _updateUserProfile();
          setState(() {
            _isLoading = false;
          });
          showTopSnackBar(context, 'Profile updated successfully',
              leftBarIndicatorColor: ColorStyle().succesColors);

          if (widget.selectedRole == 'Mentee') {
            await chooseRoleService.chooseRole("Mentee");
          }

          if (widget.selectedMenu == 'Dashboard') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MenteeHomePage()),
              (route) => false,
            );
          } else if (widget.selectedMenu == 'Profile') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProfileMenteeScreen()),
              (route) => false,
            );
          }
        } else {
          showTopSnackBar(context, "Please fill all required fields");
        }
      },
    );
  }
}
