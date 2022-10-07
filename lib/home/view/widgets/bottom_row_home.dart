import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class BottomRowHome extends StatelessWidget {
  const BottomRowHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoaded = state is HomeLoaded;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  ? () => context
                      .read<HomeBloc>()
                      .add(NextHomeEvent.dislike(image: state.images.first))
                  : null,
            ),
            BottomItem(
              icon: Icons.favorite_rounded,
              color: Colors.green,
              onPressed: isLoaded
                  ? () => context
                      .read<HomeBloc>()
                      .add(NextHomeEvent.like(image: state.images.first))
                  : null,
            ),
            BottomItem.small(
              icon: Icons.star_rounded,
              color: Colors.blue,
              onPressed: isLoaded
                  ? () {
                      context.read<HomeBloc>().add(
                            NextHomeEvent.superLike(image: state.images.first),
                          );
                      context.showSnackbar(
                        l10n.iLoveYouTooText,
                        prefixIcon: Icons.favorite_rounded,
                      );
                    }
                  : null,
            ),
          ].joinWith(const SizedBox(width: 20)),
        );
      },
    );
  }
}
