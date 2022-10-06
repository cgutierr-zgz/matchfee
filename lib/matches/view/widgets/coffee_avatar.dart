import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class CoffeeAvatar extends StatefulWidget {
  const CoffeeAvatar({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  State<CoffeeAvatar> createState() => _CoffeeAvatarState();
}

class _CoffeeAvatarState extends State<CoffeeAvatar> {
  late bool isDeleteOverlayVisible;
  static const size = 75.0;

  @override
  void initState() {
    super.initState();
    isDeleteOverlayVisible = false;
  }

  // We enable or disable the delete overlay based on the value of the
  // isDeleteOverlayVisible variable.
  void toogleIsDeleteOverlayVisible() {
    setState(() => isDeleteOverlayVisible = !isDeleteOverlayVisible);

    // We hide the overlay after 3 seconds
    if (isDeleteOverlayVisible) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => isDeleteOverlayVisible = false);
      });
    }
  }

  // Delete the match when the user taps on the delete icon
  // and hides the overlay
  void deleteMatch() {
    context.read<MatchesCubit>().deleteMatch(widget.imagePath);

    if (mounted) setState(() => isDeleteOverlayVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: toogleIsDeleteOverlayVisible,
      onTap: !isDeleteOverlayVisible ? null : deleteMatch,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              height: size,
              width: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ErrorImage(size: size),
            ),
            deleteIcon,
          ],
        ),
      ),
    );
  }

  Widget get deleteIcon => AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isDeleteOverlayVisible ? 1 : 0,
        child: Container(
          height: size,
          width: size,
          color: Colors.black.withOpacity(0.5),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      );
}
