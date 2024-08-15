import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/login/login_screen.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/Handoff/logo/LogoWeb.png',
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE78839),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15), // Increase horizontal padding
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const NavBarItem({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
