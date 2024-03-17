import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/cart/presentation/widgets/cart_address.dart';
import 'package:shoplo_client/widgets/form_field/date_picker.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../home/data/models/place_details.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/add_order_cubit.dart';
import '../cubit/cart_cubit.dart';

class CartGoogleStoreScreen extends HookWidget {
  final PlaceDetails store;

  const CartGoogleStoreScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = UserCubit.get(context);

    final descriptionController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final priceController = useTextEditingController();
    final fromController = useTextEditingController();
    final toController = useTextEditingController();
    final addressController = useTextEditingController(
        text: (userCubit.userData != null &&
                userCubit.userData!.user.addresses.isNotEmpty)
            ? userCubit.userData!.user.addresses[0].id.toString()
            : '');

    useEffect(() {
      if (userCubit.userData != null &&
          userCubit.userData!.user.addresses.isNotEmpty) {
        CartCubit.get(context)
            .setCartAddress(userCubit.userData!.user.addresses[0]);
      }
      return null;
    }, [userCubit.userData]);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final dateTime = useState(DateTime.now());

    return Scaffold(
      appBar: appAppBar(context, store.name),
      body: NetworkSensitive(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.sizedH10,
                  AppTextFormField(
                    // readOnly: true,
                    label: context.tr.description,
                    controller: descriptionController,
                    maxLine: 7,
                  ),
                  AppSizedBox.sizedH10,
                  AppTextFormField(
                    label: context.tr.price,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                  ),
                  AppSizedBox.sizedH10,
                  Text(context.tr.delivery_time),
                  AppSizedBox.sizedH5,
                  AppDatePicker(
                    type: 'dateTime',
                    controller: fromController,
                    label: context.tr.from,
                    onInit: (val) {
                      dateTime.value = val;
                      debugPrint("get time picker data ${dateTime.value}");
                    },
                  ),
                  AppSizedBox.sizedH10,
                  AppDatePicker(
                    type: 'dateTime',
                    controller: toController,
                    firstDate: dateTime.value,
                    label: context.tr.to,
                    onInit: (val) {
                      //  dateTime.value = val;
                    },
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: AppTextFormField(
                  //         label: context.tr.from,
                  //         controller: fromController,
                  //         suffixIcon: IconButton(
                  //           icon: const Text('AM'),
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //     ),
                  //     AppSizedBox.sizedW20,
                  //     Expanded(
                  //       child: AppTextFormField(
                  //         label: context.tr.to,
                  //         controller: toController,
                  //         suffixIcon: IconButton(
                  //           icon: const Text('PM'),
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  AppSizedBox.sizedH10,
                  CartAddressWidget(
                    controller: addressController,
                  ),
                  AppSizedBox.sizedH10,
                  // const CartPriceWidget(),
                  AppSizedBox.sizedH30,
                  AppButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Map<String, String> data = {
                          "user_address_id": CartCubit.get(context)
                              .cartAddress!
                              .id
                              .toString(), // addressController.text,
                          "store_lat": store.lat.toString(),
                          "store_long": store.lng.toString(),
                          "store_address": store.address,
                          "notes": descriptionController.text,
                          "order_price": priceController.text,
                          "order_type": "outer",
                          "delivery_date": fromController.text,
                          "delivery_date_to": toController.text,
                          "use_wallet": '1',
                          "storeName": store.name,
                          "store_name": store.name,
                          "store_image": store.photos.isNotEmpty
                              ? store.photos[0]
                              : store.icon,
                        };
                        debugPrint('DATA === ==: $data', wrapWidth: 1024);

                        AddOrderCubit.get(context).setOrderData(data);
                        Navigator.of(context).pushNamed(
                          AppRoutes.previewCartGoogleStoreScreen,
                          arguments: data,
                        );
                      }
                    },
                    title: context.tr.view_order,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
