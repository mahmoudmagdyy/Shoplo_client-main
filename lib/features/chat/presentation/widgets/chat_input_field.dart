import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/image_picker_alert_dialog.dart';
import '../../../../widgets/app_image.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/uploader_cubit/uploader_cubit.dart';

class ChatInputField extends HookWidget {
  final int orderId;

  const ChatInputField({
    required this.orderId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final imageUri = useState('');
    final imageName = useState('');

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 3,
      ),
      decoration: const BoxDecoration(
        color: AppColors.textAppWhiteDark,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (imageUri.value.isNotEmpty)
              Column(
                children: [
                  Stack(
                    children: [
                      AppImage(
                        height: 150,
                        imageURL: imageUri.value,
                        borderRadius: 10,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: CircleAvatar(
                          radius: 15,
                          child: InkWell(
                            child: const Icon(Icons.close),
                            onTap: () {
                              imageUri.value = '';
                              imageName.value = '';
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                fillColor: AppColors.textAppWhiteDark,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: AppLocalizations.of(context)!.write_your_message_here,
                labelStyle: const TextStyle(
                  color: AppColors.textAppGray,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.textAppGray,
                ),
                labelText:
                    AppLocalizations.of(context)!.write_your_message_here,
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        // decoration: const BoxDecoration(
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        //   color: AppColors.primaryL,
                        // ),
                        child: BlocConsumer<UploaderCubit, UploaderState>(
                          listener: (context, state) {
                            ChatCubit cubit = ChatCubit.get(context);

                            if (state is UploadErrorState) {
                              AppSnackBar.showError(state.error);
                            }
                            if (state is UploadSuccessState) {
                              debugPrint('STATE xxxx: $state', wrapWidth: 1024);
                              imageUri.value = state.data['file'];
                              imageName.value = state.data['name'];
                              cubit.sendMessage({
                                'order_id': orderId,
                                'message': imageUri.value,
                                'type': 'image',
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is UploadLoadingState) {
                              return const AppLoading(
                                scale: .5,
                              );
                            } else {
                              return IconButton(
                                color: AppColors.primaryL,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      UploaderCubit cubit =
                                          UploaderCubit.get(context);
                                      return ImagePickerDialogBox(
                                        onPickImage: (image) async {
                                          debugPrint(
                                              'IMAGE 222222 2222 : $image}',
                                              wrapWidth: 1024);
                                          String fileName = image != null
                                              ? image!.path.split('/').last
                                              : "";

                                          MultipartFile fileData =
                                              await MultipartFile.fromFile(
                                                  image!.path,
                                                  filename: fileName);
                                          cubit.upload({
                                            'file': fileData,
                                            'path': 'chat'
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.image_outlined,
                                  color: AppColors.black,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        // decoration: BoxDecoration(
                        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                        //   color: message.trim().isNotEmpty || imageUri != ''
                        //       ? AppColors.primaryL
                        //       : AppColors.textAppGray,
                        // ),
                        child: BlocConsumer<ChatCubit, ChatState>(
                          listener: (context, state) {
                            if (state is SendMessageSuccessState) {
                              // AppToast.showToastSuccess(
                              //     AppLocalizations.of(context)!
                              //         .sent_successfully);
                              imageUri.value = '';
                              imageName.value = '';
                              messageController.clear();
                            } else if (state is SendMessageErrorState) {
                              AppSnackBar.showError(state.error);
                            }
                          },
                          builder: (context, state) {
                            ChatCubit cubit = ChatCubit.get(context);

                            if (state is SendMessageLoadingState) {
                              return const AppLoading(
                                scale: .5,
                              );
                            } else {
                              return IconButton(
                                onPressed: () {
                                  if (messageController.text.isNotEmpty ||
                                      imageUri.value.isNotEmpty) {
                                    cubit.sendMessage({
                                      'order_id': orderId,
                                      'message': imageUri.value.isNotEmpty
                                          ? imageUri.value
                                          : messageController.text,
                                      'type': imageUri.value.isNotEmpty
                                          ? 'image'
                                          : 'text',
                                    });
                                  }
                                },
                                iconSize: 20,
                                icon: SvgPicture.asset(
                                  AppImages.send,
                                  color: AppColors.primaryL,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
