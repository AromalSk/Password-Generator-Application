import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_generator/data/functions.dart';
import 'package:password_generator/features/password_store/models/password_model.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial()) {
    on<AddPasswordEvent>(addPasswordEvent);
    on<PasswordInitialEvent>(passwordInitialEvent);
    on<DeletePasswordEvent>(deletePasswordEvent);
  }

  FutureOr<void> addPasswordEvent(
      AddPasswordEvent event, Emitter<PasswordState> emit) async {
    addPassword(event.passwordModel);
    final data = await getAllData();
    emit(PasswordSuccessState(listOfPassword: data));
  }

  FutureOr<void> deletePasswordEvent(
      DeletePasswordEvent event, Emitter<PasswordState> emit) async {
    deletePassword(event.id);
    final data = await getAllData();
    emit(PasswordSuccessState(listOfPassword: data));
  }

  FutureOr<void> passwordInitialEvent(
      PasswordInitialEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoadingState());
    await Future.delayed(Duration(seconds: 1));
    final data = await getAllData();
    emit(PasswordSuccessState(listOfPassword: data));
  }
}
