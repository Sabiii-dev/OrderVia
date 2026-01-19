import 'package:flutter/material.dart';
import 'package:ordervia/features/products/products_repository.dart';
import 'package:ordervia/shared/widgets/ordervia_app_bar.dart';
import 'package:ordervia/shared/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _repo = const ProductsRepository();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = _repo.getFeatured();
    final query = _searchController.text.trim().toLowerCase();

    final filtered = query.isEmpty
        ? products
        : products
            .where((p) => p.title.toLowerCase().contains(query))
            .toList(growable: false);

    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 1200
        ? 4
        : width >= 900
            ? 3
            : width >= 600
                ? 2
                : 1;

    return Scaffold(
      appBar: const OrderviaAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _HeroBanner(
                searchController: _searchController,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Text(
                'Featured products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: crossAxisCount == 1 ? 1.15 : 0.74,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: filtered[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.searchController,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF374151)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bags & Classy',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Discover premium bags curated for your style.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.88),
                ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search products',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
