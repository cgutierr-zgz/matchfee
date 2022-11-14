import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/core.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        final isLoaded = state is CoffeesLoaded;
        final isBackAvailable =
            isLoaded && context.read<CoffeeBloc>().photoToDelete != null;

        return SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BottomBarItem.small(
                onPressed: isBackAvailable
                    ? () => context
                        .read<CoffeeBloc>()
                        .add(const PreviousCoffeeEvent())
                    : null,
                icon: Icons.replay_rounded,
                gradient: isBackAvailable
                    ? const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.yellow,
                        ],
                      )
                    : null,
              ),
              _BottomBarItem(
                onPressed: isLoaded
                    ? () => context.read<CoffeeBloc>().add(
                          NextCoffeeEvent.dislike(image: state.images.first),
                        )
                    : null,
                icon: Icons.close_rounded,
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.redAccent,
                  ],
                ),
              ),
              _BottomBarItem(
                onPressed: isLoaded
                    ? () => context
                        .read<CoffeeBloc>()
                        .add(NextCoffeeEvent.like(image: state.images.first))
                    : null,
                icon: Icons.favorite_rounded,
                gradient: const LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.greenAccent,
                  ],
                ),
              ),
              _BottomBarItem.small(
                onPressed: isLoaded
                    ? () => context.read<CoffeeBloc>().add(
                          NextCoffeeEvent.superLike(
                            image: state.images.first,
                          ),
                        )
                    : null,
                icon: Icons.star_rounded,
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.blueAccent,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.onPressed,
    required this.gradient,
    required this.icon,
  }) : size = 50;

  const _BottomBarItem.small({
    required this.onPressed,
    required this.gradient,
    required this.icon,
  }) : size = 30;
  final double size;
  final void Function()? onPressed;
  final Gradient? gradient;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: GradientIcon(
          icon: icon,
          size: size,
          gradient: gradient,
        ),
      ),
    );
  }
}

/*
class _BottomBarItem extends StatefulWidget {
  const _BottomBarItem({
    required this.onPressed,
    required this.gradient,
    required this.icon,
  }) : size = 50;

  const _BottomBarItem.small({
    required this.onPressed,
    required this.gradient,
    required this.icon,
  }) : size = 30;

  final double size;
  final void Function()? onPressed;
  final Gradient? gradient;
  final IconData icon;

  @override
  State<_BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late double size;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    size = widget.size;
  }

  @override
  void didUpdateWidget(_BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.size != widget.size) animateWidget();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // TODO: Add debounce
  void animateWidget() {
    final Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    final tween = Tween<double>(begin: 0.5, end: 1).animate(curve);

    tween.addListener(() => setState(() => size = widget.size * tween.value));

    controller
      ..reset()
      ..forward();

    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: widget.onPressed != null ? animateWidget : null,
      onTapDown: (_) => setState(() => size = widget.size * 0.5),
      tap
      child: Container(
        width: size + 15,
        height: size + 15,
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: GradientIcon(
          icon: widget.icon,
          size: size,
          gradient: widget.gradient,
        ),
      ),
    );
  }
}
*/