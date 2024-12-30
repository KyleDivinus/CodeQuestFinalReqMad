import 'package:flutter/material.dart';

class SelectCharacterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Your Character',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/tileset/neo_zero_buildings_02.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CharacterCard(
                        imagePath: 'assets/images/characters/char1.png',
                        name: 'Blaze',
                      ),
                      CharacterCard(
                        imagePath: 'assets/images/characters/char2.png',
                        name: 'Cherry',
                      ),
                      CharacterCard(
                        imagePath: 'assets/images/characters/char3.png',
                        name: 'Aegis',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterCard extends StatefulWidget {
  final String imagePath;
  final String name;

  CharacterCard({required this.imagePath, required this.name});

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _sizeAnimation = Tween<double>(begin: 1.0, end: 1.20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.name} selected!')),
        );
      },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _sizeAnimation.value,
                child: Container(
                  width: 140,
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8),
          Text(
            widget.name,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
