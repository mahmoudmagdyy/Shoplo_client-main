// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:qimam/models/ad.dart';
//
// import '../resources/colors/colors.dart';
// import 'app_loading.dart';
//
// class AppImageViewerGallery extends StatefulWidget {
//   final List<Attachments> imageURList;
//   final int initIndex;
//   const AppImageViewerGallery(
//       {Key? key, required this.imageURList, required this.initIndex})
//       : super(key: key);
//
//   @override
//   State<AppImageViewerGallery> createState() => _AppImageViewerGalleryState();
// }
//
// class _AppImageViewerGalleryState extends State<AppImageViewerGallery> {
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//         initialPage: widget.initIndex, keepPage: false, viewportFraction: 1);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text( context.tr.ad_details),
//       ),
//       body: PhotoViewGallery.builder(
//         // customSize: Size(getSize(context).width*.5,getSize(context).height*.5),
//         scrollPhysics: const BouncingScrollPhysics(),
//         builder: (BuildContext context, int index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: NetworkImage(
//               widget.imageURList[index].file,
//             ),
//             initialScale: PhotoViewComputedScale.contained,
//             minScale: PhotoViewComputedScale.contained,
//             heroAttributes:
//                 PhotoViewHeroAttributes(tag: widget.imageURList[index].file),
//           );
//         },
//         pageController: _pageController,
//         backgroundDecoration: const BoxDecoration(
//           color: AppColors.white,
//         ),
//         itemCount: widget.imageURList.length,
//         loadingBuilder: (BuildContext context, event) {
//           if (event == null) {
//             return const Center(
//               child: Text("Loading"),
//             );
//           }
//           final value = event.cumulativeBytesLoaded /
//               (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);
//           return AppLoading(
//             scale: 0.5,
//             color: AppColors.loadingColor,
//             value: value,
//           );
//         },
//       ),
//     );
//   }
// }
