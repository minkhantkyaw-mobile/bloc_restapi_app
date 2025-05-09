import 'package:bloc_restapi_app/data/contact_repository.dart';
import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_restapi_app/bloc/put/edit_contact/edit_contact_state.dart';
import 'package:dio/dio.dart';

class EditContactCubit extends Cubit<EditContactState> {
  final ContactRepository _contactRepository;
  EditContactCubit(this._contactRepository) : super(EditContactInitial());

  void edit(String id, Contact contact) {
    EditContactLoading();
    _contactRepository
        .updateContact(id, contact)
        .then((value) => emit(EditContactSuccess()))
        .catchError((e) => emit(EditContactFail(e)));
  }
}
