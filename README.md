# Localize

![Static Badge](https://img.shields.io/badge/Flutter-blue)
[![Localize](https://github.com/carllosnc/localize/actions/workflows/dart.yml/badge.svg)](https://github.com/carllosnc/localize/actions/workflows/dart.yml)

> Localize is a package that allows you to easily translate your Flutter app.

The main motivation for this package was creating a simple and easy way to translate legacy Flutter apps. So, which would be the better solution to apply translations to hundreds of hardcoded strings? Happily Dart provides a fantastic feature to help with this problem, [Extension methods in Dart](https://dart.dev/guides/language/extension-methods) allow us to add methods to an existing class without modifying the class itself.

**Example:**

```dart
Text('Hello world'.localize);
// pt-BR: "Olá mundo",
// es: "Hola mundo"
```

If the language is set to "pt-BR", the result will be "Olá mundo", if the language is set to "es", the result will be "Hola mundo" and so on. It's simple and easy to read and maintain.

## Install

This is a unpublished package, so you need to add it to your `pubspec.yaml` file.

```yml
dependencies:
  localize:
    git:
      url: https://github.com/carllosnc/localize.git
```

To more information about unplublished packages, see: https://dart.dev/tools/pub/package-layout#unpublished-packages

## 1 - Initialize

The first step is calling the `init` method from the `localizeState` object. This method requires a `Map` with the languages and the translations.

```dart
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';

void main() async {
  localizeState.init(
    content: {
      "en": {
        "Hello world": "Hello world",
        "It's a test": "It's a test",
        "Click me!": "Click me!",
      },
      "es": {
        "Hello world": "Hola mundo",
        "It's a test": "Es una prueba",
        "Click me!": "¡Haz clic aquí!",
      },
      "pt-BR": {
        "Hello world": "Olá mundo",
        "It's a test": "É uma teste",
        "Click me!": "Clique aqui!",
      },
    },
  );

  runApp(const MainApp());
}
```

## 2 - Set languages

Now we will create a `DropdownButton` to translate our app. The `localizeState` object has a `languages` property that contains all the available languages, we can use it to create the `DropdownButton`, `currentLanguage` is the current language that is being used and `setLanguage` is a method that changes the current language.

```dart
DropdownButtonHideUnderline(
  child: DropdownButton(
    value: localizeState.currentLanguage,
    items: localizeState.languages.map((String value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue) {
      if (newValue != null) {
        localizeState.setLanguage(newValue);
      }
    },
  ),
),
```

## 3 - Using translations

To see the translations in action we need to use the `LocalizeMixin` on our `StatefulWidget`. This mixin will automatically translate the text in the `build` method.

To use the `localize` method just call `.localize` on any `String` and it will return the translated text.

```dart
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello world'.localize),
        ),
      ),
    );
  }
}
```

## Details

**LocalizeState**

**`localizeState`**: is the core of the package, it's a singleton that will be used to manage the translations.

**`localizeState.init(content: Map<String, Map<String, String>>)`**: is the method that will be called to initialize the translations.

**`localizeState.setLanguage(String language)`**: is the method that will be called to change the current language.

**`localizeState.languages`**: is a list of all the available languages.

**`localizeState.currentLanguage`**: is the current language that is being used.

**LocalizeMixin**

**`LocalizeMixin`**: is a mixin that will be used to automatically translate the text in the `build` method.

**localize**

**`String.localize`**: is the method that will be called to translate the text.

---

Carlos Costa @ 2024
