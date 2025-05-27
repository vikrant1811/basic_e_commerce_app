import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../res/colors.dart';

class GlobalImageBuilder extends StatelessWidget {
  const GlobalImageBuilder({
    super.key,
    this.src,
    this.fit,
    this.width,
    this.height,
    this.file,
    this.icon,
  });

  final String? src;
  final File? file;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (_isSvg(file!.path)) {
        return SvgPicture.file(
          file!,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
        );
      }
      return Image.file(
        file!,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => defaultImage(),
      );
    }

    if (src != null) {
      if (_isSvg(src!)) {
        return SvgPicture.network(
          src!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          placeholderBuilder: (context) => defaultImage(),
        );
      }

      return CachedNetworkImage(
        imageUrl: src!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => defaultImage(),
        errorWidget: (context, url, error) => defaultImage(),
      );
    }

    return defaultImage();
  }

  Widget defaultImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.grey,
      ),
      height: height ?? 100,
      width: width ?? 100,
      child: Stack(
        children: [
          Center(
            child: Icon(
              icon ?? Icons.image_outlined,
              color: AppColors.white,
              size: 80,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.theme,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _isSvg(String imagePath) {
    return imagePath.toLowerCase().endsWith('.svg');
  }
}
