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
            children: [
              const Spacer(flex: 2),
              _BottomBarItem.small(
                rotate: true,
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
              const Spacer(),
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
              const Spacer(),
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
              const Spacer(),
              _BottomBarItem.small(
                rotate: false,
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
              const Spacer(flex: 2),
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
  })  : size = 50,
        rotate = false;

  const _BottomBarItem.small({
    required this.onPressed,
    required this.gradient,
    required this.icon,
    required this.rotate,
  }) : size = 30;

  final double size;
  final void Function()? onPressed;
  final Gradient? gradient;
  final IconData icon;
  final bool rotate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return CustomAnimatedButton(
      rotate: rotate,
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.brightness == Brightness.dark
              ? Colors.black45
              : theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.1),
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
