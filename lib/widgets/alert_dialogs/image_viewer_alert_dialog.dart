import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';
import '../app_loading.dart';

class ImageViewerDialogBox extends StatefulWidget {
  final String imageURL;

  const ImageViewerDialogBox({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  _ImageViewerDialogBoxState createState() => _ImageViewerDialogBoxState();
}

class _ImageViewerDialogBoxState extends State<ImageViewerDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(color: Colors.black,offset: Offset(0,5),
            //   blurRadius: 10
            //   ),
            // ]
          ),
          child: PhotoView(
            backgroundDecoration:
                const BoxDecoration(color: AppColors.primaryL),
            imageProvider: NetworkImage(
              widget.imageURL,
            ),
            minScale: 0.25,
            maxScale: 1.5,
            loadingBuilder: (BuildContext context, event) {
              if (event == null) {
                return const Center(
                  child: Text("Loading"),
                );
              }
              final value = event.cumulativeBytesLoaded /
                  (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);
              return AppLoading(
                scale: 0.5,
                color: AppColors.loadingColor,
                value: value,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_sharp),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      context.tr.problem_downloading_image,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
