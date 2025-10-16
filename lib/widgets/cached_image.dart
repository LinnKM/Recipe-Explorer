import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final double? borderRadius;
  final String imageUrl;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            color: Colors.grey,
            image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
          ),
        );
      },
      placeholder:
          (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),
                color: Colors.grey,
              ),
            ),
          ),
      errorWidget:
          (context, url, error) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              color: Colors.grey,
            ),
            child: const Center(child: Icon(TablerIcons.exclamation_circle)),
          ),
    );
  }
}
