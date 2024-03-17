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

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppPagesCubit()..getAboutUs(),
      child: Scaffold(
        appBar: appAppBar(context, context.tr.about_us),
        body: NetworkSensitive(
          child: BlocBuilder<AppPagesCubit, AppPagesState>(
            builder: (context, state) {
              if (state is AboutUsLoadingState) {
                return const AppLoading(
                  color: AppColors.primaryL,
                );
              }
              if (state is AboutUsSuccessState) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(Constants.padding20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LogoWidget(),
                        Text(state.aboutUs.title),
                        Html(
                          data: state.aboutUs.body,
                        ),
                      ],
                    ));
              }
              if (state is AboutUsErrorState) {
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
