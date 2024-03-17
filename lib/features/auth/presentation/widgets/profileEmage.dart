import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/image_picker_alert_dialog.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../chat/presentation/cubit/uploader_cubit/uploader_cubit.dart';

class ProfileImage extends StatefulWidget {
  final String profileImage;
  final ValueChanged<String>? onSelect;
  const ProfileImage({Key? key, this.onSelect, this.profileImage = ""})
      : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  ///image
  File? image;
  String imageUri = '';
  String imageName = '';

  showImagePickerDialog() {
    return showDialog(

      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<UploaderCubit, UploaderState>(
            listener: (context, state) {
          if (state is UploadErrorState) {
            AppSnackBar.showError(state.error);
          }
          if (state is UploadSuccessState) {
            debugPrint('UploadSuccessState=> ${state.data}');
          }
        }, builder: (context, state) {
          UploaderCubit cubit = UploaderCubit.get(context);
          return ImagePickerDialogBox(
            onPickImage: (image) async {
              debugPrint('IMAGE 222222 2222 : $image}', wrapWidth: 1024);
              String fileName =
                  image != null ? image!.path.split('/').last : "";

              MultipartFile fileData =
                  await MultipartFile.fromFile(image!.path, filename: fileName);
              cubit.upload({'file': fileData, 'path': 'users/avatar'});
              // Navigator.pop(context, 'Ok');
            },
          );
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.profileImage != "") {
      imageUri = widget.profileImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Constants.padding30,
          Constants.padding20, Constants.padding30, Constants.padding20),
      child: Stack(
        alignment: const Alignment(0.9, 0.9),
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AppColors.secondaryL,
            radius: 50.0,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 50.0,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: BlocConsumer<UploaderCubit, UploaderState>(
                    listener: (context, state) {
                      if (state is UploadErrorState) {
                        AppSnackBar.showError(state.error);
                      }
                      if (state is UploadSuccessState) {
                        setState(() {
                          debugPrint("show image profile1 ==>${state.data}");
                          debugPrint(
                              "show image profile2 ==> ${state.data['file']}");
                          imageUri = state.data['file'];
                          widget.onSelect!(imageUri);
                        });
                      }
                    },
                    builder: (context, state) {
                      return state is UploadLoadingState
                          ? const AppLoading(color: AppColors.primaryL)
                          : CachedNetworkImage(
                              imageUrl: imageUri != ''
                                  ? imageUri
                                  : AppImages.testImageNetwork,
                              placeholder: (context, url) =>
                                  const AppLoading(color: AppColors.primaryL),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  )));
                    },
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => showImagePickerDialog(),
            child: Container(
              height: context.width * .06,
              width: context.width * .06,
              alignment: Alignment.bottomRight,
              child: Image.asset(AppImages.edit),
            ),
          ),
        ],
      ),
    );
  }
}
