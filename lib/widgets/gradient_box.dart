import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withAlpha(8),
            Colors.black.withAlpha(100),
            Colors.black.withAlpha(140),
          ],
        ),
      ),
    );
  }
}
