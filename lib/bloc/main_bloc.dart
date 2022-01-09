import 'dart:async';

import 'package:ValidusCoin/http_interceptors/LoggingInterceptor.dart';
import 'package:ValidusCoin/models/StockResponse.dart';
import 'package:ValidusCoin/repositories/DataRepository.dart';
import 'package:ValidusCoin/ui/add_edit_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

part 'main_event.dart';

enum MainStates {
  Home,
  Profile,
  Error,
  LoggedLOADING,
}

class MainBloc extends Bloc<MainEvent, MainStates> {
  late DataRepository repository;
  late StockResponse data;

  init() async {
    repository = DataRepository();
    LoggingInterceptor();
    this.add(WelcomeIn());
  }

  MainBloc() : super(MainStates.LoggedLOADING) {
    on<WelcomeIn>((event, emit) async {
      emit(MainStates.LoggedLOADING);
      data = await repository.getData();
      if (data.success) {
        emit(MainStates.Home);
      } else {
        emit(MainStates.Error);
      }
    });
    on<ShowProfile>((event, emit) async {
      emit(MainStates.LoggedLOADING);
      emit(MainStates.Profile);
    });
    on<AddEditProfile>((event, emit) async {
      Navigator.push(
        event.context,
        PageTransition(
          child: AddEditField(event.key),
          type: PageTransitionType.bottomToTop,
        ),
      ).then((value) {
        event.onReturn();
      });
    });
  }
}
