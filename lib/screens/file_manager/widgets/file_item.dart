import 'package:flutter/material.dart';

class CategoryItemCard extends StatelessWidget {
  final String categoryName;
  final Color color;
  final Color textColor;

  const CategoryItemCard(
      {super.key,
      required this.categoryName,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        categoryName,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
