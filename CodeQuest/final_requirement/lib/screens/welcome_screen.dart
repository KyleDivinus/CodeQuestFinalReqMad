import 'package:flutter/material.dart';
import 'sel_char_screen.dart';
import 'about_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity =
      1.0; // Controls the opacity of the blinking "CODEQUEST" text.

  @override
  void initState() {
    super.initState();
    // Start the blinking effect after the screen loads.
    Future.delayed(Duration.zero, _startBlinking);
  }

  // Handles the blinking animation by toggling the opacity every second.
  void _startBlinking() {
    Future.doWhile(() async {
      // Wait for 1 second before toggling.
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        // Toggle the opacity value between fully visible (1.0) and invisible (0.0).
        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
      return true; // Continue looping indefinitely.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Stack allows layering widgets on top of each other.
        children: [
          // Background image layer.
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/tileset/neo_zero_buildings_02.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Black overlay with reduced opacity for better text contrast.
          Opacity(
            opacity: 0.3, // Adjust the transparency of the overlay.
            child: Container(
              color: Colors.black,
            ),
          ),
          // Main content layer: Centered blinking text and buttons.
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Blinking "CODEQUEST" text with animated opacity.
                AnimatedOpacity(
                  opacity: _opacity, // Apply blinking effect using opacity.
                  duration: Duration(seconds: 1), // Duration for each blink.
                  curve: Curves.easeInOut, // Smooth transition for blinking.
                  child: Text(
                    'CODEQUEST',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        // Shadow effect for the text.
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // "PLAY" button to navigate to the character selection screen.
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to the character selection screen.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectCharacterScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 6,
                    ),
                    child: Text(
                      'PLAY',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // "ABOUT" button to navigate to the About screen.
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to the About screen.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 6,
                    ),
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
