import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_error.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/app_pages_cubit.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppPagesCubit()..getTermsAndConditions(),
      child: Scaffold(
        appBar: appAppBar(context, context.tr.terms_and_conditions),
        body: NetworkSensitive(
          child: BlocBuilder<AppPagesCubit, AppPagesState>(
            builder: (context, state) {
              if (state is TermsAndConditionsLoadingState) {
                return const AppLoading(
                  color: AppColors.primaryL,
                );
              }
              if (state is TermsAndConditionsSuccessState) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(Constants.padding20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.height * .05,
                        ),
                        Text(state.terms.title),
                        Html(
                          /* data: state.terms.description,*/
                          data:state.terms.body
                        ),
                      ],
                    ));
              }
              if (state is TermsAndConditionsErrorState) {
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
