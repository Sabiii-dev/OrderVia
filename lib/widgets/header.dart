import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.onTapHome,
    required this.onTapCategories,
    required this.onTapContact,
  });

  final VoidCallback onTapHome;
  final VoidCallback onTapCategories;
  final VoidCallback onTapContact;

  static const brandNavy = Color(0xFF0B1220);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: brandNavy,
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _heightForWidth(MediaQuery.sizeOf(context).width),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/ordervia_logo.png',
                    height: 60,

                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                _NavButton(label: 'Home', onPressed: onTapHome),
                _NavButton(label: 'Categories', onPressed: onTapCategories),
                _NavButton(label: 'Contact', onPressed: onTapContact),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _heightForWidth(double width) {
    if (width >= 1000) return 90;
    return 76;
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withValues(alpha: 0.92),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
