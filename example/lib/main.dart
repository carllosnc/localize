import 'package:flutter/material.dart';
import 'package:localize/localize.dart';

void main() async {
  localizeState.init(
    content: {
      "en": {
        "Hello world": "Hello world",
        "It's a test": "It's a test",
        "Click me!": "Click me!",
        "Localize Example": "Localize Example",
        "Error message": "Error message",
        "app title": "Localize Example",
      },
      "es": {
        "Hello world": "Hola mundo",
        "It's a test": "Es una prueba",
        "Click me!": "¡Haz clic aquí!",
        "Localize Example": "Ejemplo de Localización",
        "Error message": "Mensaje de error",
        "app title": "Ejemplo de Localización",
      },
      "pt-BR": {
        "Hello world": "Olá mundo",
        "It's a test": "É uma teste",
        "Click me!": "Clique aqui!",
        "Localize Example": "Exemplo de Localização",
        "Error message": "Mensagem de erro",
        "app title": "Exemplo de Localização",
      },
    },
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('app title'.localize),
          actions: [
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
          ],
        ),
        body: Center(
          child: Text('Hello world'.localize),
        ),
      ),
    );
  }
}
