class CategoryLink {
  const CategoryLink({
    required this.name,
    required this.slug,
    required this.driveUrl,
  });

  final String name;
  final String slug;
  final String driveUrl;
}

/// Keep links here so the UI stays clean.
/// Replace the URLs with your Google Drive folder links.
const categories = <CategoryLink>[
  CategoryLink(
    name: 'Bags',
    slug: 'bags',
    driveUrl:
        'https://drive.google.com/drive/folders/1mPeb0bTJUtQs8aXxRuxd0n2FO4tJ-Q69?usp=drive_link/',
  ),
  CategoryLink(
    name: 'Shoes',
    slug: 'shoes',
    driveUrl:
        'https://drive.google.com/drive/folders/1T2SuGpddbDJsKtnCY5yjZ5hhw1KIOTsX?usp=drive_link/',
  ),
  CategoryLink(
    name: 'Accessories',
    slug: 'accessories',
    driveUrl:
        'https://drive.google.com/drive/folders/1tC_qoxehVztvTAgePvDwxR22HXC01PxR/',
  ),
  CategoryLink(name: 'Belts', slug: 'belts', driveUrl: 'https://drive.google.com/drive/folders/1aLLwCQovIrWN6o10svXHsGA58Z2UA2nL?usp=drive_link/'),
  CategoryLink(
    name: 'Jewellery',
    slug: 'jewellery',
    driveUrl:
        'https://drive.google.com/drive/folders/1E90hgZIPJjZp2FEphQV3GBS5nlezah1V?usp=drive_link/',
  ),
  CategoryLink(
    name: 'Wallets',
    slug: 'wallets',
    driveUrl:
        'https://drive.google.com/drive/folders/1zjVOcv5t5Zi1EJv12QL5WqpKeG9X82um?usp=drive_link/',
  ),
  CategoryLink(
    name: 'Watches',
    slug: 'watches',
    driveUrl:
        'https://drive.google.com/drive/folders/1QSNHXObXXWrobW557xue6FLQPdzN5cdX?usp=drive_link/',
  ),
  CategoryLink(
    name: 'Customer Reviews',
    slug: 'customer-reviews',
    driveUrl: 'https://drive.google.com/drive/folders/1YR3xyGnctAQXPdBLL9J8-ykugzLJWJJ8?usp=drive_link/',
  ),
];
