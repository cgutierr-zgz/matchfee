import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/core/core.dart';

enum CardActions {
  like,
  dislike,
  // superLike
}

class CoffeeCards extends StatelessWidget {
  const CoffeeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeesBloc, CoffeesState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (state is CoffeesLoaded)
              ...List.generate(
                state.images.length - 1,
                (index) => Transform.rotate(
                  angle: -math.pi / 40.0 + index * math.pi / 20.0,
                  child: _CardView(
                    state: state,
                    index: state.images.length - index - 1,
                  ),
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
  late Offset position;
  late bool isDragging;

  @override
  void initState() {
    super.initState();
    position = Offset.zero;
    isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeesBloc, CoffeesState>(
      listener: (context, state) {
        if (state is CoffeesLoaded) {
          position = Offset.zero;
          isDragging = false;
          setState(() {});
        }
      },
      builder: (context, state) {
        final isLoaded = state is CoffeesLoaded;
        return GestureDetector(
          onPanStart: isLoaded ? onPanStart : null,
          onPanEnd: isLoaded ? (details) => onPanEnd(details, state) : null,
          onPanUpdate: isLoaded ? onPanUpdate : null,
          child: AnimatedRotation(
            // adds subtle rotation on drag
            turns: isDragging ? position.dx / 10000 : 0,
            duration: const Duration(milliseconds: 500),
            child: AnimatedContainer(
              duration:
                  isDragging ? const Duration(milliseconds: 50) : Duration.zero,
              transform: Matrix4.identity()
                ..translate(
                  position.dx,
                  position.dy,
                ),
              child: _CardView(state: state, index: 0),
            ),
          ),
        );
      },
    );
  }

  void onPanStart(DragStartDetails details) => setState(() {
        isDragging = true;
        position = Offset.zero;
      });

  void onPanUpdate(DragUpdateDetails details) => setState(() {
        isDragging = true;
        position += details.delta;
      });

  void onPanEnd(DragEndDetails details, CoffeesLoaded state) {
    if (position.dx > 100) {
      // send it to the right
      position = const Offset(500, 0);
      context
          .read<CoffeesBloc>()
          .add(NextCoffeesEvent.like(image: state.images.first));
    } else if (position.dx < -100) {
      // send it to the left
      position = const Offset(-500, 0);
      context.read<CoffeesBloc>().add(
            NextCoffeesEvent.dislike(image: state.images.first),
          );
    }
  }
}

class _CardView extends StatelessWidget {
  const _CardView({
    required this.state,
    required this.index,
  });

  final int index;
  final CoffeesState state;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
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
            if (state is CoffeesLoaded)
              Image.network(
                (state as CoffeesLoaded).images[index],
                height: height,
                width: double.maxFinite,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ErrorImage(
                    height: height,
                    width: double.maxFinite,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _PladeholderWidget(hasError: false);
                },
              ),
            if (state is CoffeesError) const _PladeholderWidget(hasError: true),
            if (state is CoffeesLoading)
              const _PladeholderWidget(hasError: false),
          ].joinWith(const SizedBox(height: 10)),
        ),
      ),
    );
  }
}

class _PladeholderWidget extends StatelessWidget {
  const _PladeholderWidget({required this.hasError});

  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final height = MediaQuery.of(context).size.height * 0.5;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (hasError)
          ErrorImage(width: double.maxFinite, height: height)
        else
          Image.asset(
            width: double.maxFinite,
            height: height,
            'assets/images/loading.png',
          ),
        Text(
          hasError ? l10n.error : '${l10n.loadingText}...',
          style: theme.textTheme.titleLarge,
        ).padded(const EdgeInsets.only(bottom: 50))
      ],
    );
  }
}
