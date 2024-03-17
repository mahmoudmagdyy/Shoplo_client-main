import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/helpers/currency_helper.dart';
import 'package:shoplo_client/features/cart/data/models/payment.dart';
import 'package:shoplo_client/features/cart/presentation/cubit/payment_cubit.dart';
import 'package:shoplo_client/features/cart/presentation/widgets/payment_methods.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_image.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../chat/presentation/cubit/uploader_cubit/uploader_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/bank_account.dart';
import '../../data/models/preview_order.dart';
import '../cubit/add_order_cubit.dart';
import '../cubit/bank_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/bank_account.dart';

class PaymentScreen extends HookWidget {
  final Map<String, String> orderData;
  final PreviewOrderModal previewOrder;

  const PaymentScreen({
    super.key,
    required this.orderData,
    required this.previewOrder,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedPaymentMethod = useState(
      PaymentModel(id: -1, name: 'name', type: 'type', isActive: -1),
    );
    final selectedBankAccount = useState(
      BankAccountModel(
          id: -1, isActive: false, image: 'image', accountNumber: 'accountNumber', ibanNumber: 'ibanNumber', name: 'name', createdAt: 'createdAt'),
    );
    final depositorNameController = useTextEditingController();
    final depositAmountController = useTextEditingController();
    final isUseWallet = useState(false);
    final isPdf = useState(false);
    final imageUri = useState('');

    return Scaffold(
      appBar: appAppBar(context, context.tr.payment),
      body: NetworkSensitive(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        context.tr.select_payment_method,
                        style: AppTextStyle.textStyleMediumGray,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => PaymentCubit(),
                      child: BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                          PaymentCubit cubit = PaymentCubit.get(context);
                          return AppList(
                            key: const Key('paymentMethodList'),
                            noSeparatorBuilder: true,
                            fetchPageData: (query) => {cubit.getPaymentMethods()},
                            loadingListItems: state is GetPaymentLoadingState,
                            hasReachedEndOfResults: true,
                            endLoadingFirstTime: true,
                            itemBuilder: (context, index) => PaymentMethodsWidget(
                              paymentMethod: cubit.paymentMethods[index],
                              selectedPaymentMethod: selectedPaymentMethod.value,
                              onSelected: (payment) {
                                selectedPaymentMethod.value = payment;
                              },
                            ),
                            listItems: cubit.paymentMethods,
                          );
                        },
                      ),
                    ),
                    if (selectedPaymentMethod.value.type == 'bank_transfer')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                            child: Text(
                              context.tr.bank_accounts,
                              style: AppTextStyle.textStyleMediumGray,
                            ),
                          ),
                          BlocProvider(
                            create: (context) => BankCubit(),
                            child: BlocBuilder<BankCubit, BankState>(
                              builder: (context, state) {
                                BankCubit cubit = BankCubit.get(context);
                                return AppList(
                                  key: const Key('paymentMethodList'),
                                  noSeparatorBuilder: true,
                                  fetchPageData: (query) => {cubit.getBankAccounts()},
                                  loadingListItems: state is GetBanksLoadingState,
                                  hasReachedEndOfResults: true,
                                  endLoadingFirstTime: true,
                                  itemBuilder: (context, index) => BankAccountWidget(
                                    bankAccount: cubit.bankAccounts[index],
                                    selectedBankAccount: selectedBankAccount.value,
                                    onSelected: (payment) {
                                      selectedBankAccount.value = payment;
                                    },
                                  ),
                                  listItems: cubit.bankAccounts,
                                );
                              },
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextFormField(
                                    controller: depositorNameController,
                                    label: context.tr.depositor_name,
                                  ),
                                  AppTextFormField(
                                    controller: depositAmountController,
                                    label: context.tr.deposit_amount,
                                    keyboardType: TextInputType.number,
                                  ),
                                  AppSizedBox.sizedH10,
                                  BlocConsumer<UploaderCubit, UploaderState>(
                                    listener: (context, state) {
                                      if (state is UploadErrorState) {
                                        AppToast.showToastError(state.error);
                                      }
                                      if (state is UploadSuccessState) {
                                        imageUri.value = state.data['file'];
                                      }
                                    },
                                    builder: (context, state) {
                                      UploaderCubit cubit = UploaderCubit.get(context);
                                      return state is UploadLoadingState
                                          ? const Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'jpg',
                                                    'pdf',
                                                    'png',
                                                    'jpeg',
                                                  ],
                                                );
                                                if (result != null) {
                                                  PlatformFile file = result.files.single;
                                                  debugPrint(file.name);
                                                  debugPrint(file.bytes.toString());
                                                  debugPrint(file.size.toString());
                                                  debugPrint(file.extension);
                                                  debugPrint(file.path);
                                                  if (file.extension == 'pdf') {
                                                    isPdf.value = true;
                                                  } else {
                                                    isPdf.value = false;
                                                  }
                                                  MultipartFile fileData = await MultipartFile.fromFile(
                                                    file.path!,
                                                    filename: file.name,
                                                  );
                                                  cubit.upload({'file': fileData, 'path': "bank_transfer"});
                                                } else {
                                                  // User canceled the picker
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 20,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                    width: .5,
                                                    color: AppColors.grey,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: imageUri.value.isNotEmpty
                                                    ? isPdf.value
                                                        ? SizedBox(
                                                            height: 200,
                                                            child: PDF(
                                                              enableSwipe: false,
                                                              swipeHorizontal: false,
                                                              autoSpacing: false,
                                                              pageSnap: false,
                                                              pageFling: false,
                                                              fitEachPage: false,
                                                              onError: (error) {
                                                                debugPrint(error.toString());
                                                              },
                                                              onPageError: (page, error) {
                                                                debugPrint('$page: ${error.toString()}');
                                                              },
                                                              onPageChanged: (int? page, int? total) {
                                                                debugPrint('page change: $page/$total');
                                                              },
                                                            ).cachedFromUrl(
                                                              imageUri.value,
                                                              placeholder: (progress) => Center(child: Text('$progress %')),
                                                              errorWidget: (error) => Center(child: Text(error.toString())),
                                                            ),
                                                          )
                                                        : AppImage(
                                                            imageURL: imageUri.value,
                                                            width: double.infinity,
                                                            height: 150,
                                                            fit: BoxFit.contain,
                                                          )
                                                    : Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(
                                                            Icons.cloud_upload,
                                                            color: AppColors.grey,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(context.tr.choose_file)
                                                        ],
                                                      ),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    // if (previewOrder.wallet != '0.00')
                    //   Row(
                    //     children: [
                    //       Checkbox(
                    //         checkColor: AppColors.primaryL,
                    //         activeColor: AppColors.gray,
                    //         value: isUseWallet.value,
                    //         onChanged: (value) {
                    //           isUseWallet.value = value!;
                    //         },
                    //       ),
                    //       Text(
                    //         context.tr.use_wallet,
                    //         style: const TextStyle(
                    //           color: AppColors.grey,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(context.tr.total),
                      Text(
                        "${previewOrder.total} ${CurrencyHelper.currencyString(context)}",
                        style: AppTextStyle.textStyleMediumGold.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  BlocProvider(
                    create: (context) => AddOrderCubit(),
                    child: BlocConsumer<AddOrderCubit, AddOrderState>(
                      listener: (context, state) {
                        if (state is AddOrderErrorState) {
                          AppToast.showToastError(state.error);
                        }
                        if (state is AddOrderSuccessState) {
                          if (state.message.isNotEmpty) {
                            AppToast.showToastSuccess(state.message);
                            if (orderData['order_type'] == 'inner') {
                              CartCubit.get(context).setCartCount(0);
                            }
                            Navigator.of(context).pushNamed(
                              AppRoutes.doneOrderScreen,
                              arguments: state.order,
                            );

                            // CartCubit cartCubit = CartCubit.get(context);
                            // cartCubit.setCartCount(0);
                            // Navigator.of(context).pushNamed(
                            //   AppRoutes.paymentSuccess,
                            //   arguments: {
                            //     'message': state.data['message'],
                            //   },
                            // );
                          } else {
                            // Navigator.of(context).pushNamed(
                            //   AppRoutes.paymentWebViewScreen,
                            //   arguments: {'url': state.data['payment_url']},
                            // );
                          }
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          loading: state is AddOrderLoadingState,
                          width: context.width * .7,
                          onPressed: () {
                            final Map<String, dynamic> submitData = {...orderData, "use_wallet": isUseWallet.value ? "1" : "0"};
                            if (isUseWallet.value && previewOrder.remain == '0.00') {
                              AddOrderCubit.get(context).addOrder(submitData);
                            } else {
                              if (selectedPaymentMethod.value.id != -1) {
                                if (selectedPaymentMethod.value.type == 'wallet') {
                                  submitData['use_wallet'] = '1';
                                  submitData['payment_method_id'] = selectedPaymentMethod.value.id;
                                  AddOrderCubit.get(context).addOrder(submitData);
                                  return;
                                }
                                if (selectedPaymentMethod.value.type == 'bank_transfer') {
                                  if (formKey.currentState!.validate()) {
                                    if (selectedBankAccount.value.id != -1) {
                                      if (imageUri.value == '') {
                                        AppToast.showToastError('${context.tr.choose_file} ${context.tr.required}');
                                        return;
                                      }
                                      submitData['depositor_name'] = depositorNameController.text;
                                      submitData['deposit_amount'] = depositAmountController.text;
                                      submitData['bank_account_id'] = selectedBankAccount.value.id;
                                      submitData['deposit_receipt'] = imageUri.value;

                                      AddOrderCubit.get(context).addOrder({
                                        ...submitData,
                                        'payment_method_id': selectedPaymentMethod.value.id,
                                      });
                                    } else {
                                      AppToast.showToastError('${context.tr.bank_account} ${context.tr.required}');
                                    }
                                  }
                                } else {
                                  AddOrderCubit.get(context).addOrder({
                                    ...submitData,
                                    'payment_method_id': selectedPaymentMethod.value.id,
                                  });
                                }
                              } else {
                                AppToast.showToastError('${context.tr.payment_method} ${context.tr.required1}');
                              }
                            }
                          },
                          title: context.tr.payment,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
