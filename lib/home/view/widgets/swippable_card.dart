import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/core.dart';

enum _SwipeAction { like, superLike, disLike }

class SwippableCard extends StatefulWidget {
  const SwippableCard({super.key});

  @override
  State<SwippableCard> createState() => _SwippableCardState();
}

class _SwippableCardState extends State<SwippableCard>
    with TickerProviderStateMixin {
  late Offset position;
  late bool isDragging;
  _SwipeAction? action;

  @override
  void initState() {
    super.initState();
    position = Offset.zero;
    isDragging = false;
  }

  void onPanUpdate(DragUpdateDetails details, CoffeesLoaded state) {
    setState(() {
      isDragging = true;
      position += details.delta;
    });
    if (position.dx > 50) {
      setState(() => action = _SwipeAction.like);
    } else if (position.dx < -50) {
      setState(() => action = _SwipeAction.disLike);
    } else if (position.dy < -100) {
      setState(() => action = _SwipeAction.superLike);
    } else {
      setState(() {
        action = null;
      });
    }
  }

  void onPanEnd(DragEndDetails details, CoffeesLoaded state) {
    switch (action) {
      case _SwipeAction.like:
        setState(() => position = const Offset(500, 0));
        context
            .read<CoffeesBloc>()
            .add(NextCoffeeEvent.like(image: state.images.first));
        break;
      case _SwipeAction.superLike:
        setState(() => position = const Offset(0, -1500));
        context
            .read<CoffeesBloc>()
            .add(NextCoffeeEvent.superLike(image: state.images.first));
        break;
      case _SwipeAction.disLike:
        setState(() => position = const Offset(-500, 0));
        context.read<CoffeesBloc>().add(
              NextCoffeeEvent.dislike(image: state.images.first),
            );

        break;
      case null:
        position = Offset.zero;
        break;
    }
    setState(() {
      isDragging = false;
      action = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = context.currentSize;
    final width = size.width * 0.9;
    final height = size.height * 0.7;

    return BlocConsumer<CoffeesBloc, CoffeesState>(
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
          onPanEnd: isLoaded ? (details) => onPanEnd(details, state) : null,
          onPanUpdate: (details) =>
              isLoaded ? onPanUpdate(details, state) : null,
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
                  _CardView(
                    state: state,
                    index: 0,
                    height: height,
                    width: width,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: action != null ? 1 : 0,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: action == _SwipeAction.like
                              ? Alignment.centerLeft
                              : action == _SwipeAction.disLike
                                  ? Alignment.centerRight
                                  : Alignment.bottomCenter,
                          end: action == _SwipeAction.like
                              ? Alignment.centerRight
                              : action == _SwipeAction.disLike
                                  ? Alignment.centerLeft
                                  : Alignment.topCenter,
                          colors: [
                            if (action == _SwipeAction.like) ...[
                              Colors.green.withOpacity(0),
                              Colors.green.withOpacity(0.5)
                            ] else if (action == _SwipeAction.disLike) ...[
                              Colors.red.withOpacity(0),
                              Colors.red.withOpacity(0.5)
                            ] else if (action == _SwipeAction.superLike) ...[
                              Colors.blue.withOpacity(0),
                              Colors.blue.withOpacity(0.5)
                            ] else ...[
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0)
                            ]
                          ],
                          stops: const [0.0, 0.6],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          action == _SwipeAction.like
                              ? 'Like'
                              : action == _SwipeAction.disLike
                                  ? 'Dislike'
                                  : action == _SwipeAction.superLike
                                      ? 'Super Like'
                                      : '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
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
    required this.height,
    required this.width,
  });

  final int index;
  final CoffeesState state;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: state.when(
        error: (exception) => _PladeholderWidget(
          hasError: true,
          height: height,
          width: width,
        ),
        loading: () => _PladeholderWidget(
          hasError: false,
          height: height,
          width: width,
        ),
        loaded: (images) => Image.network(
          (state as CoffeesLoaded).images[index],
          height: height,
          width: width,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            width: width,
            height: height,
            'assets/images/error.png',
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _PladeholderWidget(
              hasError: false,
              height: height,
              width: width,
            );
          },
        ),
      ),
    );
  }
}

class _PladeholderWidget extends StatelessWidget {
  const _PladeholderWidget({
    required this.hasError,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (hasError)
          Image.asset(
            width: width,
            height: height,
            'assets/images/error.png',
          )
        else
          Image.asset(
            width: width,
            height: height,
            'assets/images/loading.png',
          ),
        Text(
          hasError ? 'Error' : 'Loading...',
          style: theme.textTheme.titleLarge,
        ).padded(const EdgeInsets.only(bottom: 50))
      ],
    );
  }
}
