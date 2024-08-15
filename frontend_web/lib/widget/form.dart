import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Define an enum to distinguish between different types of form fields
enum CustomFormFieldType { text, dropdown }

class CustomForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final CustomFormFieldType fieldType;
  final List<String>? dropdownItems;
  final Function(String?)? onDropdownChanged;

  const CustomForm({
    required this.title,
    this.subtitle = '',
    this.fieldType = CustomFormFieldType.text,
    this.dropdownItems,
    this.onDropdownChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color filledColor = Color.fromRGBO(249, 240, 241, 1.0);

    // Dynamic height based on subtitle length
    double dynamicHeight = _calculateDynamicHeight(subtitle);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          if (title.isNotEmpty) SizedBox(height: 8),
          if (fieldType == CustomFormFieldType.text)
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 56.0, // Minimum height for short subtitles
                maxHeight:
                    dynamicHeight, // Adjust based on subtitle length dynamically
              ),
              child: TextField(
                maxLines: null, // Allows the TextField to expand
                decoration: InputDecoration(
                  hintText: subtitle,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600,
                  ),
                  fillColor: filledColor,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          else if (fieldType == CustomFormFieldType.dropdown)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: filledColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: filledColor),
                  ),
                ),
                value: dropdownItems?.isNotEmpty == true
                    ? dropdownItems!.first
                    : null,
                items: dropdownItems?.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onDropdownChanged,
                dropdownColor: filledColor,
              ),
            ),
        ],
      ),
    );
  }

  double _calculateDynamicHeight(String subtitle) {
    // Basic logic to calculate dynamic height based on text length
    int charCount = subtitle.length;
    const int perLineCharCount =
        40; // Approximate character count per line at a given font size
    const double lineHeight = 24.0; // Approximate line height

    int lineCount = (charCount / perLineCharCount).ceil();
    double totalHeight = lineHeight * lineCount +
        40; // Additional padding + TextField intrinsic padding

    // Ensure the totalHeight is within an acceptable range
    return totalHeight.clamp(
        56.0, 200.0); // Adjust min and max height as needed
  }
}

class SkillForm extends StatefulWidget {
  @override
  _SkillFormState createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  TextEditingController _skillController = TextEditingController();
  List<String> skills = [];
  String newSkill = '';

  @override
  Widget build(BuildContext context) {
    return _buildSkillForm("Skill", "Add your skill");
  }

  Widget _buildSkillForm(String title, String subtitle) {
    Color filledColor = Color.fromRGBO(249, 240, 241, 1.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(bottom: 40), // Increased bottom padding
                  child: TextField(
                    maxLines: null, // Allows the TextField to expand
                    onChanged: (value) {
                      newSkill = value;
                    },
                    controller: _skillController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (newSkill.isNotEmpty) {
                            setState(() {
                              skills.add(newSkill);
                              newSkill = '';
                              _skillController.clear();
                            });
                          }
                        },
                      ),
                      hintText: subtitle,
                      fillColor: filledColor,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildSkillChips(),
        ],
      ),
    );
  }

  Widget _buildSkillChips() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: skills.map((skill) => _buildSkillChip(skill)).toList(),
    );
  }

  Widget _buildSkillChip(String skill) {
    Color chipColor = Colors.orange;
    Color deleteButtonColor = Colors.white;

    return Chip(
      labelPadding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 6.0,
      ),
      label: Text(
        skill,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 17.0,
        ),
      ),
      backgroundColor: chipColor,
      deleteIconColor: deleteButtonColor,
      onDeleted: () {
        setState(() {
          skills.remove(skill);
        });
      },
    );
  }
}

// CustomDatePicker class to pick a date
class CustomDatePicker extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const CustomDatePicker({
    Key? key,
    required this.title,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color filledColor = Color.fromRGBO(249, 240, 241, 1.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
              if (pickedDate != null && pickedDate != selectedDate) {
                onDateChanged(pickedDate);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: filledColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd MMMM yyyy').format(selectedDate),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.calendar_month_rounded,
                      color: Colors.grey.shade600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
