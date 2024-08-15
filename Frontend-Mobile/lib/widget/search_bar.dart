import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/seacrh_page_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/search_page_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';

class SearchBarWidgetMentor extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextEditingController? controller;

  SearchBarWidgetMentor(
      {Key? key, required this.title, this.controller, this.onPressed})
      : super(key: key);

  @override
  State<SearchBarWidgetMentor> createState() => _SearchBarWidgetMentorState();
}

class _SearchBarWidgetMentorState extends State<SearchBarWidgetMentor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPageMentorMobile()),
          );
        },
        child: Container(
          width: 800,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: ColorStyle().tertiaryColors),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AbsorbPointer(
            child: TextField(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPageMentorMobile()),
                );
              },
              obscureText: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Search by mentee name, class, or class name',

                /// style label text
                labelStyle: TextStyle(
                  color: ColorStyle().textColors,
                  fontSize: 14,
                ),

                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBarWidgetMentee extends StatelessWidget {
  const SearchBarWidgetMentee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPageMenteeMobile()),
          );
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: ColorStyle().tertiaryColors),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPageMenteeMobile(),
                ),
              );
            },
            obscureText: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Search by mentor name, class name',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
