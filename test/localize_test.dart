import 'package:flutter_test/flutter_test.dart';
import 'package:localize/localize.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  setUp(() {
    localizeState.init(
      content: {
        "en": {
          "Hello world": "Hello world",
          "It's a test": "It's a test",
        },
        "es": {
          "Hello world": "Hola mundo",
          "It's a test": "Es una prueba",
        },
        "pt-BR": {
          "Hello world": "Olá mundo",
          "It's a test": "É uma teste",
        },
      },
    );
  });

  test('Check the the initialization', () {
    expect("Hello world".localize, "Hello world");
    expect("It's a test".localize, "It's a test");
  });

  test('Set language', () {
    localizeState.setLanguage("es");
    expect("Hello world".localize, "Hola mundo");
    expect("It's a test".localize, "Es una prueba");

    localizeState.setLanguage("pt-BR");
    expect("Hello world".localize, "Olá mundo");
    expect("It's a test".localize, "É uma teste");

    localizeState.setLanguage("en");
    expect("Hello world".localize, "Hello world");
    expect("It's a test".localize, "It's a test");
  });

  test('Check all the languages', () {
    expect(localizeState.languages, ["en", "es", "pt-BR"]);
  });
}
