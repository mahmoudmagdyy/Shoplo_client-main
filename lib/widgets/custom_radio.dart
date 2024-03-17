import 'package:flutter/material.dart';

import '../resources/colors/colors.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;

  const CustomRadioWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.width = 20,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        height: height,
        width: width,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: AppColors.gray,
        ),
        child: Center(
          child: Container(
            height: height - 4,
            width: width - 4,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(),
              color: AppColors.white,
            ),
            child: Center(
              child: value == groupValue
                  ? const Icon(
                      Icons.done,
                      color: AppColors.primaryL,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
