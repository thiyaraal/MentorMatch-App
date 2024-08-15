import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mentoring',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Session',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Premium Class',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Privacy',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Blog',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Conditions',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone : 1234567',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Email : what@gmail.com',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Location : 123, Jekardah',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Social Media',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Image.asset(
                          'assets/social-icons/behance.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 25),
                        Image.asset(
                          'assets/social-icons/instagram.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 25),
                        Image.asset(
                          'assets/social-icons/linkedin.png',
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Image.asset(
                          'assets/social-icons/whatsapp.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 25),
                        Image.asset(
                          'assets/social-icons/twitter.png',
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
          // horizontal line
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                // copy right
              ],
            ),
          ),
          // copyright at center
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Copyright   ©   2023. All rights reserved',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
