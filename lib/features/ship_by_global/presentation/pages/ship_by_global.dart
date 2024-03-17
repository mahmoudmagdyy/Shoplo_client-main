import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/app_stepper.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../domain/entities/ship_by_global.dart';
import '../cubit/ship_by_global_cubit.dart';
import '../widgets/recevier_address_details.dart';
import '../widgets/sender_address_details.dart';
import '../widgets/shipping_details.dart';

class ShipByGlobalScreen extends HookWidget {
  const ShipByGlobalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final request = useState<ShipByGlobalEntity>(ShipByGlobalEntity());

    //form
    final stepOneformKey = useState(GlobalKey<FormState>());
    final selectedStep = useState(1);
    final shippmentType = useState("international");

    return BlocProvider(
      create: (context) => ShipByGlobalCubit(),
      child: WillPopScope(
        onWillPop: () async {
          if (selectedStep.value == 1) {
            return true;
          } else {
            selectedStep.value = 1;
            return false;
          }
        },
        child: Builder(builder: (context) {
          final cubit = ShipByGlobalCubit.get(context);
          return Scaffold(
            appBar: appAppBar(
              context,
              context.tr.ship_by_global,
              onPress: () {
                if (selectedStep.value == 1) {
                  Navigator.pop(context);
                } else {
                  selectedStep.value = 1;
                }
              },
            ),
            body: NetworkSensitive(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppCustomStepper<int>(
                            selectedStep: selectedStep.value,
                            onStepTapped: (item) {
                              if (item < selectedStep.value) {
                                selectedStep.value = item;
                              }
                            },
                            steps: const [1, 2])),
                    Form(
                      key: stepOneformKey.value,
                      child: Visibility(
                        maintainState: true,
                        visible: selectedStep.value == 1,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            // text
                            Text(
                              context.tr.shipping_type,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text(context.tr.international),
                                    value: "international",
                                    groupValue: shippmentType.value,
                                    onChanged: (String? value) {
                                      shippmentType.value = value!;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text(context.tr.local),
                                    value: "local",
                                    groupValue: shippmentType.value,
                                    onChanged: (String? value) {
                                      shippmentType.value = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SenderAddressDetails(request.value),
                            const Divider(
                              height: 30,
                            ),
                            ReceiverAddressDetails(request.value),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryL,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (stepOneformKey.value.currentState!.validate() && cubit.validate(context, request.value)) {
                                      if (shippmentType.value == "local" && request.value.senderCountry != request.value.receiverCountry) {
                                        AppSnackBar.showError(context.tr.country_validate_local);
                                        return;
                                      }
                                      if (shippmentType.value == "international" && request.value.senderCountry == request.value.receiverCountry) {
                                        AppSnackBar.showError(context.tr.country_validate_international);
                                        return;
                                      }
                                      selectedStep.value = 2;
                                      //
                                    }
                                  },
                                  child: Text(context.tr.next)),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedStep.value == 2,
                      child: ShipByGlobalShippingDetails(
                        shipByGlobalEntity: request.value,
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
        }),
      ),
    );
  }
}
