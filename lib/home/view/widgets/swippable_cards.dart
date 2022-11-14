import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/core.dart';

class SwippableCards extends StatelessWidget {
  const SwippableCards({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final size = context.currentSize;
    final height = size.height * 0.70;
    final width = size.width * 0.90;

    return Stack(
      children: List.generate(
        images.length,
        (index) {
          return const _Card();
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                images.reversed.toList()[index],
                height: height,
                width: width,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Image.asset(
                    'assets/images/loading.png',
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/error.png',
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

enum Action { like, superLike, disLike }

class _Card extends StatefulWidget {
  const _Card();

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with TickerProviderStateMixin {
  late Offset position;
  late bool isDragging;
  Action? action;

  @override
  void initState() {
    super.initState();
    position = Offset.zero;
    isDragging = false;
  }

  void onPanStart(DragStartDetails details) => setState(() {
        isDragging = true;
        position = Offset.zero;
      });

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      isDragging = true;
      position += details.delta;
    });
    if (position.dx > 100) {
      setState(() => action = Action.like);
    } else if (position.dx < -100) {
      setState(() => action = Action.disLike);
    } else if (position.dy < -100) {
      setState(() => action = Action.superLike);
    } else {
      setState(() => action = null);
    }
  }

  void onPanEnd(DragEndDetails details, CoffeesLoaded state) {
    if (position.dx > 100) {
      // send it to the right
      position = const Offset(500, 0);
      context
          .read<CoffeeBloc>()
          .add(NextCoffeeEvent.like(image: state.images.first));
    } else if (position.dx < -100) {
      // send it to the left
      position = const Offset(-500, 0);
      context.read<CoffeeBloc>().add(
            NextCoffeeEvent.dislike(image: state.images.first),
          );
    } else if (position.dy < -100) {
      // send it up
      position = const Offset(0, -500);
      context
          .read<CoffeeBloc>()
          .add(NextCoffeeEvent.superLike(image: state.images.first));
    } else {
      setState(() => position = Offset.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeeBloc, CoffeeState>(
      listener: (context, state) {
        if (state is CoffeesLoaded) {
          setState(() {
            position = Offset.zero;
            isDragging = false;
            action = null;
          });
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
              child: Stack(
                children: [
                  _CardView(state: state, index: 0),
                  if (action != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: action == Action.like
                              ? Alignment.centerLeft
                              : action == Action.disLike
                                  ? Alignment.centerRight
                                  : Alignment.bottomCenter,
                          end: action == Action.like
                              ? Alignment.centerRight
                              : action == Action.disLike
                                  ? Alignment.centerLeft
                                  : Alignment.topCenter,
                          colors: [
                            if (action == Action.like) ...[
                              Colors.green.withOpacity(0),
                              Colors.green
                            ] else if (action == Action.disLike) ...[
                              Colors.red.withOpacity(0),
                              Colors.red
                            ] else ...[
                              Colors.blue.withOpacity(0),
                              Colors.blue
                            ]
                          ],
                          stops: const [0.0, 0.6],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          action == Action.like
                              ? 'Like'
                              : action == Action.disLike
                                  ? 'Dislike'
                                  : 'Super Like',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({
    required this.state,
    required this.index,
  });

  final int index;
  final CoffeeState state;

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
                  return const Text('error');
                  //return ErrorImage(
                  //  height: height,
                  //  width: double.maxFinite,
                  //);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _PladeholderWidget(hasError: false);
                },
              ),
            if (state is CoffeesError) const _PladeholderWidget(hasError: true),
            if (state is CoffeeLoading)
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
          const Text(
            'error',
          ) //ErrorImage(width: double.maxFinite, height: height)
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
