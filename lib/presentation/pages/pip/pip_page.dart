import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/theme.dart';
import '../../../core/utils/widget_position.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../blocs/diary/current_diary_bloc.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../blocs/pip/segment_toggle/segment_toggle_cubit.dart';
import '../../widgets/pip/cover_image_widget.dart';
import '../../widgets/pip/description_widget.dart';

class PipPage extends StatelessWidget {
  final double width;
  final double height;

  const PipPage({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final dragState = BlocProvider.of<DragRouteCubit>(context).state;
      final currentDiaryState =
          BlocProvider.of<CurrentDiaryBloc>(context).state;

      DiaryDetails? data;
      if (currentDiaryState is CurrentDiaryLoaded) {
        data = currentDiaryState.diaryDetails;
      }

      //반응형의 근거가 될 상수 선언
      const double imageFirstLeftRatio = 0.025;
      const double imageSecondLeftRatio = 0.06;
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
                (imageSecondTop - imageFirstTop) * dragState.firstScale,
            left: imageFirstLeft +
                (imageSecondLeft - imageFirstLeft) * dragState.firstScale,
            width: imageFirstWidth +
                (imageSecondWidth - imageFirstWidth) * dragState.firstScale,
            height: imageFirstHeight +
                (imageSecondHeight - imageFirstHeight) * dragState.firstScale),
        WidgetPosition(
            top: imageSecondTop +
                (imageThirdTop - imageSecondTop) * dragState.secondScale,
            left: imageSecondLeft +
                (imageThirdLeft - imageSecondLeft) * dragState.secondScale,
            width: imageSecondWidth +
                (imageThirdWidth - imageSecondWidth) * dragState.secondScale,
            height: imageSecondHeight +
                (imageThirdHeight - imageSecondHeight) * dragState.secondScale),
      ];

      return Stack(
        children: [
          _pipFirstWidget(
              opacity: dragState.secondScale > 0
                  ? dragState.secondScale
                  : 1 - dragState.firstScale,
              stackWidth: width,
              firstScale: dragState.firstScale,
              secondScale: dragState.secondScale,
              firstLeft: imageFirstLeft * 2 + imageFirstWidth,
              width: width - imageFirstLeft * 3 - imageFirstWidth,
              data: data),
          _pipHeaderWidget(
              context: context,
              positions: imagePositions,
              firstScale: dragState.firstScale,
              secondScale: dragState.secondScale,
              data: data),
          _textContainer(
              context: context,
              firstScale: dragState.firstScale,
              secondScale: dragState.secondScale,
              data: data),
          DescriptionWidget(
              top: imageSecondTop + imageSecondHeight,
              leftPadding: imageSecondLeft,
              height: height -
                  pipHeaderHeight -
                  imageSecondHeight -
                  secondBottomBarHeight),
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
    DiaryDetails? data,
  }) {
    return Positioned(
      top: 0 + pipHeaderHeight * firstScale - pipHeaderHeight * secondScale,
      left: firstLeft + (stackWidth) * firstScale - stackWidth * secondScale,
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          height: pipHeight,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.title ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(data?.content ?? '',
                  style: const TextStyle(
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
      required double secondScale,
      DiaryDetails? data}) {
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
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[50],
                      )),
                  BlocBuilder<SegmentToggleCubit, Set<SegmentToggle>>(
                      builder: (context, state) {
                    return SizedBox(
                      child: SegmentedButton<SegmentToggle>(
                        style: ButtonStyle(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            backgroundColor:
                                MaterialStateColor.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return ivoryColor;
                              } else {
                                return darkIvoryColor;
                              }
                            }),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black87),
                            alignment: Alignment.center),
                        segments: const [
                          ButtonSegment<SegmentToggle>(
                            value: SegmentToggle.image,
                            label: Text('  사진'),
                          ),
                          ButtonSegment<SegmentToggle>(
                            value: SegmentToggle.text,
                            label: Text('일기  '),
                          ),
                        ],
                        showSelectedIcon: false,
                        selected: context.read<SegmentToggleCubit>().state,
                        onSelectionChanged: (p0) {
                          context.read<SegmentToggleCubit>().update(p0);
                        },
                      ),
                    );
                  }),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey[50],
                      )),
                ],
              ))),
    );
  }

  Widget _textContainer(
      {required BuildContext context,
      required double firstScale,
      required double secondScale,
      DiaryDetails? data}) {
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
                color: Colors.grey[100],
                width: width,
                height: height - pipHeaderHeight,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:
                        const EdgeInsets.only(bottom: secondBottomBarHeight),
                    child: Text(
                      data?.content ?? "",
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
