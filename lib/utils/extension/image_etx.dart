import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/resource/image_app.dart';

Widget buildImage(String? imageUrl, [BoxFit? fit = BoxFit.cover]) {
  Widget placeHolder = Image.asset(ImageApp.ic_logo);
  if (imageUrl == null) {
    return placeHolder;
  }
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    // placeholder: (context, url) => placeHolder,
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
