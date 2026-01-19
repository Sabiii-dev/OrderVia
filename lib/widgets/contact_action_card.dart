import 'package:flutter/material.dart';

class ContactActionCard extends StatelessWidget {
  const ContactActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.background,
    this.foreground = Colors.white,
    this.icon,
    this.border,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color background;
  final Color foreground;
  final IconData? icon;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: border == null ? null : Border.fromBorderSide(border!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null)
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: foreground),
              ),
            if (icon != null) const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: foreground.withValues(alpha: 0.92),
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: foreground.withValues(alpha: 0.9)),
          ],
        ),
      ),
    );
  }
}

