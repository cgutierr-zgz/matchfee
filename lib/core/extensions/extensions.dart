import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// {@template l10n_extension}
/// Grants access to the [AppLocalizations] instance based on the given context.
///
/// Usage:
/// ```dart
/// final l10n = context.l10n;
/// ```
/// {@endtemplate}
extension AppLocalizationsX on BuildContext {
  /// {@macro l10n_extension}
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// {@template theme_extension}
/// Grants access to [ThemeData] based on given context
///
/// Usage:
/// ```dart
/// final theme = context.theme;
/// ```
/// {@endtemplate}
extension ThemeDataX on BuildContext {
  /// {@macro theme_extension}
  ThemeData get theme => Theme.of(this);
}

/// {@template joined_widgets}
/// Adds a specific type of [Widget] in between a list of Widgets
/// It defaults to [SizedBox(height: 24, width: 24)]
/// This can be usefull to add some height in between Widgets
/// without the need of writing it multiple times
///
/// Example:
/// ```dart
/// [
///  const Text('Hi, I hope you are doing well'),
///  const Text('I'm Carlos and I'm a Flutter Developer'),
/// ].joinWithSeparator(const SizedBox(height: 10));
/// ```
/// {@endtemplate}
extension JoinedWidgetsX on List<Widget> {
  /// {@macro joined_widgets}
  List<Widget> joinWith([Widget? separator]) {
    return length > 1
        ? (take(length - 1)
            .map(
              (widget) =>
                  [widget, separator ?? const SizedBox(height: 24, width: 24)],
            )
            .expand((widget) => widget)
            .toList()
          ..add(last))
        : this;
  }
}

/// {@template padded_widget}
/// Adds a [Padding] [Widget] on top of the current [Widget]
/// Default [Padding] is [EdgeInsets.symmetric(horizontal: 20)]
///
/// Example:
/// ```dart
/// Text("I'm getting padded'").padded(),
/// Text("I'm also getting paddeed, but more!!").padded(
///   EdgeInsets.symmetric(horizontal: 200), // :o
/// );
/// ```
/// {@endtemplate}
extension PaddedWidgetX on Widget {
  void a() {
    const Text("I'm also getting paddeed, but more!!").padded(
      const EdgeInsets.symmetric(horizontal: 200),
    );
  }

  /// {@macro padded_widget}
  Widget padded([EdgeInsets? padding]) => Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
        child: this,
      );
}
