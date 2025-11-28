import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/question_model.dart';
import '../models/score_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:quizz_game/core/config/api.dart';
import 'package:quizz_game/core/data/mock_data.dart';

// Définition du Provider pour l'injection de dépendance (Riverpod)
final gameServiceProvider = Provider((ref) => GameService());

class GameService {
  // Endpoint pour les questions/quiz
  final String _baseUrl = Api.baseUrl.endsWith('/') ? '${Api.baseUrl}game' : '${Api.baseUrl}/game';
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';
  static const _timeout = Duration(seconds: 10);

  // Données de test pour le fallback
  List<QuestionModel> _getTestQuestions(String categoryId) {
    return MockData.getDemoQuestions(categoryId);
  }

  // ====================================================================
  // Gestion du Token
  // ====================================================================

  Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await readToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ====================================================================
  // Quiz et Questions
  // ====================================================================

  /// Récupère les questions d'une catégorie.
  /// 🔄 Si l'endpoint ne répond pas, utilise des données de test.
  Future<List<QuestionModel>> fetchQuizQuestions(String categoryId) async {
    final url = Uri.parse('$_baseUrl/categories/$categoryId/questions');
    final headers = await _getAuthHeaders();

    try {
      final response = await http.get(url, headers: headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> questions = data['questions'] as List<dynamic>? ?? [];
        return questions
            .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Erreur fetch questions: ${response.statusCode}');
      }
    } catch (e) {
      // 🔴 FALLBACK: Endpoint indisponible, utiliser des données de test
      print('⚠️ API fetchQuizQuestions indisponible → Utilisation des données de test: $e');
      return _getTestQuestions(categoryId);
    }
  }

  /// Soumet les résultats d'un quiz et reçoit le score.
  /// 🔄 Si l'endpoint ne répond pas, génère un score de test.
  Future<ScoreModel> submitQuizResult({
    required String categoryId,
    required int correctAnswers,
    required int totalQuestions,
    required int timeSpentSeconds,
  }) async {
    final url = Uri.parse('$_baseUrl/submit-score');
    final headers = await _getAuthHeaders();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'categoryId': categoryId,
          'correctAnswers': correctAnswers,
          'totalQuestions': totalQuestions,
          'timeSpent': timeSpentSeconds,
        }),
      ).timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return ScoreModel.fromJson(data['score'] as Map<String, dynamic>? ?? {
          '_id': 'score_${DateTime.now().millisecondsSinceEpoch}',
          'questionId': categoryId,
          'categorie': categoryId,
          'note': (correctAnswers / totalQuestions * 100).toInt(),
          'date': DateTime.now().toIso8601String(),
          'status': 'completed',
        });
      } else {
        throw Exception('Erreur submit score: ${response.statusCode}');
      }
    } catch (e) {
      // 🔴 FALLBACK: Endpoint indisponible, générer un score de test
      print('⚠️ API submitQuizResult indisponible → Utilisation des données de test: $e');
      final score = (correctAnswers / totalQuestions * 100).toInt();
      return ScoreModel(
        id: 'test_score_${DateTime.now().millisecondsSinceEpoch}',
        questionId: categoryId,
        categorie: categoryId,
        note: score,
        date: DateTime.now(),
        status: 'test_completed',
      );
    }
  }
}
