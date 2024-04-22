import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final bool isSelected;

  const DotWidget({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
    );
  }
}