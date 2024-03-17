import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/images/images.dart';

Widget ratingBar(double? rate) {
  return RatingBar(
    ignoreGestures: true,
    initialRating: rate!,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    unratedColor: Colors.yellow.withOpacity(.5),
    tapOnlyMode: true,
    itemCount: 5,
    itemSize: 15,
    itemPadding: const EdgeInsets.only(left: 5.0),
    ratingWidget: RatingWidget(
      full: SvgPicture.asset(
        AppImages.svgStarMark,
      ),
      empty: SvgPicture.asset(
        //AppImages.svgEmptyStar,
        AppImages.svgStarMark,
        color: const Color(0xff626262),
      ),
      half: SvgPicture.asset(
        AppImages.svgHalfStar,
      ),
    ),
    onRatingUpdate: (rating) {},
    updateOnDrag: false,
  );
}
