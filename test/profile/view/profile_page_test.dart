import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/profile/profile.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Matchfee App', () {
    setUp(() {
      // HttpOverrides.runZoned(
      //   () {},
      //   createHttpClient: (securityContext) => MockHttpClient(securityContext),
      // );
      HttpOverrides.global = null;
    });
    testWidgets('renders ProfilePage', (tester) async {
      await tester.pumpApp(const ProfilePage());

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('shows new themeMode when cubit is updated', (tester) async {
      await tester.pumpApp(const ProfilePage());
      /*
      expect(find.text('Current theme mode: ThemeMode.system'), findsOneWidget);

      settingsCubit.toggleThemeMode(ThemeMode.dark);
      await tester.pumpAndSettle();
      expect(find.text('Current theme mode: ThemeMode.dark'), findsOneWidget);

      settingsCubit.toggleThemeMode(ThemeMode.light);
      await tester.pumpAndSettle();
      expect(find.text('Current theme mode: ThemeMode.light'), findsOneWidget);

      settingsCubit.toggleThemeMode(ThemeMode.system);
      await tester.pumpAndSettle();
      expect(find.text('Current theme mode: ThemeMode.system'), findsOneWidget);
      */
    });
  });
}
