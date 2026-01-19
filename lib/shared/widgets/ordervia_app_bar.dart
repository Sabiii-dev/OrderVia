import 'package:flutter/material.dart';
import 'package:ordervia/shared/utils/launch_url.dart';

class OrderviaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderviaAppBar({super.key});

  static const _storeUrl =
      'https://campsite.bio/bagsxclassy?utm_source=ig&utm_medium=social&utm_content=link_in_bio';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: const Text('Ordervia'),
      actions: [
        TextButton.icon(
          onPressed: () => launchExternalUrl(_storeUrl),
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text('Shop'),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

