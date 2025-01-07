import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This App:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app, CodeQuest, is a game designed to help users learn Flutter and Dart through interactive gameplay.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Course Information Section
            Text(
              'Course Information:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app was developed as a course requirement for the Mobile Application and Development course.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Developers Section
            Text(
              'Developed by:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kyle Divinus Casing',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jericho Cansino',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
