import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../resources/colors/colors.dart';
import 'app_loading.dart';

class AppImageViewer extends StatelessWidget {
  final String imageUR;
  const AppImageViewer({Key? key, required this.imageUR}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(),
          imageProvider: NetworkImage(
            imageUR,
          ),
          minScale: 0.15,
          maxScale: 1.75,
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
    );
  }
}
