import 'package:equatable/equatable.dart';

class PostContactState extends Equatable {
  final bool isLoading;
  final String? error;

  const PostContactState({this.isLoading = false, this.error});

  @override
  List<Object> get props => [];

  PostContactState copyWith({bool? isLoading, String? error}) {
    return PostContactState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PostContactInitial extends PostContactState {}

class PostContactSuccess extends PostContactState {}

class PostContactLoading extends PostContactState {}

class PostContactFail extends PostContactState {
  final String error;
  PostContactFail(this.error);

  @override
  List<Object> get props => [error];
}
