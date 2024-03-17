import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/chat/data/models/uploader.dart';

import '../../../widgets/alert_dialogs/image_picker_alert_dialog.dart';
import 'cubit/uploader_cubit/uploader_cubit.dart';

class AttachMentUploader extends StatefulWidget {
  const AttachMentUploader({super.key, required this.onSuccessfulUpload, required this.onUploadStart, required this.onUploadError});
  final Function(UploaderModel) onSuccessfulUpload;
  final Function() onUploadStart;
  final Function(String) onUploadError;

  @override
  State<AttachMentUploader> createState() => _AttachMentUploderState();
}

class _AttachMentUploderState extends State<AttachMentUploader> {
  List<File> files = [];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImagePickerDialogBox(
                        onPickImage: (image) {
                          setState(() {
                            files.add(image);
                          });
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
        ...files
            .map(
              (e) => AttachmentWidget(
                file: e,
                onSuccessfulUpload: widget.onSuccessfulUpload,
                onUploadStart: widget.onUploadStart,
                onUploadError: widget.onUploadError,
              ),
            )
            .toList()
      ],
    );
  }
}

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({
    super.key,
    required this.file,
    required this.onSuccessfulUpload,
    required this.onUploadStart,
    required this.onUploadError,
  });
  final File file;
  final Function(UploaderModel) onSuccessfulUpload;
  final Function(String) onUploadError;
  final Function() onUploadStart;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploaderCubit()..upload({'file': MultipartFile.fromFileSync(file.path), "path": "shipments"}),
      child: BlocConsumer<UploaderCubit, UploaderState>(listener: (context, state) {
        if (state is UploadSuccessState) {
          onSuccessfulUpload(UploaderModel.fromJson(state.data));
        }
        if (state is UploadLoadingState) {
          onUploadStart();
        }
        if (state is UploadErrorState) {
          onUploadError(state.error);
        }
      }, builder: (context, state) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Builder(builder: (context) {
            if (state is UploadLoadingState) {
              print(state.progress);
              return Stack(
                children: [
                  Image.file(
                    file,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // black overlay
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Center(
                      child: CircularProgressIndicator(
                    value: state.progress?.toDouble(),
                  )),
                ],
              );
            }
            if (state is UploadSuccessState) {
              return Stack(
                children: [
                  Image.file(
                    file,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Center(
                      child: Icon(
                    Icons.check,
                    color: Colors.green,
                  )),
                ],
              );
            }
            if (state is UploadErrorState) {
              return Stack(
                children: [
                  Image.file(
                    file,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<UploaderCubit>().upload({'file': MultipartFile.fromFileSync(file.path), "path": "shipments"});
                    },
                    child: const Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    )),
                  ),
                ],
              );
            } else {
              return Image.file(
                file,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }
          }),
        );
      }),
    );
  }
}
