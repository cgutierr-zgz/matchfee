import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class BottomHomeRow extends StatelessWidget {
  const BottomHomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const Text('loading');
        if (state is HomeError) return const Text('Error');

        state as HomeLoaded;
        return Row(
          // TODO(c): make them cooler, and add this cool bubble effect to them too
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            BottomItem.small(
              icon: Icons.undo_rounded,
              color: Colors.yellow,
              onPressed: () => context.read<HomeBloc>().add(
                    const PreviousHomeEvent(),
                  ),
            ),
            BottomItem(
              icon: Icons.close_rounded,
              color: Colors.red,
              onPressed: () {
                context.read<HomeBloc>().add(
                      LikeHomeEvent(
                        image: state.images.first,
                        liked: false,
                      ),
                    );
              },
            ),
            BottomItem(
              icon: Icons.favorite_rounded,
              color: Colors.green,
              onPressed: () {
                context.read<HomeBloc>().add(
                      LikeHomeEvent(
                        image: state.images.first,
                        liked: true,
                      ),
                    );
              },
            ),
            BottomItem.small(
              icon: Icons.star_rounded,
              color: Colors.blue,
              onPressed: () {},
            ),
            const Spacer(),
          ].joinWith(const SizedBox(width: 20)),
        );
      },
    );
  }
}
