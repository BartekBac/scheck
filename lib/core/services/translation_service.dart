import 'package:translator/translator.dart';


class TranslationService {
  static final _translator = GoogleTranslator();
  static final _delayDuration = const Duration(milliseconds: 300);

  /// Translates multiple texts to the specified language and then joins them
  /// with a separator.
  ///
  /// The [texts] parameter is a list of texts to be translated.
  ///
  /// The [to] parameter is the language code to translate the texts to.
  ///
  /// The [separator] parameter is the string used to separate the translated
  /// texts after they are joined. The default value is ','.
  ///
  /// The [from] parameter is the language code to translate the texts from. The
  /// default value is 'en'.
  ///
  /// Returns a [Future] that completes with the joined translated texts.
  static Future<List<String>> translateJoined(List<String> texts, {required String to, String separator = ',', String from = 'en'}) async {
    return (await translate(texts.join(separator), to: to, from: from)).split(separator);
  }

  /// Translates a single text to the specified language.
  ///
  /// The [text] parameter is the text to be translated.
  ///
  /// The [to] parameter is the language code to translate the text to.
  ///
  /// The [from] parameter is the language code to translate the text from. The
  /// default value is 'en'.
  ///
  /// Returns a [Future] that completes with the translated text.
  static Future<String> translate(String text, {required String to, String from = 'en'}) async {
    if (to == from) return text;
    await Future<void>.delayed(_delayDuration); // to prevent proxy block
    //TODO: add here caching
    // approach 1: add translateIngredient method which will lookup saved ingredients with translation as columns
    // approach 2: add here bool cache argument, and save/lookup from one general translations table (then it may be joined with ingredients table)
    return (await _translator.translate(text, from: from, to: to)).text;
  }
}