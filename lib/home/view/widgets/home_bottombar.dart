import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';

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
              IconButton(
                iconSize: 30,
                icon: GradientIcon.small(
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
                onPressed: isBackAvailable
                    ? () => context
                        .read<CoffeeBloc>()
                        .add(const PreviousCoffeeEvent())
                    : null,
              ),
              IconButton(
                iconSize: 50,
                icon: const GradientIcon(
                  icon: Icons.close_rounded,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.redAccent,
                    ],
                  ),
                ),
                onPressed: isLoaded
                    ? () => context.read<CoffeeBloc>().add(
                          NextCoffeeEvent.dislike(image: state.images.first),
                        )
                    : null,
              ),
              IconButton(
                iconSize: 50,
                icon: const GradientIcon(
                  icon: Icons.favorite_rounded,
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.greenAccent,
                    ],
                  ),
                ),
                onPressed: isLoaded
                    ? () => context
                        .read<CoffeeBloc>()
                        .add(NextCoffeeEvent.like(image: state.images.first))
                    : null,
              ),
              IconButton(
                iconSize: 30,
                icon: const GradientIcon.small(
                  icon: Icons.star_rounded,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blueAccent,
                    ],
                  ),
                ),
                onPressed: isLoaded
                    ? () => context.read<CoffeeBloc>().add(
                          NextCoffeeEvent.superLike(
                            image: state.images.first,
                          ),
                        )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    super.key,
    required this.icon,
    this.size = 50,
    this.gradient,
  });
  const GradientIcon.small({
    super.key,
    required this.icon,
    this.size = 30,
    this.gradient,
  });

  final IconData icon;
  final double size;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final shaderGradient = gradient ??
        const LinearGradient(
          colors: [
            Colors.grey,
            Colors.grey,
          ],
        );

    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final rect = Rect.fromLTRB(0, 0, size, size);

        return shaderGradient.createShader(rect);
      },
    );
  }
}
