import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  double _height = 0; // Initial height

  @override
  void initState() {
    super.initState();
    // Animate the image blooming effect
    Future.delayed(Duration.zero, () {
      setState(() {
        _height = 200; // Set to final height for blooming effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
      height: _height, // Animated height
      width: 200, // Fixed width
      child: Image.asset(
          'assets/images/kawai_girl.jpg'), // Replace with your image
    );
  }
}
