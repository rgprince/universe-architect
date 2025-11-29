import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/preferences_service.dart';

/// AI Text Improvement Service
/// Uses Gemini API to improve, fix grammar, translate, etc.
class AiTextService {
  final _prefs = PreferencesService();
  GenerativeModel? _model;
  
  Future<void> _initModel() async {
    if (_model != null) return;
    
    final apiKey = await _prefs.getGeminiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API key not configured');
    }
    
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
  }
  
  /// Improve writing quality
  Future<String> improveText(String text) async {
    await _initModel();
    
    final prompt = '''Improve this text to be more engaging and vivid while keeping the same meaning and length. Return only the improved text without explanations:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? text;
  }
  
  /// Fix grammar and style
  Future<String> fixGrammar(String text) async {
    await _initModel();
    
    final prompt = '''Fix any grammar, punctuation, and style issues in this text. Return only the corrected text without explanations:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? text;
  }
  
  /// Translate to English
  Future<String> translateToEnglish(String text) async {
    await _initModel();
    
    final prompt = '''Translate this text to English. If it's already in English, return it as-is:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? text;
  }
  
  /// Make text shorter
  Future<String> makeShorter(String text) async {
    await _initModel();
    
    final prompt = '''Rewrite this text to be more concise (about 50% shorter) while keeping the key information:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? text;
  }
  
  /// Make text longer
  Future<String> makeLonger(String text) async {
    await _initModel();
    
    final prompt = '''Expand this text with more details and descriptions (about 50% longer) while maintaining the same style:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? text;
  }
  
  /// Continue writing
  Future<String> continueWriting(String text) async {
    await _initModel();
    
    final prompt = '''Continue this story naturally. Write 2-3 more paragraphs in the same style and tone:

$text''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? '';
  }
  
  /// Summarize chapter
  Future<String> summarizeChapter(String content) async {
    await _initModel();
    
    final prompt = '''Summarize this chapter in 2-3 sentences for planning purposes:

$content''';
    
    final response = await _model!.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? '';
  }
}
