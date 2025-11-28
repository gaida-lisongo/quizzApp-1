import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/data/models/score_model.dart';
import 'package:quizz_game/data/services/game_service.dart';
import 'package:quizz_game/store/game/quiz_session.dart';
import 'package:quizz_game/store/user/user_notifier.dart';

// Provider du Notifier de jeu. L'état initial est null (pas de partie en cours)
final quizGameProvider = StateNotifierProvider<QuizGameNotifier, QuizSession?>((ref) {
  final gameService = ref.watch(gameServiceProvider);
  final userNotifier = ref.watch(userProvider.notifier);
  return QuizGameNotifier(gameService, userNotifier);
});

class QuizGameNotifier extends StateNotifier<QuizSession?> {
  final GameService _gameService;
  final UserNotifier _userNotifier;
  
  QuizGameNotifier(this._gameService, this._userNotifier) : super(null);

  // ------------------------- A. Démarrer/Réinitialiser -------------------------

  /// Récupère les questions de l'API et initialise une nouvelle session.
  Future<void> startNewGame(String categoryId) async {
    final questions = await _gameService.fetchQuizQuestions(categoryId);
    
    if (questions.isEmpty) {
      throw Exception("Aucune question trouvée pour cette catégorie.");
    }
    
    // Initialiser l'état local de la partie
    state = QuizSession(questions: questions);
  }

  /// Réinitialise l'état de la session de jeu
  void resetGame() {
    state = null;
  }

  // ------------------------- B. Progression du jeu -------------------------

  /// Gère la soumission d'une réponse par l'utilisateur.
  Future<void> submitAnswer(String selectedAnswer) async {
    if (state == null || state!.isFinished) return;
    
    final currentQuestion = state!.currentQuestion;
    
    // 1. Logique de score simplifiée (à adapter à votre logique backend)
    int pointsGagnes = (selectedAnswer == currentQuestion.correctAnswer) ? 10 : 0;
    int newScore = state!.currentScore + pointsGagnes;

    final nextIndex = state!.currentQuestionIndex + 1;
    
    if (nextIndex < state!.questions.length) {
      // Passer à la question suivante
      state = state!.copyWith(
        currentQuestionIndex: nextIndex,
        currentScore: newScore,
      );
    } else {
      // Fin de la partie
      state = state!.copyWith(
        currentScore: newScore,
        isFinished: true,
      );
      
      // 2. Soumettre le résultat final à l'API et mettre à jour le User Store
      await _submitFinalScore(newScore);
    }
  }

  // ------------------------- C. Soumission finale -------------------------

  Future<void> _submitFinalScore(int finalScore) async {
    // Appeler le GameService pour soumettre le score
    final ScoreModel receivedScore = await _gameService.submitQuizResult(
      categoryId: state!.questions.first.categorieId,
      correctAnswers: state!.correctAnswers,
      totalQuestions: state!.questions.length,
      timeSpentSeconds: state!.timeSpentSeconds,
    );

    // Mettre à jour le UserNotifier avec le nouveau ScoreModel
    _userNotifier.addScore(receivedScore);
  }
}