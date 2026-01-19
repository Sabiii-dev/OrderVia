import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordervia/shared/utils/launch_url.dart';

class HeroCover extends StatelessWidget {
  const HeroCover({
    super.key,
    required this.onBrowseCategories,
    required this.onSubmitCustomRequest,
  });

  final VoidCallback onBrowseCategories;
  final VoidCallback onSubmitCustomRequest;

  static const _cover = AssetImage('assets/images/ordervia_cover.jpg');

  static const String _newArrivalsUrl =
      'https://drive.google.com/drive/folders/1Mi1Um5nn-zpjarJ5vJH0vN3PXbcX8kCf';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    final bgDecoration = kIsWeb
        ? const BoxDecoration(
            image: DecorationImage(
              image: _cover,
              fit: BoxFit.cover,
            ),
          )
        : const BoxDecoration(color: Color(0xFF0B1220));

    final cardHeight = isDesktop ? 420.0 : 360.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
          child: Container(
            height: cardHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(decoration: bgDecoration),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF06162B).withValues(alpha: 0.88),
                          const Color(0xFF0B2A2A).withValues(alpha: 0.55),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      isDesktop ? 44 : 24,
                      isDesktop ? 32 : 22,
                      isDesktop ? 44 : 24,
                      isDesktop ? 30 : 22,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 620),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const _BadgePill(label: 'PREMIUM EXCELLENCE'),
                            const SizedBox(height: 18),
                            _Headline(isDesktop: isDesktop),
                            const SizedBox(height: 14),
                            Text(
                              'We focus on good quality products at affordable prices. Our goal is to give customers reliable options without overcharging or making things complicated.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.88),
                                    height: 1.35,
                                  ),
                            ),
                            const SizedBox(height: 22),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                FilledButton(
                                  onPressed: () => launchExternalUrl(
                                    _newArrivalsUrl,
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF17C6E6),
                                    foregroundColor: const Color(0xFF04121F),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('New Arrivals'),
                                      SizedBox(width: 10),
                                      Icon(Icons.arrow_forward, size: 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF17C6E6),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
          ),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme;
    final wordStyle = (isDesktop ? base.displayMedium : base.displaySmall)
        ?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          height: 0.95,
        );

    Widget dot() => Container(
          width: isDesktop ? 18 : 14,
          height: isDesktop ? 18 : 14,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF17C6E6),
            shape: BoxShape.circle,
          ),
        );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 8,
      children: [
        Text('Simple ', style: wordStyle),
        dot(),
        Text('Trusted', style: wordStyle),
        dot(),
        Text('Easy', style: wordStyle),
      ],
    );
  }
}
