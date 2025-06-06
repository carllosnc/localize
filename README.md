# Localize

![Static Badge](https://img.shields.io/badge/Flutter-blue)
[![Localize](https://github.com/carllosnc/localize/actions/workflows/dart.yml/badge.svg)](https://github.com/carllosnc/localize/actions/workflows/dart.yml)

> Localize is a package that allows you to easily translate your Flutter app.

The main motivation for this package is to create a simple and easy way to translate legacy Flutter apps. So, which would be the better solution to apply translations to hundreds of hardcoded strings? Fortunately, Dart provides a fantastic feature for this problem: [Extension methods in Dart](https://dart.dev/guides/language/extension-methods) is a simple way to add methods to an existing class without modifying the class itself.

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
        "It's a test": "É um teste",
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

### LocalizeState

The core singleton class that manages translations.

#### Methods

- **init(content)**
  - Description: Initializes the translations
  - Parameter: `content` (`Map<String, Map<String, String>>`) - Languages and translations map

- **setLanguage(language)**
  - Description: Changes the current language
  - Parameter: `language` (`String`) - The new language to set

#### Properties

- **languages**
  - Type: `List<String>`
  - Description: Available languages list

- **currentLanguage**
  - Type: `String`
  - Description: Currently active language

### LocalizeMixin

A mixin for automatic text translation in `build` method.

### Extension Methods

- **localize**
  - Type: `String` extension
  - Description: Translates a string to the current language

Carlos Costa @ 2024
