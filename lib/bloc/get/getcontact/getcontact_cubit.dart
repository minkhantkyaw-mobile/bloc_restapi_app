import 'package:bloc_restapi_app/data/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_state.dart';

class GetcontactCubit extends Cubit<GetcontactState> {
  final ContactRepository _contactRepository;

  GetcontactCubit(this._contactRepository)
    : super(GetcontactState(isLoading: true));

  void getContact() {
    emit(GetContactInitial());
    _contactRepository
        .getContact()
        .then((value) => emit(GetContactSuccess(value)))
        .catchError((e) => emit(GetContactFail('error')));
  }
}
