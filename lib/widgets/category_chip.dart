import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String text;
  final bool isActive;

  const CategoryChip({
    super.key,
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.black45,
          ),
        ),
        backgroundColor: isActive ? const Color.fromARGB(255, 104, 2, 2) : Colors.grey.shade200,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
