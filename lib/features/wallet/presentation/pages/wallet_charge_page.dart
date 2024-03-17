import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button_outline.dart';
import '../../../../widgets/app_image.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../app_pages/presentation/cubit/app_pages_cubit.dart';
import '../../../auth/presentation/cubit/profile/profile_cubit.dart';
import '../../../cart/data/models/bank_account.dart';
import '../../../cart/presentation/cubit/bank_cubit.dart';
import '../../../cart/presentation/widgets/bank_account.dart';
import '../../../chat/presentation/cubit/uploader_cubit/uploader_cubit.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/bank_transfer_cubit.dart';
import '../widgets/commission.dart';

class WalletChargePage extends HookWidget {
  const WalletChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedBankAccount = useState(
      BankAccountModel(
          id: -1, isActive: false, image: 'image', accountNumber: 'accountNumber', ibanNumber: 'ibanNumber', name: 'name', createdAt: 'createdAt'),
    );
    final depositorNameController = useTextEditingController();
    final depositAmountController = useTextEditingController();
    final isUseWallet = useState(false);
    final isPdf = useState(false);
    final image = useState(null);
    final imageUri = useState('');

    useEffect(() {
      ProfileCubit.get(context).getProfile();
      return null;
    }, []);

    return Scaffold(
      appBar: appAppBar(context, context.tr.wallet),
      body: NetworkSensitive(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizedBox.sizedH10,
                      CommissionWidget(
                        title: context.tr.wallet,
                        icon: AppImages.warning,
                        price: UserCubit.get(context).userData!.user.wallet,
                        routeName: AppRoutes.walletScreen,
                      ),
                      AppSizedBox.sizedH5,
                      Text(
                        context.tr.not_added,
                        style: AppTextStyle.textStyleMediumGray,
                      ),
                      BlocProvider(
                        create: (context) => AppPagesCubit()..getAppSettings(),
                        child: BlocBuilder<AppPagesCubit, AppPagesState>(
                          builder: (context, state) {
                            return Text(
                              state is AppSettingsSuccessState
                                  ? "${context.tr.disable_account} ${state.appSettings[2]['body']} ${CurrencyHelper.currencyString(context)}"
                                  : '',
                              style: AppTextStyle.textStyleRegularBlack,
                            );
                          },
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     CommissionWidget(
                      //       title: context.tr.wallet,
                      //       icon: AppImages.income,
                      //       price: UserCubit.get(context).userData!.user.wallet,
                      //       routeName: AppRoutes.walletScreen,
                      //     ),
                      //     AppSizedBox.sizedW15,
                      //     CommissionWidget(
                      //       title: context.tr.delivery_fee,
                      //       icon: AppImages.deliveryFee,
                      //       price: '5000',
                      //       routeName: AppRoutes.deliveryFeeTransactionScreen,
                      //     ),
                      //   ],
                      // ),
                      AppSizedBox.sizedH10,

                      Text(
                        context.tr.bank_accounts,
                        style: AppTextStyle.textStyleMediumGray,
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
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0, left: 10.0),
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
                                  return InkWell(
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
                                    child: DottedBorder(
                                      color: AppColors.textAppGray.withOpacity(.4),
                                      strokeWidth: 1,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 5],
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        width: double.infinity,
                                        color: AppColors.textAppWhiteDark,
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
                                                      placeholder: (progress) => Center(
                                                        child: Text('$progress %'),
                                                      ),
                                                      errorWidget: (error) => Center(
                                                        child: Text(
                                                          error.toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : AppImage(
                                                    imageURL: imageUri.value,
                                                    width: double.infinity,
                                                    height: 150,
                                                    fit: BoxFit.contain,
                                                  )
                                            : state is UploadLoadingState
                                                ? const AppLoading(
                                                    scale: .5,
                                                  )
                                                : Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(AppImages.svgUpload),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(context.tr.bank_transfer_image)
                                                    ],
                                                  ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: AppColors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: AppColors.grey.withOpacity(0.5),
                      //         spreadRadius: 1,
                      //         blurRadius: 4,
                      //         offset: const Offset(0, 1),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         context.tr.app_bank_account,
                      //         style: AppTextStyle.textStyleMediumGray,
                      //       ),
                      //       AppSizedBox.sizedH10,
                      //       Text(
                      //         context.tr.bank_name,
                      //         style: AppTextStyle.textStyleRegularAppBlack18,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: const [
                      //           Text(
                      //             'Ac1234  5678 9123 - 456 - 4561',
                      //             style: AppTextStyle.textStyleMediumBlack,
                      //           ),
                      //           Icon(
                      //             Icons.copy,
                      //             color: AppColors.primaryL,
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // AppSizedBox.sizedH20,
                      // DottedBox(
                      //   name: context.tr.bank_transfer_image,
                      //   height: context.height * .3,
                      //   onTap: () {},
                      // ),

                      // AppSizedBox.sizedH20,

                      // AppButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed(
                      //       AppRoutes.paymentScreen,
                      //     );
                      //   },
                      //   title: context.tr.payment,
                      // ),
                      AppSizedBox.sizedH10,
                    ],
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => BankTransferCubit(),
                child: BlocConsumer<BankTransferCubit, BankTransferState>(
                  listener: (context, state) {
                    if (state is MakeTransactionsErrorState) {
                      AppToast.showToastError(state.error);
                    }
                    if (state is MakeTransactionsSuccessState) {
                      AppToast.showToastSuccess(context.tr.sent_successfully);
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return AppButtonOutline(
                      loading: state is MakeTransactionsLoadingState,
                      title: context.tr.send_bank_transfer,
                      onPressed: () {
                        if (selectedBankAccount.value.id != -1) {
                          if (formKey.currentState!.validate()) {
                            if (imageUri.value == '') {
                              AppToast.showToastError('${context.tr.bank_transfer_image} ${context.tr.required1}');
                              return;
                            }
                            // if (double.parse(UserCubit.get(context)
                            //         .userData!
                            //         .user
                            //         .wallet) <
                            //     double.parse(depositAmountController.text)) {
                            //   AppToast.showToastError(context.tr.full_amount);
                            //   return;
                            // }

                            BankTransferCubit.get(context).makeBankTransfer({
                              'depositor_name': depositorNameController.text,
                              'deposit_receipt': imageUri.value,
                              'deposit_amount': depositAmountController.text,
                              'bank_id': selectedBankAccount.value.id
                            });
                          }
                        } else {
                          AppToast.showToastError('${context.tr.bank_account} ${context.tr.required}');
                        }
                      },
                    );
                  },
                ),
              ),
              AppSizedBox.sizedH5,
              Text(
                context.tr.activate_account,
                style: AppTextStyle.textStyleRegularBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
