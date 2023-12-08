// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_bloc.dart';

class PasswordState {}

 class PasswordInitial extends PasswordState {}

class PasswordLoadingState extends PasswordState {}

class PasswordSuccessState extends PasswordState {
  List<PasswordModel> listOfPassword;
  PasswordSuccessState({
    required this.listOfPassword,
  });
}

class PasswordErrorState extends PasswordState {}
