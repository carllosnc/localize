# Localize

![Static Badge](https://img.shields.io/badge/Flutter-blue)
[![Localize](https://github.com/carllosnc/localize/actions/workflows/dart.yml/badge.svg)](https://github.com/carllosnc/localize/actions/workflows/dart.yml)

> **Localize** makes translating your Flutter app simple and intuitive.

Translating an existing app with hundreds of hardcoded strings can be a daunting task. **Localize** solves this using [Dart Extension Methods](https://dart.dev/guides/language/extension-methods), allowing you to add translation capabilities to your strings without modifying the underlying class structure.

**Quick Example:**

```dart
Text('Hello world'.localize);
// Result based on active language:
// pt-BR: "Olá mundo"
// es:    "Hola mundo"
// en:    "Hello world"
```

It is clean, readable, and easy to maintain.

## Installation

Since this package is not yet published on pub.dev, add it to your `pubspec.yaml` using the git repository:

```yaml
dependencies:
  localize:
    git:
      url: https://github.com/carllosnc/localize.git
```

For more details on git dependencies, see the [Dart documentation](https://dart.dev/tools/pub/package-layout#unpublished-packages).

## 1. Initialize

Start by initializing the `localizeState` singleton with your supported languages and translations. This is typically done in your `main()` function.

```dart
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';

void main() async {
  // Ensure widgets are initialized if you are doing async work before runApp
  WidgetsFlutterBinding.ensureInitialized();

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

## 2. Switch Languages

You can easily switch languages using `localizeState.setLanguage`. The package automatically handles persistence using `SharedPreferences`, so the user's choice is remembered across restarts.

Here is an example using a `DropdownButton`:

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
        // This updates the language and rebuilds listeners
        localizeState.setLanguage(newValue);
      }
    },
  ),
),
```

## 3. Apply Translations

To make your UI reactive to language changes, add the `LocalizeMixin` to your `StatefulWidget`'s State. Then, simply append `.localize` to any string you want to translate.

```dart
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// Add the mixin here
class _MainAppState extends State<MainApp> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // The text will update automatically when language changes
          child: Text('Hello world'.localize),
        ),
      ),
    );
  }
}
```

## API Details

### LocalizeState

The singleton that manages the application's translation state.

#### Methods

- **`init({required Map<String, Map<String, String>> content})`**
  Initializes the translation data. It checks `SharedPreferences` for a previously saved language preference.

- **`setLanguage(String language)`**
  Sets the active language, updates `currentLanguage`, saves the preference, and notifies listeners.

#### Properties

- **`languages`** (`List<String>`): A list of available language codes (keys from the content map).
- **`currentLanguage`** (`String`): The currently active language code.

### LocalizeMixin

A generic mixin for `StatefulWidget`. It subscribes to `localizeState` changes and triggers a `setState` call whenever the language is updated, ensuring the UI reflects the new translations immediately.

### Extension: `String.localize`

The magic behind the syntax. It looks up the string in the active language map. If a translation is found, it is returned; otherwise, the original string is used.

---
Carlos Costa @ 2024
