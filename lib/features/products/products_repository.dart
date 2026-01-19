import 'package:ordervia/features/products/product.dart';

/// Simple in-memory data source.
///
/// TODO: Replace with your real catalog (API / Firebase / CMS).
class ProductsRepository {
  const ProductsRepository();

  List<Product> getFeatured() {
    return const [
      Product(
        id: 'bag-1',
        title: 'Classic Handbag',
        subtitle: 'Premium quality',
        category: 'Bags',
        price: 2499,
        currency: '₹',
        imageUrl:
            'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=900&q=80',
        productUrl:
            'https://campsite.bio/bagsxclassy?utm_source=ig&utm_medium=social&utm_content=link_in_bio',
      ),
      Product(
        id: 'bag-2',
        title: 'Everyday Tote',
        subtitle: 'Fits laptop + more',
        category: 'Bags',
        price: 1999,
        currency: '₹',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=900&q=80',
        productUrl:
            'https://campsite.bio/bagsxclassy?utm_source=ig&utm_medium=social&utm_content=link_in_bio',
      ),
      Product(
        id: 'bag-3',
        title: 'Mini Crossbody',
        subtitle: 'Minimal & stylish',
        category: 'Bags',
        price: 1499,
        currency: '₹',
        imageUrl:
            'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=900&q=80',
        productUrl:
            'https://campsite.bio/bagsxclassy?utm_source=ig&utm_medium=social&utm_content=link_in_bio',
      ),
      Product(
        id: 'bag-4',
        title: 'Party Clutch',
        subtitle: 'Night out essential',
        category: 'Bags',
        price: 1299,
        currency: '₹',
        imageUrl:
            'https://images.unsplash.com/photo-1526178613552-2b45c6c1f2b4?auto=format&fit=crop&w=900&q=80',
        productUrl:
            'https://campsite.bio/bagsxclassy?utm_source=ig&utm_medium=social&utm_content=link_in_bio',
      ),
    ];
  }
}

