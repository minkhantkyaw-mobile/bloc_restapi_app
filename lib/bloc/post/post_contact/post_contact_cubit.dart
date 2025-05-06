import 'package:bloc_restapi_app/data/contact_repository.dart';
import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_restapi_app/bloc/post/post_contact/post_contact_state.dart';

class PostContactCubit extends Cubit<PostContactState> {
  final ContactRepository _contactRepository;
  PostContactCubit(this._contactRepository)
    : super(PostContactState(isLoading: true));
  void addContact(Contact contact) {
    emit(PostContactLoading());
    _contactRepository
        .addContact(contact)
        .then((value) => emit(PostContactSuccess()))
        .catchError((e) => emit(PostContactFail('error')));
  }
}
