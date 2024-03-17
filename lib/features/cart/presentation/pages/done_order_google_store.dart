import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../network/presentation/pages/network_sensitive.dart';

class DoneOrderGoogleStoreScreen extends HookWidget {
  const DoneOrderGoogleStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController(
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque ut massa ullamcorper semper elit augue. Tincidunt a pellentesque hac enim, ultricies vel id mattis convallis.');
    final priceController = useTextEditingController(text: 'Price');
    return WillPopScope(
      onWillPop: () async {
        debugPrint("onWillPop");

        // CartCubit cartCubit = CartCubit.get(context);
        // cartCubit.setCartCount(0);
        Navigator.of(context).popUntil(
          (route) => route.settings.name == AppRoutes.appHome,
        );
        return false;
      },
      child: Scaffold(
        // appBar: appAppBar(context, context.tr.place_order),
        body: NetworkSensitive(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          AppImages.success,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSizedBox.sizedH10,
                          const Icon(
                            Icons.check_circle,
                            size: 50,
                            color: AppColors.primaryL,
                          ),
                          AppSizedBox.sizedH10,
                          Text(
                            context.tr.thank_you,
                            style: AppTextStyle.textStyleMediumGold,
                          ),
                          Text(
                            context.tr.payment_successfully,
                            style: AppTextStyle.textStyleMediumGray,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSizedBox.sizedH10,
                  AppTextFormField(
                    readOnly: true,
                    label: context.tr.description,
                    controller: descriptionController,
                    maxLine: 7,
                  ),
                  AppSizedBox.sizedH10,
                  AppTextFormField(
                    readOnly: true,
                    label: context.tr.price,
                    suffixIcon: SizedBox(
                      width: context.width * .1,
                      child: const Center(
                        child: Text(
                          '12\$',
                          style: AppTextStyle.textStyleSemiBoldGold16,
                        ),
                      ),
                    ),
                    controller: priceController,
                  ),
                  AppSizedBox.sizedH10,
                  // const CartDeliverToWidget(),
                  AppSizedBox.sizedH10,
                  // const CartPriceWidget(),
                  AppSizedBox.sizedH20,
                  AppButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.orderDetails,
                          arguments: {"type": 'new', "orderId": 4});
                    },
                    title: context.tr.track_order,
                  ),
                  AppSizedBox.sizedH10,
                  AppButtonOutline(
                    title: context.tr.home,
                    onPressed: () {
                      // CartCubit cartCubit = CartCubit.get(context);
                      // cartCubit.setCartCount(0);
                      Navigator.of(context).popUntil(
                        (route) => route.settings.name == AppRoutes.appHome,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
