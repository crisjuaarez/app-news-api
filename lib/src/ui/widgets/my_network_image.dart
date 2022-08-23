import 'package:flutter/material.dart';

import '../theme/my_colors.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage(
    this.url, {
    Key? key,
    required this.height,
    this.width = double.infinity,
  }) : super(key: key);

  final String url;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, progress) => Container(
        color: MyColors.grey,
        child: Stack(
          children: [
            if (progress?.cumulativeBytesLoaded == progress?.expectedTotalBytes)
              const Center(child: CircularProgressIndicator.adaptive()),
            child,
          ],
        ),
      ),
    );
  }
}
