import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.onTapCategories,
    required this.onTapContact,
  });

  final VoidCallback onTapCategories;
  final VoidCallback onTapContact;

  static const brandNavy = Color(0xFF0B1220);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    final muted = Colors.white.withValues(alpha: 0.78);

    Widget link(String label, VoidCallback onPressed) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withValues(alpha: 0.92),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label),
      );
    }

    Widget smallText(String text) => Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
        );

    final brandBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/ordervia_logo.png',
              height: 34,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              'OrderVia',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Premium essentials, sourced with care.',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.92),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        smallText(
          'We deliver carefully curated products including bags, shoes, watches, jewellery, belts, wallets and everyday accessories. Quality-first, fair pricing, and a smooth buying experience.',
        ),
      ],
    );

    final quickLinks = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick links',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        link('Categories', onTapCategories),
        const SizedBox(height: 6),
        link('Contact', onTapContact),
      ],
    );

    final products = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        smallText('• Bags & handbags'),
        const SizedBox(height: 6),
        smallText('• Ladies shoes'),
        const SizedBox(height: 6),
        smallText('• Watches & jewellery'),
        const SizedBox(height: 6),
        smallText('• Belts, wallets & accessories'),
      ],
    );

    final support = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        smallText('Fast replies via web chat (Admin) and social DMs.'),
        const SizedBox(height: 6),
        smallText('Order updates and help with product requests.'),
        const SizedBox(height: 6),
        smallText('Secure checkout and guidance on delivery.'),
      ],
    );

    final top = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: brandBlock),
              const SizedBox(width: 36),
              Expanded(flex: 2, child: quickLinks),
              const SizedBox(width: 36),
              Expanded(flex: 3, child: products),
              const SizedBox(width: 36),
              Expanded(flex: 3, child: support),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              brandBlock,
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: quickLinks),
                  const SizedBox(width: 18),
                  Expanded(child: products),
                ],
              ),
              const SizedBox(height: 18),
              support,
            ],
          );

    return Container(
      color: brandNavy,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                top,
                const SizedBox(height: 18),
                Divider(color: Colors.white.withValues(alpha: 0.12)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '© 2016 OrderVia. All rights reserved.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: muted),
                      ),
                    ),
                    if (isDesktop)
                      Text(
                        'Quality • Value • Trust',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: muted),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
