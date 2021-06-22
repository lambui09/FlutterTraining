import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/resource_app.dart';

Widget buildImage(String? imageUrl, [BoxFit? fit]) {
  Widget placeHolder = Image.asset(ResourceUtils.ic_logo);
  if (imageUrl == null) {
    return placeHolder;
  }
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.cover,
    // placeholder: (context, url) => placeHolder,
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
