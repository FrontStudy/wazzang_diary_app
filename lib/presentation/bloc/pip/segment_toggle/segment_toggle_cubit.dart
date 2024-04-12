import 'package:flutter_bloc/flutter_bloc.dart';

enum SegmentToggle { text, image }

class SegmentToggleCubit extends Cubit<Set<SegmentToggle>> {
  SegmentToggleCubit() : super(<SegmentToggle>{SegmentToggle.image});

  void update(Set<SegmentToggle> segmentToggle) {
    emit(segmentToggle);
  }
}
