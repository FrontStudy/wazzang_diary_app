import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/widget_position.dart';
import '../../bloc/main/drag_route_cubit.dart';
import '../../../core/constants/constants.dart';
import 'cover_image_widget.dart';

class PipPage extends StatelessWidget {
  final double width;
  final double height;

  const PipPage({required this.width, required this.height, super.key});

  List<WidgetPosition> _getCoverImagePositions(double imageFirstLeftRatio,
      double imageSecondLeftRatio, double imageThirdTop, DragState state) {
    double imageFirstLeft = width * imageFirstLeftRatio;
    double imageFirstTop = imageFirstLeft;
    double imageFirstVerticalPadingInPip = imageFirstTop * 2;
    double imageFirstWidth = pipHeight - imageFirstVerticalPadingInPip;
    double imageFirstHeight = pipHeight - imageFirstVerticalPadingInPip;

    double imageSecondTop = pipHeaderHeight;
    double imageSecondLeft = width * imageSecondLeftRatio;
    double imageSecondWidth = width - imageSecondLeft * 2;
    double imageSecondHeight = imageSecondWidth;
    double imageThirdLeft = imageFirstLeft;
    double imageThirdVerticalPadingInPip = imageThirdLeft * 2;
    double imageThirdWidth = pipHeight - imageThirdVerticalPadingInPip;
    double imageThirdHeight = pipHeaderHeight - imageThirdVerticalPadingInPip;

    List<WidgetPosition> imagePositions = [
      WidgetPosition(
          top: imageFirstTop +
              (imageSecondTop - imageFirstTop) * state.firstScale,
          left: imageFirstLeft +
              (imageSecondLeft - imageFirstLeft) * state.firstScale,
          width: imageFirstWidth +
              (imageSecondWidth - imageFirstWidth) * state.firstScale,
          height: imageFirstHeight +
              (imageSecondHeight - imageFirstHeight) * state.firstScale),
      WidgetPosition(
          top: imageSecondTop +
              (imageThirdTop - imageSecondTop) * state.secondScale,
          left: imageSecondLeft +
              (imageThirdLeft - imageSecondLeft) * state.secondScale,
          width: imageSecondWidth +
              (imageThirdWidth - imageSecondWidth) * state.secondScale,
          height: imageSecondHeight +
              (imageThirdHeight - imageSecondHeight) * state.secondScale),
    ];
    return imagePositions;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DragRouteCubit, DragState>(builder: (context, state) {
      //반응형의 근거가 될 변수 선언
      const double imageFirstLeftRatio = 0.025;
      const double imageSecondLeftRatio = 0.1;
      const double imageThirdTop = 0;

      List<WidgetPosition> positions = _getCoverImagePositions(
          imageFirstLeftRatio, imageSecondLeftRatio, imageThirdTop, state);

      return Stack(
        children: [
          _pipHeaderWidget(
            opacity: state.secondScale > 0
                ? 1 - state.secondScale
                : state.firstScale,
            stackWidth: width,
          ),
          CoverImageWidget(positions: positions)
        ],
      );
    });
  }

  Widget _pipHeaderWidget(
      {required double stackWidth, required double opacity}) {
    return Positioned(
      top: 0,
      left: 0,
      child: Opacity(
        opacity: opacity,
        child: Container(
          color: Colors.red,
          height: pipHeaderHeight,
          width: stackWidth,
        ),
      ),
    );
  }
}
