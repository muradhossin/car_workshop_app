import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageViewer extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;

  const CustomImageViewer({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => placeholder ?? const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => errorWidget ?? const Center(
          child: Icon(Icons.error),
        ),
        fit: fit,
      ),
    );
  }
}