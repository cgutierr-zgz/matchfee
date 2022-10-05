import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class CoffeeCard extends StatefulWidget {
  const CoffeeCard({super.key});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<void> onSlide() async => animationController
      .forward(from: 0)
      .then((value) => animationController.reset());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print(state);
        return GestureDetector(
          //onTap: onSlide,
          //onHorizontalDragEnd: (details) => onSlide(),
          onHorizontalDragStart: (details) async {
            //final string = await context.read<MatchRepository>().getCoffeeImage();
            //print(string);
            //final path =
            //    await context.read<MatchRepository>().saveImageToDevice(string);
            //
            //print(path);
            //final a =
            //    await context.read<MatchRepository>().getImageFromDevice(path);
            //
            //print(a);
          },
          onHorizontalDragUpdate: print,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is HomeLoading)
                  const SizedBox(
                    height: 500,
                    width: double.maxFinite,
                    child: Center(
                      // TODO(c): Loading widget
                      child: Text('Loading...'),
                    ),
                  ),
                if (state is HomeLoaded)
                  Image.network(
                    state.images.first,
                    height: 500,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        height: 500,
                        width: double.maxFinite,
                        'assets/images/error.png',
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        height: 500,
                        width: double.maxFinite,
                        child: Center(
                          // TODO(c): Loading widget
                          child: Text('Loading...'),
                        ),
                      );
                    },
                  ),
              ].joinWith(const SizedBox(height: 10)),
            ),
          )
              .animate(
                controller: animationController,
                adapter: ValueAdapter(),
              )
              .slide(
                begin: Offset.zero,
                end: const Offset(2, 0),
              )
              .rotate(
                begin: 0,
                end: 0.05,
                alignment: Alignment.center,
              ),
        );
      },
    );
  }
}
