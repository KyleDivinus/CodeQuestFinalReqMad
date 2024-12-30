import 'package:flutter/material.dart';
import 'sel_char_screen.dart';
import 'about_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _startBlinking);
  }

  void _startBlinking() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/tileset/neo_zero_buildings_02.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: 0.3,
            child: Container(
              color: Colors.black,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Text(
                    'CODEQUEST',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
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
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
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
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
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
