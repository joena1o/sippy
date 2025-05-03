import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  ImageWidget({super.key, required this.imageUrl});

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        color: Colors.grey[400],
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
