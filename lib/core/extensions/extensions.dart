import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// {@template joined_widgets}
/// Adds a specific type of [Widget] in between a list of Widgets
/// This can be usefull to add some height in between Widgets
/// without the need of writing it multiple times
///
/// Example:
/// ```dart
/// [
///  const Text('CARLOS'),
///  const Text('MOBILE SOLUTIONS'),
/// ].joinWithSeparator(const SizedBox(height: 10));
/// ```
/// {@endtemplate}
extension JoinedWidgets on List<Widget> {
  /// {@macro joined_widgets}
  List<Widget> joinWith(Widget? separator) {
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
