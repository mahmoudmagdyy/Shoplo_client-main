import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/services/navigation_service.dart';
import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';

class ImagePickerDialogBox extends StatefulWidget {
  final Function onPickImage;
  final ValueChanged<List<XFile>>? onPickMultiImage;
  final bool multi;

  const ImagePickerDialogBox({
    Key? key,
    required this.onPickImage,
    this.onPickMultiImage,
    this.multi = false,
  }) : super(key: key);

  @override
  _ImagePickerDialogBoxState createState() => _ImagePickerDialogBoxState();
}

class _ImagePickerDialogBoxState extends State<ImagePickerDialogBox> {
  File? image;
  List<XFile>? images = [];

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  NavigationService.navigatorKey.currentContext!.tr.choose_photo_from,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryL,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Center(
                  child: Container(
                    height: 1.0,
                    color: AppColors.gray,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        pickImage(ImageSource.camera);
                        // var status = await Permission.camera.status;
                        // debugPrint('STATUS: ${status.isGranted}',
                        //     wrapWidth: 1024);
                        // if (status.isGranted) {
                        //   pickImage(ImageSource.camera);
                        // } else {
                        //   Navigator.of(context).pop();
                        //   AppSettings.openAppSettings();
                        // }
                      },
                      child: Text(
                        NavigationService.navigatorKey.currentContext!.tr.camera,
                        style: const TextStyle(color: AppColors.primaryL),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Container(
                        width: 1.0,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (widget.multi) {
                          pickMultiImage();
                        } else {
                          pickImage(ImageSource.gallery);
                        }
                      },
                      child: Text(
                        NavigationService.navigatorKey.currentContext!.tr.gallery,
                        style: const TextStyle(color: AppColors.primaryL),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      // FilePickerResult? result = await FilePicker.platform.pickFiles();
      // debugPrint('RESULT xxx: $result', wrapWidth: 1024);

      // if (result != null) {
      //   File file = File(result.files.single.path!);
      //   debugPrint('FILE xxx: $file', wrapWidth: 1024);
      // } else {
      //   // User canceled the picker
      // }
      final image = await ImagePicker().pickImage(
        source: imageSource,
        maxHeight: imageSource == ImageSource.camera ? 1000 : null,
        maxWidth: imageSource == ImageSource.camera ? 1000 : null,
        // imageQuality: 100,
      );
      debugPrint('IMAGE: ${image.toString()}', wrapWidth: 1024);
      if (image == null) return;
      final imageTemp = File(image.path);
      debugPrint('imageTemp=>>>$imageTemp');
      widget.onPickImage(imageTemp);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future pickMultiImage() async {
    try {
      images = await ImagePicker().pickMultiImage();
      debugPrint("🚀 ~ file: image_picker_alert_dialog.dart ~ line 164 ~ _ImagePickerDialogBoxState ~ FuturepickMultiImage ~ $images");
      if (images == null) return;
      widget.onPickMultiImage!(images!);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}
