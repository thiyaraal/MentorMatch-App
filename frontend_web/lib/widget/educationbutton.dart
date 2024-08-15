import 'package:flutter/material.dart';

class CustomButtonGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8), // Increased padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('SD', fontSize: 16.0), // Increased fontSize
              SizedBox(width: 12), // Increased spacing
              _buildButton('SMP', fontSize: 16.0), // Increased fontSize
              SizedBox(width: 12),
              _buildButton('SMA', fontSize: 16.0), // Increased fontSize
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8), // Increased padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Kuliah',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0), // Increased fontSize
              SizedBox(width: 12),
              _buildButton('Karier',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0), // Increased fontSize
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label,
      {FontWeight fontWeight = FontWeight.normal, double fontSize = 12.0}) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xff0A1737),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 24), // Increased padding
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Custom Button Group'),
      ),
      body: CustomButtonGroup(),
    ),
  ));
}
