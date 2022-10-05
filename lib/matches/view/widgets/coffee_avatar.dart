import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void deleteMatch() {
    // We delete the match from the list of matches
    context.read<MatchesCubit>().deleteMatch(widget.imagePath);

    // We hide the overlay
    if (mounted) setState(() => isDeleteOverlayVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Toogle the visibility of the delete overlay
      onLongPress: toogleIsDeleteOverlayVisible,
      // Delete the match when the user taps on the delete icon
      onTap: !isDeleteOverlayVisible ? null : deleteMatch,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              height: 75,
              width: 75,
              fit: BoxFit.cover,
            ),
            if (isDeleteOverlayVisible)
              Container(
                height: 75,
                width: 75,
                color: Colors.black.withOpacity(0.5),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}
