import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../core/utils/media/dimensions.dart';
import '../resources/colors/colors.dart';
import 'app_image_viewer.dart';
import 'index.dart';

class AppImage extends StatelessWidget {
  final bool imageViewer;
  final String imageURL;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxFit fit;
  const AppImage({
    Key? key,
    required this.imageURL,
    this.imageViewer = true,
    this.height,
    this.width,
    this.borderRadius = 0,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
      child: imageViewer
          ? InkWell(
              onTap: () async {
                showDialog(
                    builder: (context) => AppImageViewer(
                          imageUR: imageURL,
                        ),
                    context: context);
              },
              child: Image.network(
                imageURL,
                height: height,
                width: width,
                filterQuality: FilterQuality.high,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: height,
                    width: width,
                    child: AppLoading(
                      scale: 0.5,
                      color: AppColors.loadingColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                fit: fit,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('ERROR Image: $error', wrapWidth: 1024);
                  return SizedBox(
                      height: height,
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline_sharp),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              context.tr.problem_downloading_image,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: renderFontSizeFromPixels(
                                    context, k8TextSize),
                              ),
                            ),
                          )
                        ],
                      ));
                },
              ),
            )
          : Image.network(
              imageURL,
              height: height,
              width: width,
              filterQuality: FilterQuality.high,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: height,
                  width: width,
                  child: AppLoading(
                    scale: 0.5,
                    color: AppColors.loadingColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_sharp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            context.tr.problem_downloading_image,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize:
                                  renderFontSizeFromPixels(context, k8TextSize),
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
    );
  }
}
