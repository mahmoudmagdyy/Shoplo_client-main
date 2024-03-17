import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_error.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../auth/presentation/widgets/logo.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/app_pages_cubit.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppPagesCubit()..getFaq({}),
      child: Scaffold(
        appBar: appAppBar(context, context.tr.faq),
        body: NetworkSensitive(
          child: BlocBuilder<AppPagesCubit, AppPagesState>(
            builder: (context, state) {
              if (state is FAQLoadingState) {
                return const AppLoading(
                  color: AppColors.primaryL,
                );
              }
              if (state is FAQSuccessState) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(Constants.padding20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LogoWidget(),
                        Text(state.faq[0].question),
                        Html(
                          /* data: state.terms.description,*/
                          data:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisl pretium ut fusce nunc. Ultrices diam, mauris convallis varius commodo neque faucibus vitae mattis. Tristique ornare blandit mauris justo, enim suspendisse id eleifend gravida. Nisl posuere interdum est in vestibulum id sagittis.",
                        ),
                      ],
                    ));
              }
              if (state is FAQErrorState) {
                return AppError(
                  error: state.error,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
