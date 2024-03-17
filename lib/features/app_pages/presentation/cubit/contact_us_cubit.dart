import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/contact_us_data_provider.dart';
import '../../data/models/complain_type.dart';
import '../../domain/entities/contact_us_types.dart';
import '../../domain/repositories/contact_us_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  ContactUsTypesEntity? complainType;

  void setSelectedComplainType(ContactUsTypesEntity type) {
    complainType = type;
  }

  static final dataProvider = ContactUsDataProvider();

  static final ContactUsRepository repository = ContactUsRepository(dataProvider);

  // List<ComplainTypeModel> contactTypes = [];
  // void getContactTypes() {
  //   emit(ContactTypesLoadingState());
  //   repository.getContactTypes().then(
  //     (value) {
  //       if (value.errorMessages != null) {
  //         emit(ContactTypesErrorState(value.errorMessages!));
  //       } else if (value.errors != null) {
  //         emit(ContactTypesErrorState(value.errors!));
  //       } else {
  //         contactTypes = [];
  //         debugPrint('VALUE xxxxx xxx: ${value.data}', wrapWidth: 1024);
  //         value.data.forEach((item) {
  //           contactTypes.add(ComplainTypeModel(
  //             id: item['id'],
  //             value: item['value'],
  //             name: item['name'],
  //             key: item["key"],
  //             type:item["type"],
  //           ));
  //         });
  //         emit(ContactTypesSuccessState(contactTypes));
  //       }
  //     },
  //   );
  // }

  /// about us
  List<ContactUsTypesEntity> contactUsTypeList=[];
  void getContactUsTypes() {
    emit(ContactUsTypesUsLoadingState());
    repository.getContactUsTypes().then(
          (value) {
        value.fold((l){
          if (l.errorMessages != null) {
            emit(ContactUsTypesErrorState(l.errorMessages!));
          } else if (l.errors != null) {
            emit(ContactUsTypesErrorState(l.errors!));
          }
        }, (r){
          contactUsTypeList = [];
          debugPrint(wrapWidth: 1024,"asdsadasd ${r.data}");
          r.data.forEach((item) {
            contactUsTypeList.add(ContactUsTypesEntity(
              id: item['id'],
              name: item['name'],
            ));
          });
          emit(ContactUsTypesSuccessState());
        });
      },
    );
  }
  void sendContactUs(values) {
    emit(ContactUsLoadingState());
    repository.sendContactUs(values).then(
      (value) {
        debugPrint("@@@value ${value}");
        if (value.errorMessages != null) {
          emit(ContactUsErrorState(value.errorMessages!));
        }
        else if (value.errors != null){
          emit(ContactUsErrorState(value.errors!));
        }
        else {
          emit(const ContactUsSuccessState());
        }
      },
    );
  }
}
