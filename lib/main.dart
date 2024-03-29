import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/drag_route_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (_) => DragRouteCubit(), child: const HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    double secondBottomBarHeight = 80;

    return Scaffold(
      body:
          BlocBuilder<DragRouteCubit, DragState>(builder: (context, dratState) {
        return Stack(children: [
          //가장 배경
          Container(
              color: Colors.white,
              height: screenSize.height,
              child: const Center(child: Text('HomePage'))),
          Positioned(
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: ((details) => context
                    .read<DragRouteCubit>()
                    .handleDragUpdate(details.primaryDelta!)),
                onVerticalDragEnd: ((details) =>
                    context.read<DragRouteCubit>().handleDragEnd()),
                child: Container(
                  color: Colors.amber,
                  height: 160 + (screenSize.height - 160) * dratState.scale,
                  width: screenSize.width,
                ),
              )),
          //상세 페이지의 바텀바
          Positioned(
              bottom: 0,
              child: Opacity(
                  opacity: dratState.scale,
                  child: Container(
                    color: Colors.green,
                    height: secondBottomBarHeight * dratState.scale,
                    width: screenSize.width,
                  ))),
          Positioned(
              bottom: 0,
              child: Opacity(
                  opacity: 1 - dratState.scale,
                  child:
                      CustomBottomNaviBar(height: 80 * (1 - dratState.scale))))
        ]);
      }),
    );
  }
}

class CustomBottomNaviBar extends StatefulWidget {
  const CustomBottomNaviBar({required this.height, super.key});
  final double height;

  @override
  State<CustomBottomNaviBar> createState() => _CustomBottomNaviBarState();
}

class _CustomBottomNaviBarState extends State<CustomBottomNaviBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/images/user_profile_sample.jpg'));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        margin: const EdgeInsets.only(top: 70),
        height: MediaQuery.of(context).size.height - 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 255, 78, 84)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
