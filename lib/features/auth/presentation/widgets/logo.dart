import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/images/images.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * .03,
        ),
        Center(
          child: Image.asset(
            AppImages.logoglobal,
            fit: BoxFit.contain,
            width: context.width * .4,
            height: context.width * .4,
          ),
        ),
        SizedBox(
          height: context.height * .05,
        ),
      ],
    );
  }
}
