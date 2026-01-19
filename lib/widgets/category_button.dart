import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  static const olive = Color(0xFF3F5A3A);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: olive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(42),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

