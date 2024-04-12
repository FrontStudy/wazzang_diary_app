import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/widget_position.dart';
import '../../bloc/main/drag_route_cubit.dart';
import '../../bloc/pip/segment_toggle/segment_toggle_cubit.dart';

class CoverImageWidget extends StatelessWidget {
  final List<WidgetPosition> positions;

  const CoverImageWidget({required this.positions, super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var dragState = context.select((DragRouteCubit cubit) => cubit.state);
        var toggleState =
            context.select((SegmentToggleCubit cubit) => cubit.state);
        int index = dragState.getDragingIndex();
        bool visible = toggleState.first == SegmentToggle.image ||
            (dragState.firstScale != 1 || dragState.secondScale != 0);
        double opacity = toggleState.first == SegmentToggle.image
            ? 1
            : dragState.secondScale > 0
                ? dragState.secondScale
                : 1 - dragState.firstScale;
        return Positioned(
          top: positions[index].top,
          left: positions[index].left,
          child: Visibility(
            visible: visible,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                width: positions[index].width,
                height: positions[index].height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/user_profile_sample.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
