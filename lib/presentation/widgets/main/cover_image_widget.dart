import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/widget_position.dart';
import '../../bloc/main/drag_route_cubit.dart';

class CoverImageWidget extends StatelessWidget {
  final List<WidgetPosition> positions;

  const CoverImageWidget({required this.positions, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DragRouteCubit, DragState>(
      builder: (context, state) {
        int index = state.getDragingIndex();
        return Positioned(
          top: positions[index].top,
          left: positions[index].left,
          child: SizedBox(
            width: positions[index].width,
            height: positions[index].height,
            child: Image.asset(
              'assets/images/user_profile_sample.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
