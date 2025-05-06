import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:equatable/equatable.dart';

class GetcontactState extends Equatable {
  final bool isLoading;
  final String? error;

  const GetcontactState({this.isLoading = false, this.error});
  @override
  List<Object> get props => [];
  GetcontactState copyWith({bool? isLoading, String? error}) {
    return GetcontactState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class GetContactInitial extends GetcontactState {}

class GetContactSuccess extends GetcontactState {
  final List<Contact> contacts;

  GetContactSuccess(this.contacts);
  @override
  List<Object> get props => [contacts];
}

class GetContactFail extends GetcontactState {
  final String error;
  GetContactFail(this.error);
  @override
  List<Object> get props => [error];
}
