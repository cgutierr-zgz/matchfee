import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({
    super.key,
    required this.message,
    this.prefixIcon,
    this.onPressed,
  }) : backgroundColor = Colors.blueAccent;

  const CustomSnackbar.error({
    super.key,
    required this.message,
    this.onPressed,
  })  : prefixIcon = Icons.error,
        backgroundColor = Colors.red;

  final IconData? prefixIcon;
  final Color backgroundColor;
  final String message;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
          if (onPressed != null)
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    onPressed?.call();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Text(l10n.acceptButton),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  child: Text(l10n.cancelButton),
                )
              ],
            )
        ],
      ),
    );
  }
}
