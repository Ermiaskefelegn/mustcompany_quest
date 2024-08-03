import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageDisplayWidget(
      {super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Positioned(
      left: width / 6,
      top: height / 6,
      child: Container(
        height: height / 1.5,
        width: width / 1.5,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
