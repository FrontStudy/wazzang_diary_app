import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondNavigationBarCubit extends Cubit<int> {
  late TabController? controller;
  SecondNavigationBarCubit() : super(0);

  void initController(TabController controller) {
    this.controller = controller;
  }

  void changeIndex(int index) {
    if (controller != null) {
      controller!.animateTo(index);
      emit(index);
    }
  }
}
