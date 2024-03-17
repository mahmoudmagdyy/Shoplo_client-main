import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_image.dart';
import '../../../layout/presentation/cubit/app/app_cubit.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../data/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return Row(
          mainAxisAlignment: message.sender.id == cubit.userData!.user.id
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: message.sender.id == cubit.userData!.user.id
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: message.sender.id == cubit.userData!.user.id
                          ? AppColors.primaryL
                          : AppColors.textAppGray.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: Radius.circular(
                            message.sender.id == cubit.userData!.user.id
                                ? 10
                                : 0),
                        bottomRight: Radius.circular(
                            message.sender.id == cubit.userData!.user.id
                                ? 0
                                : 10),
                      ),
                    ),
                    child: Column(
                      children: [
                        if (message.messageType == 'text')
                          Text(
                            message.message,
                            style: TextStyle(
                              color: message.sender.id ==
                                      1 // cubit.userData.user!.id
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        if (message.messageType == 'image')
                          AppImage(
                            imageURL: message.message,
                            width: 100,
                            height: 100,
                          ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat(
                      'dd MMM yyyy',
                      AppCubit.get(context).getCurrentLanguage(context),
                    ).format(DateTime.now()),
                    style: const TextStyle(
                      color: AppColors.textAppGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
