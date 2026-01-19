import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordervia/config/categories.dart';
import 'package:ordervia/shared/utils/launch_url.dart';
import 'package:ordervia/widgets/category_tile.dart';
import 'package:ordervia/widgets/contact_panel.dart';
import 'package:ordervia/widgets/footer.dart';
import 'package:ordervia/widgets/header.dart';
import 'package:ordervia/widgets/hero_cover.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _categoriesKey = GlobalKey();

  bool _showContact = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      alignment: 0,
    );
  }

  void _openContact() => setState(() => _showContact = true);
  void _closeContact() => setState(() => _showContact = false);

  int _categoryCrossAxisCount(double width) {
    if (width >= 1100) return 4;
    if (width >= 800) return 3;
    return 2;
  }

  double _categoryAspectRatio(double width) {
    if (width >= 1100) return 1.25;
    return 1.15;
  }

  String _categoryImageUrl(String slug) {
    // Public image URLs (reliable for Image.network) per category.
    // If you later want Drive links again, we can switch back with a direct-thumbnail converter.
    switch (slug) {
      case 'bags':
        return 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=1200&q=80';
      case 'shoes':
        // Ladies luxury heels/shoes
        return 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=1200&q=80';
      case 'watches':
        // Ladies luxury watch
        return 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?auto=format&fit=crop&w=1200&q=80';
      case 'jewellery':
        return 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=1200&q=80';
      case 'belts':
        // Local asset image
        return 'assets/images/BELT.jpg';
      case 'wallets':
        // Local asset image
        return 'assets/images/WALLET.jpg';
      case 'accessories':
        // Ladies sunglasses/glasses
        return 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=1200&q=80';
      case 'customer-reviews':
        // Reviews/feedback
        return 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&q=80';
      default:
        return 'https://images.unsplash.com/photo-1526178613552-2b45c6c1f2b4?auto=format&fit=crop&w=1200&q=80';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _HeaderDelegate(
                  minHeight: 76,
                  maxHeight: 90,
                  child: Header(
                    onTapHome: () => _scrollTo(_heroKey),
                    onTapCategories: () => _scrollTo(_categoriesKey),
                    onTapContact: _openContact,
                    //  onTapTextMessage: _openContact,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                key: _heroKey,
                child: HeroCover(
                  onBrowseCategories: () => _scrollTo(_categoriesKey),
                  onSubmitCustomRequest: _openContact,
                ),
              ),
              SliverToBoxAdapter(
                key: _categoriesKey,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 26, 16, 28),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final w = constraints.maxWidth;
                          final crossAxisCount = _categoryCrossAxisCount(w);
                          final aspect = _categoryAspectRatio(w);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shop by Category',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Curated essentials for every aspect of your life.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF6B7280),
                                    ),
                              ),
                              const SizedBox(height: 18),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 14,
                                  childAspectRatio: aspect,
                                ),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final c = categories[index];
                                  return CategoryTile(
                                    title: c.name,
                                    imageUrl: _categoryImageUrl(c.slug),
                                    onTap: () => launchExternalUrl(c.driveUrl),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Footer(
                  onTapCategories: () => _scrollTo(_categoriesKey),
                  onTapContact: _openContact,
                ),
              ),
            ],
          ),
          // Positioned(
          //   right: 16,
          //   bottom: 16,
          //   child: FloatingActionButton.extended(
          //     onPressed: _openContact,
          //     label: const Text('Text Message'),
          //     icon: const Icon(Icons.sms_outlined),
          //   ),
          // ),
          if (_showContact) ...[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _closeContact,
                child: Container(color: Colors.black.withValues(alpha: 0.45)),
              ),
            ),
            ContactPanel(onClose: _closeContact),
          ]
        ],
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  final Widget child;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
