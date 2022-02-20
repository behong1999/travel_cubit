import 'package:bloc/bloc.dart';
import 'package:cubit_flutter/models/place.dart';
import 'package:cubit_flutter/pages/welcome_page.dart';
import 'package:cubit_flutter/services/data_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_cubit_state.dart';

class AppCubit extends Cubit<CubitStates> {
  final DataServices data;

  AppCubit({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  // ignore: prefer_typing_uninitialized_variables
  late List<Place> places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.fetchAll().first;
      emit(LoadedState(places: places)); //* props => [places]
    } catch (e) {
      throw Exception("Error occurs!");
    }
  }

  void getDetail(String name) async {
    try {
      final place = await data.fetchDetail(name);
      emit(DetailState(place));
    } catch (e) {
      throw Exception("Error occurs");
    }
  }

  void backHome() {
    //* Emit LoadedState and retrieve data because getData is called once
    emit(LoadedState(places: places));
  }
}
