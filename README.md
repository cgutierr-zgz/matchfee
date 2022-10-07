# <img src="assets/images/logo.png" alt="logo" width="40"/> Matchfee 


![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

Drinking Coffee & Finding Love ☕️
Since 2022 ©


>⚠️ **Note**
>Could not test on a real iOS device, since the only one I have is from my company and It's not allowed to install apps from outside the App Store
>Worked just fine on the simulator though
>Also tested in Android real device and it worked just fine

---

## Synopsis

- [App Features and Guide](#app-features-and-guide-)
- [Things I would have like to do](#things-i-would-have-like-to-do-)
- [Packages I've used and why](#packages-ive-used-and-why-)
- [Getting Started](#getting-started-)
- [Running Tests](#running-tests-)
- [Working with Translations ](#working-with-translations-)

---

## App Features and Guide 📱

The app is called **Matchfee**, and it has no inspiration from any other app, I swear... 🤥
Well... maybe a little bit from [Tinder](https://www.tinder.com/) 😅

I'm sure it's not the first test with this approach, or even the same name (Hopefully no 🤞), and it is an app where you will be able to like some coffee pictures, and those will be stored locally on the device.
You can also see the list of liked coffee pictures, and you can also delete them from the list.

It has three main features:

#### Home Screen

Here, the user will see a list of coffee images as a stack of cards.
He can interact with them by swiping left or right, or clicking on the buttons.

1. When the user clicks on the Heart button, the coffee image will be added to the Favorites list **and saved to the device**, making use of **HydratedBloc**, and the image will be deleted from the stack.
2. When the user clicks on the Close button(X), the coffee image will be dismissed, and the Undo button will become available.
3. If the Undo button is available (Once we dislike a coffee) and is clicked, the coffee image will be added back to the stack.
3. When the user swipes left or right, the coffee image will be either added to the Favorites list _(Refer to point 1)_, or dismissed _(Refer to point 2)_.
4. The super like button just does the same as the heart button, but it will also add the property `isSuperLiked` to the coffee image, making it appear with a blue star when a coffee talks to you/you talk to it.

#### Matchees Screen

See what I did there? 😏... _another pun, I know, I'm sorry._

Here, the user will see two lists.

1. List of coffee images that he has liked on the section "NEW MATCHEES", where you can only interact with the given image (coffee) by **long pressing on the image**, after the long press, the user can **delete the image** from the list.

2. There's a secont section which is "OPEN CHATS", where, randomly some coffees will start talking to you, and you talk back to them... This is **Random**, u can't actually talk to them, there's just a premade message, some coffees might appear with the blue star, which means that they are super liked.


#### Conffeeg Screen

And another pun 😅

This isn't really a feature of the app, but it's just a page that shows a small information text.

There's a **hidden easteregg** on this page tho 😏

If there's data stored, you'll be able to wipe it out, and start fresh.

Hope you enjoy it,


_Carlos 💙... 🦄_

---

## Things I would have like to do 🤞

1. Add more tests:
I've never had the chance to do almost any tests in the companies I've worked for, so there's things I still don't know how to test yet.
There's notes on the tests with the parts I don't really know how to test, mainly related to storage.
Also, there's tests marked as `skipped` since they just don't work the same way in Github Actions as they do locally.
In theory i had like ~81% of coverage, but after skipping those test it's 77.7% which also looks cool 🎰
I know that's a drawback for the company but I'd love to learn about it and improve as much as possible, hopefully I'll be able to do it in VGV :)

2. Add more animations:
I've added some animations, but I would have like to add more so it looks more polished.
Didn't wanted it to be an overkill, but I would have like to add more.

3. Improve the swiping animation:
I've added a simple animation when the user swipes left or right, but I would have like to add a more complex one.

4. Random profile information:
I would have like to add some random profile information, like name, age, etc.

5. Dark mode:
Dark mode was easy to implement, I've done it a lot of times, but again, sounded like an overkill for this test.

6. Improve the storage of the images:
I've used the `path_provider` and `hydrated_bloc` packages to store the images, but I would have like to use a better approach, like a database, or something like that, but I didn't wanted to overcomplicate the test.

_Also, I didn't translated the Settings Page, cause at the end of the day it's just a page with a message, I just hope you like it 💙_

---

## Packages I've Used And Why 📦

1. [flutter_bloc](https://pub.dev/packages/flutter_bloc)
I've used the flutter implementation of bloc beacuse I'm familiar with it, I've already used it a lot of times, well, basically in all my projects, so I know how to use it and how to implement it.

2. [hydrated_bloc](https://pub.dev/packages/hydrated_bloc)
I made a small cubit which handles the favorites, and it's hydrated, so it saves the data locally, just like magic ✨

3. [path_provider](https://pub.dev/packages/path_provider)
Used to get the path where the data is being stored, so I can write there and read from there.

4. [http](https://pub.dev/packages/http)
Used to make the requests to the Coffee API to get the random image.
I'm more used to [dio](https://pub.dev/packages/dio), but http was more than enough for this test.

5. [equtable](https://pub.dev/packages/equatable)
I didn't thought I would need it, but I ended up using it to compare the states of the blocs correctly, I'm used to it and I love it.

I also like to use [flutter_gen](https://pub.dev/packages/flutter_gen) for the asset generation, to be less Error-Prone, but in this case we had only 3 images, so nevermind.

---

## Getting Started 🚀

This project contains no flavors, sorry, I deleted them.

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run
# You might get prompted to choose a device
# if there's multiple available,
# input the number of the desired one, and hit Enter
$ Please choose one (To quit, press "q/Q"): 1
```

_\*Matchfee works on iOS, and Android_

Once the build is done you can refer to [App Features and Guide](#app-features-and-guide)

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

Install lcov

```sh
$ brew install lcov
```

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

Everything together:
```sh
$ flutter test --coverage --test-randomize-ordering-seed random && genhtml coverage/lcov.info -o coverage/ && open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:matchfee/core/core.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[logo]: assets/images/logo.png
[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
