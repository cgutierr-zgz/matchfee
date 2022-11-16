import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

extension BuildContextX on BuildContext {
  /// Grants access to [ThemeData] based on given context
  ///
  /// Usage:
  /// ```dart
  /// final theme = context.theme;
  /// ```
  ///
  /// {@macro theme_extension}
  ThemeData get theme => Theme.of(this);

  /// Gives access to [Size] based on given context
  ///
  /// Usage:
  /// ```dart
  /// final size = context.currentSize;
  /// ```
  ///
  /// {@macro size_extension}
  Size get currentSize => MediaQuery.of(this).size;

  /// Push a given widget to the navigator stack
  ///
  /// Usage:
  /// ```dart
  /// context.push(MyCoolPage());
  /// ```
  void push(Widget widget) => Navigator.of(this).push(
        MaterialPageRoute<dynamic>(builder: (context) => widget),
      );

  /// Pops the current route off the navigator that most tightly encloses the
  /// given context.
  ///
  /// Usage:
  /// ```dart
  /// context.pop();
  /// ```
  void pop() => Navigator.of(this).pop();

  /// Shows a snackbar with the given message and hides the other snackbars.
  ///
  /// Usage:
  /// ```dart
  /// context.showSnackbar('Very good message');
  /// ```
  ///
  /// {@macro l10n_extension}
  void showSnackbar(
    String message, {
    bool error = false,
    IconData? prefixIcon,
    void Function()? onPressed,
    Duration duration = const Duration(seconds: 1),
  }) =>
      ScaffoldMessenger.of(this)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: duration,
            content: error
                ? CustomSnackbar.error(message: message, onPressed: onPressed)
                : CustomSnackbar(
                    message: message,
                    prefixIcon: prefixIcon,
                    onPressed: onPressed,
                  ),
          ),
        );
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
  /// {@macro padded_widget}
  Widget padded([EdgeInsets? padding]) => Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
        child: this,
      );
}
