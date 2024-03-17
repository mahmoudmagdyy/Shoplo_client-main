import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../features/products/data/models/product_details.dart';
import '../resources/colors/colors.dart';
import 'index.dart';

class AppSwiper extends StatefulWidget {
  final List<Attachments> slider;
  final bool banner;
  const AppSwiper({
    Key? key,
    required this.slider,
    this.banner = false,
  }) : super(key: key);
  @override
  AppSwiperState createState() => AppSwiperState();
}

class AppSwiperState extends State<AppSwiper> {
  late SwiperController _controller;

  @override
  void initState() {
    _controller = SwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   AppRoutes.adImageViewer,
                //   arguments: {'list': widget.slider},
                // );
              },
              child: Stack(
                children: [
                  AppImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageURL: widget.slider[index].file,
                    fit: BoxFit.cover,
                    borderRadius: 0,
                    imageViewer: false,
                  ),
                  const Positioned(
                    bottom: 5,
                    right: 3,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
      autoplay: true,
      autoplayDelay: 3000,
      curve: Curves.easeInOut,
      itemCount: widget.slider.length,
      pagination: const SwiperPagination(
        margin: EdgeInsets.only(bottom: 12, right: 10),
        alignment: Alignment.bottomRight,
        builder: FractionPaginationBuilder(
          color: AppColors.black,
          activeColor: AppColors.secondaryL,
          fontSize: 14,
          activeFontSize: 20,
        ),
      ),
      controller: _controller,
    );
  }
}
