import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 18,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/images/tileset/neo_zero_buildings_02.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.7),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSectionTitle(
                          'About the Game'), // Section title for game description
                      _buildText(
                        'This is a fast-paced action game where you control a character and engage in exciting battles. Choose your character and start the adventure!',
                      ), // Game description text
                      SizedBox(height: 20), // Spacing between sections
                      _buildSectionTitle(
                          'Credits'), // Section title for credits
                      _buildText(
                        'Developed by: Your Name\nArtwork by: Artist Name\nMusic by: Composer Name\nSpecial Thanks to: Anyone who helped',
                      ), // Credits text
                      SizedBox(height: 20),
                      _buildSectionTitle(
                          'Contact Us'), // Section title for contact information
                      _buildText(
                          'Email: your.email@example.com\nWebsite: www.example.com'), // Contact information text
                      SizedBox(height: 20),
                      _buildSectionTitle(
                          'Version'), // Section title for version info
                      _buildText('Version 1.0.0'), // Version information
                      SizedBox(height: 20),
                      _buildSectionTitle(
                          'Legal'), // Section title for legal information
                      _buildText(
                          'All rights reserved.\nGame assets used under appropriate licenses.'), // Legal information text
                      SizedBox(height: 30),
                      _buildActionButton(
                          context), // Action button to visit the website
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles with styling
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'PressStart2P',
          fontSize: 20,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Helper method to build the section text with padding
  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'PressStart2P',
          fontSize: 14,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
    );
  }

  // Helper method to build the action button
  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed:
            () {}, // Action to take when the button is pressed (currently empty)
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[800],
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: Text(
          'Visit Website',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
