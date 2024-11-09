import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tap_wrapper.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.borderRadius = 0,
      this.errorWidget,
      this.headers,
      this.placeholder,
      this.showImageOnTap = false,
      this.hasAnimation = false});
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool hasAnimation;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool showImageOnTap;
  final Map<String, String>? headers;

  ExtendedNetworkImageProvider provider() {
    return ExtendedNetworkImageProvider(imageUrl ?? '', printError: false);
  }

  Widget _wImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: kIsWeb
          ? Image.network(imageUrl ?? '', width: width, height: height, fit: fit)
          : ExtendedImage.network(
              imageUrl ?? '',
              maxBytes: 1 * 1024 * 1024,
              width: width,
              height: height,
              headers: headers,
              fit: fit,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return placeholder ??
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: const Center(),
                        );
                  case LoadState.completed:
                    return TapWrapper(
                      onTap: showImageOnTap
                          ? () {
                            }
                          : null,
                      child: ExtendedRawImage(
                        image: state.extendedImageInfo?.image,
                        width: width,
                        height: height,
                        fit: fit,
                      ),
                    );
                  case LoadState.failed:
                    state.imageProvider.evict();
                    return errorWidget ??
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: Center(child: Icon(Icons.error, color: Colors.grey.shade400)),
                        );
                }
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return hasAnimation && imageUrl != null ? Hero(tag: imageUrl!, child: _wImage(context)) : _wImage(context);
  }
}
