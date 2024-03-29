import 'package:flutter_bloc/flutter_bloc.dart';

class DragState {
  final double scale;
  final double lastDragDelta;

  DragState(this.scale, this.lastDragDelta);

  DragState copyWith({double? scale, double? lastDragDelta}) {
    return DragState(
      scale ?? this.scale,
      lastDragDelta ?? this.lastDragDelta,
    );
  }
}

class DragRouteCubit extends Cubit<DragState> {
  DragRouteCubit() : super(DragState(0, 0));

  void handleDragUpdate(double delta) {
    double scale = state.scale - delta / 1000;
    scale = scale.clamp(0.0, 1.0);
    emit(state.copyWith(scale: scale, lastDragDelta: delta));
  }

  void handleDragEnd() {
    double lastDelta = state.lastDragDelta;
    double? scale;
    if (lastDelta < -15) {
      scale = 1;
    } else if (lastDelta > 15) {
      scale = 0;
    } else {
      scale = state.scale > 0.5 ? 1 : 0;
    }
    emit(state.copyWith(scale: scale));
  }
}
