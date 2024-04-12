import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/widget_position.dart';
import '../../bloc/main/drag_route_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../bloc/pip/segment_toggle/segment_toggle_cubit.dart';
import '../../widgets/pip/cover_image_widget.dart';

class PipPage extends StatelessWidget {
  final double width;
  final double height;

  const PipPage({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DragRouteCubit, DragState>(builder: (context, state) {
      //반응형의 근거가 될 상수 선언
      const double imageFirstLeftRatio = 0.025;
      const double imageSecondLeftRatio = 0.1;
      const double imageSecondTop = pipHeaderHeight;

      double imageFirstLeft = width * imageFirstLeftRatio;
      double imageFirstTop = imageFirstLeft;
      double imageFirstVerticalPadingInPip = imageFirstTop * 2;
      double imageFirstWidth = pipHeight - imageFirstVerticalPadingInPip;
      double imageFirstHeight = pipHeight - imageFirstVerticalPadingInPip;

      double imageSecondLeft = width * imageSecondLeftRatio;
      double imageSecondWidth = width - imageSecondLeft * 2;
      double imageSecondHeight = imageSecondWidth;
      double imageThirdLeft = imageFirstLeft;
      double imageThirdTop = imageThirdLeft;
      double imageThirdVerticalPadingInPip = imageThirdLeft * 2;
      double imageThirdWidth = pipHeight - imageThirdVerticalPadingInPip;
      double imageThirdHeight = pipHeight - imageThirdVerticalPadingInPip;

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

      List<WidgetPosition> textPostions = [
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

      return Stack(
        children: [
          _pipFirstWidget(
              opacity: state.secondScale > 0
                  ? state.secondScale
                  : 1 - state.firstScale,
              stackWidth: width,
              firstScale: state.firstScale,
              secondScale: state.secondScale,
              firstLeft: imageFirstLeft * 2 + imageFirstWidth,
              width: width - imageFirstLeft * 3 - imageFirstWidth),
          _pipHeaderWidget(
              context: context,
              positions: imagePositions,
              firstScale: state.firstScale,
              secondScale: state.secondScale),
          _textContainer(
              context: context,
              firstScale: state.firstScale,
              secondScale: state.secondScale),
          CoverImageWidget(positions: imagePositions),
          // PipDiaryText(positions: textPostions)
        ],
      );
    });
  }

  Widget _pipFirstWidget({
    required double stackWidth,
    required double opacity,
    required double firstScale,
    required double secondScale,
    required double firstLeft,
    required double width,
  }) {
    return Positioned(
      top: 0 + pipHeaderHeight * firstScale - pipHeaderHeight * secondScale,
      left: firstLeft + (stackWidth) * firstScale - stackWidth * secondScale,
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          height: pipHeight,
          width: width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text('일기 내용입니닫아아아아아아아아아아아아아아아아아아아아아아아아아아아',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis))
            ],
          ),
        ),
      ),
    );
  }

  Widget _pipHeaderWidget(
      {required BuildContext context,
      required List<WidgetPosition> positions,
      required double firstScale,
      required double secondScale}) {
    return Visibility(
      visible: (secondScale > 0 ? 1 - secondScale : firstScale) > 0,
      maintainState: true,
      child: Opacity(
          opacity: secondScale > 0 ? 1 - secondScale : firstScale,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: pipHeaderHeight,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<DragRouteCubit>().handlePipDownAction();
                      },
                      icon: const Icon(Icons.keyboard_arrow_down)),
                  BlocBuilder<SegmentToggleCubit, Set<SegmentToggle>>(
                      builder: (context, state) {
                    return SizedBox(
                      child: SegmentedButton<SegmentToggle>(
                        style: ButtonStyle(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.yellow),
                            alignment: Alignment.center),
                        segments: const [
                          ButtonSegment<SegmentToggle>(
                            value: SegmentToggle.image,
                            label: Text('사진'),
                          ),
                          ButtonSegment<SegmentToggle>(
                            value: SegmentToggle.text,
                            label: Text('일기'),
                          ),
                        ],
                        showSelectedIcon: true,
                        selected: context.read<SegmentToggleCubit>().state,
                        selectedIcon: null,
                        onSelectionChanged: (p0) {
                          context.read<SegmentToggleCubit>().update(p0);
                        },
                      ),
                    );
                  }),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert)),
                ],
              ))),
    );
  }

  Widget _textContainer(
      {required BuildContext context,
      required double firstScale,
      required double secondScale}) {
    return Positioned(
        top: pipHeaderHeight,
        child: BlocBuilder<SegmentToggleCubit, Set<SegmentToggle>>(
            builder: (context, state) {
          return Visibility(
            visible: state.first == SegmentToggle.text &&
                (secondScale > 0 ? 1 - secondScale : firstScale) > 0,
            maintainState: true,
            child: Opacity(
              opacity: secondScale > 0 ? 1 - secondScale : firstScale,
              child: Container(
                color: Colors.blue,
                width: width,
                height: height - pipHeaderHeight,
              ),
            ),
          );
        }));
  }
}
