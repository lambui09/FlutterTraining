import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildImage(String? imageUrl, [BoxFit? fit = BoxFit.cover]) {
  Widget placeHolder = Center(
    child: CircularProgressIndicator(),
  );
  if (imageUrl == null) {
    return placeHolder;
  }
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    placeholder: (context, url) => placeHolder,
    errorWidget: (context, url, error) => Center(
      child: Icon(
        Icons.error_sharp,
        size: 70,
      ),
    ),
  );
}
