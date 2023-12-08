// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_bloc.dart';

class PasswordEvent {}

class PasswordInitialEvent extends PasswordEvent{}

class AddPasswordEvent extends PasswordEvent {
  PasswordModel passwordModel;
  AddPasswordEvent({
    required this.passwordModel,
  });
}

class GetPasswordEvent extends PasswordEvent {}

class DeletePasswordEvent extends PasswordEvent {
  int id;
  DeletePasswordEvent({
    required this.id,
  });
}
