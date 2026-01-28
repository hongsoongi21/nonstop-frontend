import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullscreenImageViewer extends StatelessWidget {
  final String imageUrl;
  final String? heroTag;

  const FullscreenImageViewer({
    super.key,
    required this.imageUrl,
    this.heroTag,
  });

  bool get _isLocalFile => imageUrl.startsWith('/') || imageUrl.startsWith('file://');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: heroTag != null
              ? Hero(
                  tag: heroTag!,
                  child: _buildImage(),
                )
              : _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (_isLocalFile) {
      return Image.file(
        File(imageUrl.replaceFirst('file://', '')),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.error,
          color: Colors.white,
          size: 48,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.white,
        size: 48,
      ),
    );
  }
}
