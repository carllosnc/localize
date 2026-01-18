# AI Agent Instructions for `localize` Library

This document provides specific instructions on how to implement and use the `localize` library in Flutter projects. Follow these patterns to ensure correct integration, reactivity, and persistence.

## 1. Library Overview

`localize` is a lightweight translation package that leverages **Dart Extension Methods** to translate strings without modifying class structures. It relies on a singleton state manager and a mixin for UI updates.

**Key Components:**
- `localizeState` (Singleton): Manages current language, translation data, and persistence.
- `LocalizeMixin`: A mixin for `State<StatefulWidget>` that triggers a rebuild when the language changes.
- `String.localize`: An extension method that returns the translated string based on the current language.

## 2. Implementation Steps

### Step 1: Initialization

You MUST initialize the library in the `main()` function before running the app.
**Rule:** Always ensure `WidgetsFlutterBinding.ensureInitialized()` is called if it isn't already.

```dart
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  localizeState.init(
    content: {
      "en": {
        "Hello": "Hello",
        "Welcome": "Welcome",
      },
      "es": {
        "Hello": "Hola",
        "Welcome": "Bienvenido",
      },
      // Add other languages here
    },
  );

  runApp(const MyApp());
}
```

### Step 2: Making UI Reactive

To ensure the UI updates immediately when the language changes, you MUST add `LocalizeMixin` to the `State` class of any `StatefulWidget` that contains translatable text.

**Pattern:**
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 1. Add 'with LocalizeMixin'
class _MyWidgetState extends State<MyWidget> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. Use .localize on strings
      body: Text("Hello".localize), 
    );
  }
}
```

### Step 3: Translating Strings

Use the `.localize` extension on any string literal or variable.

- **Syntax:** `"Original Text".localize`
- **Behavior:**
    - It looks up the string in the map provided to `init` for the `currentLanguage`.
    - If found, returns the translation.
    - If NOT found, returns the original string.

### Step 4: Switching Languages

Use `localizeState.setLanguage(String languageCode)` to change the language.
- This method automatically saves the selection to `SharedPreferences` (persistence).
- It notifies all widgets using `LocalizeMixin` to rebuild.

```dart
// Example: Switching to Spanish
localizeState.setLanguage("es");
```

### Step 5: Accessing Available Languages

Useful for building language selection UIs (e.g., Dropdowns).

```dart
List<String> languages = localizeState.languages; // e.g. ['en', 'es']
String current = localizeState.currentLanguage;
```

## 3. Best Practices for Agents

1.  **Hardcoded Strings**: When asked to internationalize an app, identify hardcoded display strings and append `.localize`.
2.  **Dictionary Updates**: When adding new strings to the code, ALWAYS remember to update the `content` map in the `main()` function with the new keys and their translations for all supported languages.
3.  **Mixin Verification**: If a user reports that translations aren't updating instantly, check if the `LocalizeMixin` is missing from the parent `State` class.
4.  **Keys**: The simplest pattern is to use the English text as the key.
    - Key: `"Hello world"`
    - Usage: `"Hello world".localize`

## 4. Common Dependencies

Ensure the package is in `pubspec.yaml`:
```yaml
dependencies:
  localize:
    git:
      url: https://github.com/carllosnc/localize.git
```
