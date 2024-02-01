import 'package:flutter/material.dart';



class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Diminishing Text on Image'),
        ),
        body: Center(
          child: DiminishingTextOnImage(),
        ),
      ),
    );
  }
}

class DiminishingTextOnImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img/img.png', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),

          // Text Container with Diminishing Effect
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150, // Adjust the height of the text container as needed
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Your Text Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}