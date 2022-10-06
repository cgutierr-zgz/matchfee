import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

enum CardActions {
  like,
  dislike,
  // superLike
}

class CoffeeCards extends StatelessWidget {
  const CoffeeCards({super.key});

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
                  child: _CardView.back(state: state, index: index + 1),
                ),
              ),
            const FontCoffeeCard(),
          ],
        );
      },
    );
  }
}

class FontCoffeeCard extends StatefulWidget {
  const FontCoffeeCard({super.key});

  @override
  State<FontCoffeeCard> createState() => _FontCoffeeCardState();
}

class _FontCoffeeCardState extends State<FontCoffeeCard>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late Offset position;
  late bool isDragging;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    position = Offset.zero;
    isDragging = false;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          // TODO(c): Fix this onSlide();
        }
      },
      builder: (context, state) {
        final isLoaded = state is HomeLoaded;
        return GestureDetector(
          onTap: onSlide,
          onPanStart: isLoaded ? onPanStart : null,
          onPanEnd: isLoaded ? (details) => onPanEnd(details, state) : null,
          onPanUpdate: isLoaded ? onPanUpdate : null,
          child: AnimatedContainer(
            duration:
                isDragging ? const Duration(milliseconds: 50) : Duration.zero,
            transform: Matrix4.identity()
              ..translate(
                position.dx,
                position.dy,
              ),
            child: _CardView(state: state),
            /* 
            TODO(c): Fix this
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
                */
          ),
        );
      },
    );
  }

  Future<void> onSlide() async => animationController
      .forward(from: 0)
      .then((value) => animationController.reset());

  void resetPosition() {
    Future<void>.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() => position = Offset.zero));
    setState(() => isDragging = false);
  }

  void onPanStart(DragStartDetails details) => setState(() {
        isDragging = true;
        position = Offset.zero;
      });

  void onPanUpdate(DragUpdateDetails details) => setState(() {
        isDragging = true;
        position += details.delta;
      });

  void onPanEnd(DragEndDetails details, HomeLoaded state) {
    if (position.dx > 100) {
      //  context.read<HomeBloc>().add(const HomeEvent.like());
      // send it to the right
      position = const Offset(500, 0);
      context.read<HomeBloc>().add(
            NextHomeEvent(
              image: state.images.first,
              liked: true,
            ),
          );
      resetPosition();
    } else if (position.dx < -100) {
      //  context.read<HomeBloc>().add(const HomeEvent.dislike());

      // send it to the left
      position = const Offset(-500, 0);
      context.read<HomeBloc>().add(
            NextHomeEvent(
              image: state.images.first,
              liked: false,
            ),
          );
      resetPosition();
    } else {
      resetPosition();
    }
  }
}

class _CardView extends StatelessWidget {
  const _CardView({required this.state}) : index = 0;
  const _CardView.back({
    required this.state,
    required this.index,
  });

  final int index;
  final HomeState state;

  //static const size = 500.0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.6;

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
          if (state is HomeLoading) const _LoadingWidget(),
          if (state is HomeLoaded)
            Image.network(
              index == 0
                  ? (state as HomeLoaded).images.first
                  : (state as HomeLoaded).images[index],
              height: height,
              width: double.maxFinite,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  height: height,
                  width: double.maxFinite,
                  'assets/images/error.png',
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const _LoadingWidget();
              },
            ),
        ].joinWith(const SizedBox(height: 10)),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();


  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final height = MediaQuery.of(context).size.height * 0.6;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          height: height,
          width: double.maxFinite,
          'assets/images/loading.png',
        ),
        Text(
          'Loading...',
          style: theme.textTheme.titleLarge,
        ).padded(const EdgeInsets.only(bottom: 50))
      ],
    );
  }
}