import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

enum CardActions {
  like,
  dislike,
  // superLike
}

class CoffeeCards extends StatefulWidget {
  const CoffeeCards({
    super.key,
  });

  @override
  State<CoffeeCards> createState() => _CoffeeCardsState();
}

class _CoffeeCardsState extends State<CoffeeCards>
    with TickerProviderStateMixin {
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (state is HomeLoaded)
              ...List.generate(
                state.images.length - 1,
                (index) => Transform.rotate(
                  //offset: const Offset(0, -50),
                  angle: -math.pi / 40.0 + index * math.pi / 20.0,
                  child: _CardView.back(index: index + 1),
                ),
              ),
            GestureDetector(
              //onTap: onSlide,
              //onHorizontalDragEnd: (details) => onSlide(),
              //onHorizontalDragStart: (details) async {
              //},
              //onHorizontalDragUpdate: print,
              child: const _CardView()
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
            ),
          ],
        );
      },
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView() : index = 0;
  const _CardView.back({required this.index});

  final int index;
  static const size = 500.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Card(
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
                  height: size,
                  width: double.maxFinite,
                  child: Center(
                    // TODO(c): Loading widget
                    child: Text('Loading...'),
                  ),
                ),
              if (state is HomeLoaded)
                Image.network(
                  index == 0 ? state.images.first : state.images[index],
                  height: size,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      height: size,
                      width: double.maxFinite,
                      'assets/images/error.png',
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: size,
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
        );
      },
    );
  }
}
