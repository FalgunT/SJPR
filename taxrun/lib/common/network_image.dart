import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'app_theme.dart';

///
/// This class provides shimmer widget when data is being fetched from server
///
class CustomNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final Uint8List image;
  final double radius;
  final String placeholderImage;
  final String errorImage;
  final BoxFit errorImageFit;

  const CustomNetworkImage(
      {Key? key,
      this.width = 150,
      this.height = 180,
      this.fit = BoxFit.cover,
      required this.image,
      this.radius = 0,
      this.placeholderImage = '',
      this.errorImage = '',
      this.errorImageFit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: appTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          color: Colors.white,
          width: 5.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            image.isEmpty ?
            /*CachedNetworkImage(
              imageUrl: image.toString(),
    *//*imageBuilder: (context, imageProvider) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
    image: MemoryImage(image), fit: BoxFit.cover),
    ),
    ),*//*
    width: width,
              height: height,
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  placeholderImage,
                  width: width,
                  height: height,
                ),
              ),
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: ShimmerLoading(
                    isLoading: true,
                    child: Container(
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: AssetImage(placeholderImage))),
                    ),
                  ),
                ),
              ),
            )*/
        Center(
        child: Image.asset(
          placeholderImage,
          width: width,
          height: height,
        ),
      ):
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: MemoryImage(image), fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
    /* ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (context, url, error) => Image.asset(
          errorImage.isNotEmpty ? errorImage : AssetImages.imagePlaceholder,
          width: width,
          height: height,
          fit: errorImageFit,
        ),
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: width,
            height: height,
            child: ShimmerLoading(
              isLoading: true,
              child: Container(
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(placeholderImage))),
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}