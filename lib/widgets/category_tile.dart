import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.imageUrl,
  });

  final String title;
  final VoidCallback onTap;
  final String imageUrl;

  String _driveDirectUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;

    // Already a direct image host.
    if (uri.host.contains('googleusercontent.com')) return url;

    String? fileId;

    // /file/d/<ID>/...
    final segments = uri.pathSegments;
    final dIndex = segments.indexOf('d');
    if (dIndex != -1 && dIndex + 1 < segments.length) {
      fileId = segments[dIndex + 1];
    }

    // open?id=<ID>
    fileId ??= uri.queryParameters['id'];

    if (fileId == null || fileId.isEmpty) return url;

    // Prefer a thumbnail with an explicit size.
    return 'https://drive.google.com/thumbnail?id=$fileId&sz=w1200';
  }

  int _targetCacheWidthFor(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    // Approximate tile width based on breakpoints used in HomeScreen.
    final crossAxisCount = w >= 1100 ? 4 : (w >= 800 ? 3 : 2);
    final tileWidth = (w / crossAxisCount).clamp(220.0, 520.0);

    // Account for devicePixelRatio to avoid blurry images.
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return (tileWidth * dpr).round();
  }

  Widget _buildImage(BuildContext context) {
    final isAsset = imageUrl.startsWith('assets/');
    final cacheWidth = _targetCacheWidthFor(context);

    if (isAsset) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        cacheWidth: cacheWidth,
        gaplessPlayback: true,
        filterQuality: FilterQuality.low,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFE5E7EB),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Image unavailable',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          );
        },
      );
    }

    final resolvedUrl = imageUrl.contains('drive.google.com')
        ? _driveDirectUrl(imageUrl)
        : imageUrl;

    return Image.network(
      resolvedUrl,
      fit: BoxFit.cover,
      cacheWidth: cacheWidth,
      gaplessPlayback: true,
      filterQuality: FilterQuality.low,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: const Color(0xFFE5E7EB),
          alignment: Alignment.center,
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes == null
                  ? null
                  : (loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFE5E7EB),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Image unavailable',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w700,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(context),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.00),
                      Colors.black.withValues(alpha: 0.55),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                left: 14,
                bottom: 12,
                right: 14,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
