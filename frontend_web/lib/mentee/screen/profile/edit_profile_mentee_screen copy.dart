import 'package:flutter/material.dart';
import 'package:my_flutter_app/Mentee/service/profile_service.dart';
import 'package:my_flutter_app/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
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

  const EditProfileMenteeScreen({
    Key? key,
    required this.skills,
    required this.linkedin,
    required this.about,
    required this.location,
    required this.currentJob,
    required this.currentCompany,
    required this.experiences,
  }) : super(key: key);

  @override
  _EditProfileMenteeScreenState createState() =>
      _EditProfileMenteeScreenState();
}

class _EditProfileMenteeScreenState extends State<EditProfileMenteeScreen> {
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

  void _updateUserProfile() async {
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
    // Handle post-update actions, like showing a confirmation dialog
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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            enabled: false), // Assuming you have an email controller
        _textFieldWithTitle("Name", _nameController, "Your name",
            enabled: false), // Assuming you have a name controller
        _textFieldWithTitle(
          "Job",
          _jobController,
          "Enter Your Job/Position",
          onChanged: (value) {
            setState(() {
              job = value;
            });
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
        }),
        _textFieldWithTitle("About", _aboutController, "Enter Your About",
            onChanged: (value) {
          setState(() {
            about = value;
          });
        }),
        _textFieldWithTitle(
            "LinkedIn", _linkedinController, "Enter Your LinkedIn URL",
            onChanged: (value) {
          setState(() {
            linkedin = value;
          });
        }),
        const SizedBox(height: 12),
        _experienceField(),
        _experienceChips(),
      ],
    );
  }

  Widget _textFieldWithTitle(
      String title, TextEditingController controller, String hintText,
      {bool enabled = true, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(title: title, color: ColorStyle().secondaryColors),
        TextFieldWidget(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged, // Add this line
        ),
      ],
    );
  }

  Widget _skillField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittleTextField(title: "Skill", color: ColorStyle().secondaryColors),
        TextFieldWidget(
          controller: _skillController,
          hintText: "Skill",
          formKey: _formKey,
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _addSkill,
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
        TittleTextField(
            title: "Experience", color: ColorStyle().secondaryColors),
        TextFieldWidget(
          controller: _roleController,
          hintText: "Role",
        ),
        const SizedBox(height: 12),
        TextFieldWidget(
          controller: _experienceCompanyController,
          hintText: "Company",
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _addExperience,
            icon: const Icon(Icons.add, size: 16),
            label: Text("Add Experience", style: FontFamily().regularText),
          ),
        ),
        const SizedBox(height: 12),
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

  Widget _saveButton(BuildContext context) {
    return ElevatedButtonWidget(
      title: "Save",
      onPressed: () {
        if (_skills.isEmpty) {
          showTopSnackBar(context, 'Please add at least one skill',
              leftBarIndicatorColor: ColorStyle().errorColors);
        } else if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _updateUserProfile(); // Memanggil _updateUserProfile() tanpa await
          showTopSnackBar(context, 'Profile updated successfully',
              leftBarIndicatorColor: ColorStyle().succesColors);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProfileMenteeScreen()),
            (route) => false,
          );
        }
      },
    );
  }
}
