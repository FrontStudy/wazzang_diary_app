import 'package:flutter_bloc/flutter_bloc.dart';

class DragState {
  final double firstScale;
  final double secondScale;
  final double lastDragDelta;
  final int pageIndex;
  final bool shouldAnimate;
  final double? animateTargetScale;
  final bool? isfirstScaleAnimated;
  final bool isAnimating;

  const DragState(
      this.firstScale,
      this.secondScale,
      this.lastDragDelta,
      this.pageIndex,
      this.shouldAnimate,
      this.animateTargetScale,
      this.isfirstScaleAnimated,
      this.isAnimating);

  DragState copyWith(
      {double? firstScale,
      double? secondScale,
      double? lastDragDelta,
      int? pageIndex,
      bool? shouldAnimate,
      double? animateTargetScale,
      bool? isfirstScaleAnimated,
      bool? isAnimating}) {
    return DragState(
        firstScale ?? this.firstScale,
        secondScale ?? this.secondScale,
        lastDragDelta ?? this.lastDragDelta,
        pageIndex ?? this.pageIndex,
        shouldAnimate ?? this.shouldAnimate,
        animateTargetScale ?? this.animateTargetScale,
        isfirstScaleAnimated ?? this.isfirstScaleAnimated,
        isAnimating ?? this.isAnimating);
  }

  int getDragingIndex() {
    if (firstScale >= 0 && secondScale == 0) {
      return 0;
    } else if (firstScale == 1 && secondScale >= 0) {
      return 1;
    } else {
      print('firstScale : $firstScale, secondScale : $secondScale');
      return -1;
    }
  }
}

class DragRouteCubit extends Cubit<DragState> {
  DragRouteCubit()
      : super(const DragState(0, 0, 0, 0, false, null, null, false));

  void handlePipTap() {
    if (state.shouldAnimate) return;
    _startFirstScaleAnimation(1);
  }

  void handlePipDownAction() {
    if (state.shouldAnimate) return;
    if (state.pageIndex == 1) {
      _startFirstScaleAnimation(0);
    }
  }

  void handlePipDragUpdate(double delta) {
    if (state.shouldAnimate) return;
    double firstScale = state.firstScale - delta / 1000;
    firstScale = firstScale.clamp(0.0, 1.0);
    emit(state.copyWith(firstScale: firstScale, lastDragDelta: delta));
  }

  void handlePipDragEnd() {
    if (state.shouldAnimate) return;
    if (state.firstScale == 0 && state.pageIndex == 0) {
      return;
    }
    if (state.firstScale == 0 && state.pageIndex == 1) {
      _setPageIndex(0);
      return;
    }

    if (state.firstScale == 1 && state.pageIndex == 1) {
      return;
    }

    if (state.firstScale == 1 && state.pageIndex == 0) {
      _setPageIndex(1);
      return;
    }

    double lastDelta = state.lastDragDelta;

    // drag fast
    if (lastDelta.abs() > 15) {
      _startFirstScaleAnimation(lastDelta < 0 ? 1 : 0);
      return;
    }
    // drag slowly
    else {
      _startFirstScaleAnimation(state.firstScale > 0.5 ? 1 : 0);
    }
  }

  void handleSecondTabDragUpdate(double delta) {
    if (state.shouldAnimate) return;
    double secondScale = state.secondScale - delta / 1000;
    secondScale = secondScale.clamp(0.0, 1.0);
    emit(state.copyWith(secondScale: secondScale, lastDragDelta: delta));
  }

  void handleSecondTabDragEnd() {
    if (state.shouldAnimate) return;
    if (state.secondScale == 0 && state.pageIndex == 1) {
      return;
    }
    if (state.secondScale == 0 && state.pageIndex == 2) {
      _setPageIndex(1);
      return;
    }
    if (state.secondScale == 1 && state.pageIndex == 1) {
      return;
    }

    if (state.secondScale == 1 && state.pageIndex == 2) {
      _setPageIndex(2);
      return;
    }

    double lastDelta = state.lastDragDelta;

    // drag fast
    if (lastDelta.abs() > 15) {
      startSecondScaleAnimation(lastDelta < 0 ? 2 : 1);
      return;
    }
    // drag slowly
    else {
      startSecondScaleAnimation(state.secondScale > 0.5 ? 2 : 1);
    }
  }

  void updateFirstScale(double value) {
    value = value.clamp(0.0, 1.0);
    emit(state.copyWith(firstScale: value));
  }

  void updateSecondScale(double value) {
    value = value.clamp(0.0, 1.0);
    emit(state.copyWith(secondScale: value));
  }

  void _setPageIndex(int index) {
    print("setPage $index");
    emit(state.copyWith(pageIndex: index));
  }

  void _startFirstScaleAnimation(int targetPageIndex) {
    if (targetPageIndex == 0) {
      emit(state.copyWith(
          pageIndex: targetPageIndex,
          shouldAnimate: true,
          animateTargetScale: 0,
          isfirstScaleAnimated: true));
    } else if (targetPageIndex == 1) {
      emit(state.copyWith(
          pageIndex: targetPageIndex,
          shouldAnimate: true,
          animateTargetScale: 1,
          isfirstScaleAnimated: true));
    }
  }

  void startSecondScaleAnimation(int targetPageIndex) {
    if (targetPageIndex == 1) {
      emit(state.copyWith(
          pageIndex: targetPageIndex,
          shouldAnimate: true,
          animateTargetScale: 0,
          isfirstScaleAnimated: false));
    } else if (targetPageIndex == 2) {
      emit(state.copyWith(
          pageIndex: targetPageIndex,
          shouldAnimate: true,
          animateTargetScale: 1,
          isfirstScaleAnimated: false));
    }
  }

  void resetAnimationFlag() {
    emit(state.copyWith(
        shouldAnimate: false,
        animateTargetScale: null,
        isfirstScaleAnimated: null));
  }

  void setIsAnimating(bool isAnimating) {
    emit(state.copyWith(isAnimating: isAnimating));
  }
}
