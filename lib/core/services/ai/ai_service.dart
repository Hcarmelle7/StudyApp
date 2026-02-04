import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";

  // Le modèle qu'on utilise (Flash est rapide et gratuit)
  late final GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', 
      apiKey: _apiKey,
    );
  }

  /// Fonction pour générer un résumé de cours
  Future<String> generateSummary(String courseContent) async {
    try {
      final prompt = "Résume ce cours de manière structurée pour un étudiant :\n\n$courseContent";
      final content = [Content.text(prompt)];
      
      final response = await _model.generateContent(content);
      
      return response.text ?? "Désolé, l'IA n'a pas pu générer de résumé.";
    } catch (e) {
      return "Erreur lors de la connexion à l'IA : $e";
    }
  }
}