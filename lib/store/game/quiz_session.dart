import 'package:quizz_game/data/models/question_model.dart';

class QuizSession {
  final List<QuestionModel> questions; // Les questions du quiz
  final int currentQuestionIndex;
  final int currentScore;
  final int correctAnswers;
  final int timeSpentSeconds;
  final bool isFinished;

  QuizSession({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.currentScore = 0,
    this.correctAnswers = 0,
    this.timeSpentSeconds = 0,
    this.isFinished = false,
  });

  // Méthode pour créer une copie modifiée (immutabilité)
  QuizSession copyWith({
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    int? currentScore,
    int? correctAnswers,
    int? timeSpentSeconds,
    bool? isFinished,
  }) {
    return QuizSession(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentScore: currentScore ?? this.currentScore,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  // Helper pour obtenir la question actuelle
  QuestionModel get currentQuestion => questions[currentQuestionIndex];
}