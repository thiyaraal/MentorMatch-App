import 'package:flutter/material.dart';

class ExperienceWidget extends StatefulWidget {
  final String role;
  final String company;

  ExperienceWidget({Key? key, required this.role, required this.company})
      : super(key: key);

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.work_outline_outlined,
              size: 25, color: Color(0xffE78938)), // Use primary color directly
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.role,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff313030), // Use text color directly
                ),
              ),
              Text(
                widget.company,
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 18,
                  color: Color(0xff313030), // Use text color directly
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
