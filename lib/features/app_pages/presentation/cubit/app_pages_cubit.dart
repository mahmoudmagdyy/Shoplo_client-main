import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/network_constants.dart';
import '../../data/data_sources/app_pages_data_provider.dart';
import '../../data/models/app_pages.dart';
import '../../data/models/faq.dart';
import '../../data/repositories/app_pages_repository.dart';

part 'app_pages_state.dart';

class AppPagesCubit extends Cubit<AppPagesState> {
  AppPagesCubit() : super(AppPagesInitial());

  static AppPagesCubit get(context) => BlocProvider.of(context);
  static final dataProvider = AppPagesDataProvider();
  static final AppPagesRepository repository = AppPagesRepository(dataProvider);

  /// terms and conditions
  void getTermsAndConditions() {
    emit(TermsAndConditionsLoadingState());
    repository.getPageData(NetworkConstants.terms).then(
      (value) {
        value.fold((l) {
          if (l.errors != null) {
            emit(AboutUsErrorState(l.errors!));
          } else {
            emit(TermsAndConditionsErrorState(l.errorMessages!));
          }
        }, (r) {
          emit(TermsAndConditionsSuccessState(r.data));
        });
      },
    );
  }

  /// about us
  void getAboutUs() {
    emit(AboutUsLoadingState());
    repository.getPageData(NetworkConstants.aboutUs).then(
      (value) {
        value.fold((l) {
          if (l.errorMessages != null) {
            emit(AboutUsErrorState(l.errorMessages!));
          } else if (l.errors != null) {
            emit(AboutUsErrorState(l.errors!));
          }
        }, (r) {
          emit(AboutUsSuccessState(r.data));
        });
      },
    );
  }

  /// app privacy
  void getPrivacy() {
    emit(PrivacyLoadingState());
    repository.getPageData(NetworkConstants.privacy).then(
      (value) {
        value.fold((l) {
          if (l.errorMessages != null) {
            emit(PrivacyErrorState(l.errorMessages!));
          } else if (l.errors != null) {
            emit(PrivacyErrorState(l.errors!));
          }
        }, (r) {
          emit(PrivacySuccessState(r.data));
        });
      },
    );
  }

  /// App settings
  void getAppSettings() {
    emit(AppSettingsLoadingState());
    repository.getAppSettings().then(
      (value) {
        debugPrint('VALUExxxxxxxxxx ccc vvv bvv : ${value.data.length}', wrapWidth: 1024);
        if (value.errorMessages != null) {
          emit(AppSettingsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AppSettingsErrorState(value.errors!));
        } else {
          List<Map<String, dynamic>> list = [];
          value.data.forEach((item) => list.add(item));
          emit(AppSettingsSuccessState(list));
        }
      },
    );
  }

  // /// use app
  // void getUseApp() {
  //   emit(UseAppLoadingState());
  //   repository.getPageData(NetworkConstants.login).then(
  //     (value) {
  //       if (value.errorMessages != null) {
  //         emit(UseAppErrorState(value.errorMessages!));
  //       } else if (value.errors != null) {
  //         emit(UseAppErrorState(value.errors!));
  //       } else {
  //         emit(UseAppSuccessState(value.data));
  //       }
  //     },
  //   );
  // }

  final List<FaqModel> faqs = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  /// FAQ
  void getFaq(Map<String, dynamic> queryData) async {
    debugPrint('QUERYDATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (!endLoadingFirstTime) {
      faqs.clear();
    }
    debugPrint('QUERY: $query', wrapWidth: 1024);

    if (query['page'] == 1) {
      emit(FAQLoadingState());
    } else {
      loadingMoreResults = true;
      emit(FAQLoadingNextPageState());
    }
    await Future.delayed(const Duration(seconds: 2));
    faqs.add(const FaqModel(answer: 'اجابه هذا السوال افتح التطبيق ثم افتح الاعدادات ', question: 'السوال الاول'));
    faqs.add(const FaqModel(answer: 'اجابه هذا السوال افتح التطبيق ثم افتح الاعدادات ', question: 'السوال الثاني'));
    emit(FAQSuccessState(faqs));

    // repository.getFaq(query).then(
    //   (value) {
    //     loadingMoreResults = false;
    //     if (value.errorMessages != null) {
    //       emit(FAQErrorState(value.errorMessages!));
    //     } else {
    //       endLoadingFirstTime = true;
    //       List<FaqModel> faqs = [];
    //       value.data.forEach((item) {
    //         // _faqs.add(FaqModel.fromJson(item));
    //       });

    //       debugPrint('_faqs ${faqs.length}');
    //       if (query['page'] != 1) {
    //         debugPrint('----- lode more ');
    //         faqs.addAll(faqs);
    //       } else {
    //         faqs.clear();
    //         faqs.addAll(faqs);
    //       }
    //       if (faqs.length == value.meta['total']) {
    //         debugPrint('============== done request');
    //         hasReachedEndOfResults = true;
    //       } else if (faqs.length < value.meta['total']) {
    //         hasReachedEndOfResults = false;
    //       }
    //       debugPrint('FAQ ${faqs.length}');
    //       if (query['page'] < value.meta['last_page']) {
    //         debugPrint('load more 2222 page ++ ');
    //         query['page'] += 1;
    //       } else {
    //         query['page'] = 1;
    //       }

    //       emit(FAQSuccessState(faqs));
    //     }
    //   },
    // );
  }
}
