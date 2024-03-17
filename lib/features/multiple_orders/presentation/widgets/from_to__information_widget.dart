import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

class FromAndToInformation extends StatelessWidget {
  const FromAndToInformation({
    super.key,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
  });
  final String? fromDate;
  final String? toDate;
  final String? fromTime;
  final String? toTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.from,
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.calender),
                    const SizedBox(width: 10),
                    Text(
                      fromDate ?? "",
                      style: AppTextStyle.textStyleMediumGray,
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppImages.time),
                    const SizedBox(width: 10),
                    Text(
                      fromTime ?? "",
                      style: AppTextStyle.textStyleMediumGray,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.to,
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.calender),
                    const SizedBox(width: 10),
                    Text(
                      toDate ?? "",
                      style: AppTextStyle.textStyleMediumGray,
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppImages.time),
                    const SizedBox(width: 10),
                    Text(
                      toTime ?? "",
                      style: AppTextStyle.textStyleMediumGray,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
