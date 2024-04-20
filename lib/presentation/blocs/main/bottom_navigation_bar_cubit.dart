import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarCubit extends Cubit<int> {
  final PageController controller =
      PageController(initialPage: 0, keepPage: true);
  BottomNavigationBarCubit() : super(0);

  void changeIndex(int index) {
    controller.jumpToPage(index);
    emit(index);
  }
}
