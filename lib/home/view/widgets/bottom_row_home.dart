import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class BottomRowHome extends StatelessWidget {
  const BottomRowHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoaded = state is HomeLoaded;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            BottomItem.small(
              icon: Icons.undo_rounded,
              color: Colors.yellow,
              onPressed:
                  isLoaded && context.read<HomeBloc>().photoToDelete != null
                      ? () => context.read<HomeBloc>().add(
                            const PreviousHomeEvent(),
                          )
                      : null,
            ),
            BottomItem(
              icon: Icons.close_rounded,
              color: Colors.red,
              onPressed: isLoaded
                  ? () {
                      context.read<HomeBloc>().add(
                            NextHomeEvent(
                              image: state.images.first,
                              liked: false,
                            ),
                          );
                    }
                  : null,
            ),
            BottomItem(
              icon: Icons.favorite_rounded,
              color: Colors.green,
              onPressed: isLoaded
                  ? () {
                      context.read<HomeBloc>().add(
                            NextHomeEvent(
                              image: state.images.first,
                              liked: true,
                            ),
                          );
                    }
                  : null,
            ),
            BottomItem.small(
              icon: Icons.star_rounded,
              color: Colors.blue,
              onPressed: isLoaded
                  ? () => context.showSnackbar(
                        'I love u too',
                        prefixIcon: Icons.favorite_rounded,
                      )
                  : null,
            ),
            const Spacer(),
          ].joinWith(const SizedBox(width: 20)),
        );
      },
    );
  }
}
