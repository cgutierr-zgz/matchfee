import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

/// {@template custom_snackbar}
/// A custom snackbar with two constructors:
/// [CustomSnackbar] and [CustomSnackbar.error].
///
/// {@endtemplate}
class CustomSnackbar extends StatelessWidget {
  /// [CustomSnackbar] with a message and an optional prefix icon and action.
  ///
  /// Example:
  /// ```dart
  /// CustomSnackbar(
  ///   message: 'My message',
  ///   prefixIcon: Icons.abc,
  ///   onPressed: () {},
  /// );
  /// ```
  /// {@macro custom_snackbar}
  const CustomSnackbar({
    super.key,
    required this.message,
    this.prefixIcon,
    this.onPressed,
  }) : backgroundColor = Colors.blueAccent;

  /// Error [CustomSnackbar] with a message and an optional action.
  /// Icon is automatically set to [Icons.error].
  ///
  /// Example:
  /// ```dart
  /// CustomSnackbar.error(
  ///   message: 'My Error',
  ///   onPressed: () {},
  ///   // prefixIcon is set by default to Icons.error
  /// );
  /// ```
  /// {@macro custom_snackbar}
  const CustomSnackbar.error({
    super.key,
    required this.message,
    this.onPressed,
  })  : prefixIcon = Icons.error,
        backgroundColor = Colors.red;

  /// The Icon that will be displayed on the left side of the snackbar.
  final IconData? prefixIcon;

  /// The message to be displayed.
  final String message;

  /// Action to be performed when the snackbar accept button is pressed.
  final void Function()? onPressed;

  /// The background color of the snackbar defaults to [Colors.blueAccent]
  /// for [CustomSnackbar] and [Colors.red] for [CustomSnackbar.error].
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (prefixIcon != null) Icon(prefixIcon, color: Colors.white),
              Expanded(
                child: Text(
                  message,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ].joinWith(const SizedBox(width: 6)),
          ),
          if (onPressed != null) _SnackbarActions(onPressed!)
        ],
      ),
    );
  }
}

class _SnackbarActions extends StatelessWidget {
  const _SnackbarActions(this.onPressed);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            onPressed.call();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: const Text('Accept'),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
