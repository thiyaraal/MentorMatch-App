import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentor/Screens/portofolio_mentor_page.dart';
import 'package:my_flutter_app/widget/form.dart';
import 'package:my_flutter_app/widget/custombutton.dart';

class MentorSkillPage extends StatefulWidget {
  const MentorSkillPage({Key? key}) : super(key: key);

  @override
  _MentorSkillPageState createState() => _MentorSkillPageState();
}

class _MentorSkillPageState extends State<MentorSkillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 20),
              Image.asset(
                'assets/Handoff/logo/LogoWeb.png',
                height: 150,
                width: 150,
              ),
            ],
          ),
          elevation: 0, // Removes the shadow under the app bar.
          backgroundColor: Colors.white, // Matches the background color.
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(55.0), // Add padding around the edges
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2, // Adjust flex as needed to balance the layout
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Hello ',
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Stevenley',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      ',\nComplete the form to \nbecome a mentor'),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SkillForm(),
                        CustomForm(
                            title: "LinkedIn",
                            subtitle: "https://www.linkedin.com/in/xxx/"),
                        SizedBox(height: 50),
                        CustomButton(
                          buttonText: "Next",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MentorPortofolioPage()),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/Handoff/ilustrator/mentor_in_zoom.png',
                    fit: BoxFit.cover, // Adjust the BoxFit property as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
