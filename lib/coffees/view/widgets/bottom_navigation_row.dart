import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/core/core.dart';

class BottomNavigationRow extends StatelessWidget {
  const BottomNavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CoffeesBloc, CoffeesState>(
      builder: (context, state) {
        final isLoaded = state is CoffeesLoaded;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomItem.small(
              icon: Icons.undo_rounded,
              color: Colors.yellow,
              onPressed:
                  isLoaded && context.read<CoffeesBloc>().photoToDelete != null
                      ? () => context.read<CoffeesBloc>().add(
                            const PreviousCoffeesEvent(),
                          )
                      : null,
            ),
            BottomItem(
              icon: Icons.close_rounded,
              color: Colors.red,
              onPressed: isLoaded
                  ? () => context
                      .read<CoffeesBloc>()
                      .add(NextCoffeesEvent.dislike(image: state.images.first))
                  : null,
            ),
            BottomItem(
              icon: Icons.favorite_rounded,
              color: Colors.green,
              onPressed: isLoaded
                  ? () => context
                      .read<CoffeesBloc>()
                      .add(NextCoffeesEvent.like(image: state.images.first))
                  : null,
            ),
            BottomItem.small(
              icon: Icons.star_rounded,
              color: Colors.blue,
              onPressed: isLoaded
                  ? () {
                      context.read<CoffeesBloc>().add(
                            NextCoffeesEvent.superLike(
                              image: state.images.first,
                            ),
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
