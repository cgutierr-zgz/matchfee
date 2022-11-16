import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.leadTitle,
    required this.trailTitle,
    this.showAppIcon = false,
    this.leading,
    this.actions,
  });

  final String leadTitle;
  final String trailTitle;
  final bool showAppIcon;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _AppBarLogo(
        leadTitle: leadTitle,
        trailTitle: trailTitle,
        showIcon: showAppIcon,
      ),
      leading: leading,
      actions: actions,
    );
  }
}

class _AppBarLogo extends StatelessWidget {
  const _AppBarLogo({
    required this.leadTitle,
    required this.trailTitle,
    required this.showIcon,
  });

  final String leadTitle;
  final String trailTitle;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: leadTitle,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: trailTitle,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        if (showIcon) ...[
          const SizedBox(width: 10),
          Image.asset(
            'assets/images/logo.png',
            height: 40,
            width: 40,
          ),
        ]
      ],
    );
  }
}
