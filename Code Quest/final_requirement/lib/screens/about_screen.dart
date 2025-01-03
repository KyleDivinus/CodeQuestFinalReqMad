import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    const TextStyle titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    const TextStyle subtitleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    const TextStyle bodyStyle = TextStyle(fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Code Quest'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Code Quest',
                style: titleStyle,
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: 'Code Quest is an exciting adventure game where players embark on a ',
                  style: bodyStyle,
                  children: [
                    TextSpan(
                      text: 'journey to solve coding challenges and complete quests. ',
                    ),
                    TextSpan(
                      text: 'The game is designed to enhance programming skills while providing an engaging and fun experience.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Developers:',
                style: subtitleStyle,
              ),
              SizedBox(height: 8),
              Text(
                'Jericho Cansino',
                style: bodyStyle,
              ),
              Text(
                'Kyle Casing',
                style: bodyStyle,
              ),
              SizedBox(height: 24),
              Text(
                'Education:',
                style: subtitleStyle,
              ),
              SizedBox(height: 8),
              Text(
                'BSIT Students at Pangasinan State University, Urdaneta',
                style: bodyStyle,
              ),
              SizedBox(height: 24),
              Text(
                'Thank you for playing Code Quest!',
                style: bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}