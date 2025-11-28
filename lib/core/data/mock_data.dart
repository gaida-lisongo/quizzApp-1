import 'package:quizz_game/data/models/user_model.dart';
import 'package:quizz_game/data/models/category_model.dart';
import 'package:quizz_game/data/models/question_model.dart';
import 'package:quizz_game/data/models/score_model.dart';

/// Données de test/démo pour développer sans backend
class MockData {
  // ======== USER DATA ========
  static UserModel getDemoUser() {
    return UserModel(
      id: 'demo_user_001',
      pseudo: 'DemoPlayer',
      secure: 'demo_password',
      email: 'demo@quizgame.local',
      solde: 1000.0,
      pieces: 500,
      bonus: 100,
      recharges: [],
      scores: [
        ScoreModel(
          id: 'score_1',
          questionId: 'q1',
          categorie: 'Géographie',
          note: 85,
          date: DateTime.now().subtract(const Duration(days: 2)),
          status: 'completed',
        ),
        ScoreModel(
          id: 'score_2',
          questionId: 'q2',
          categorie: 'Histoire',
          note: 92,
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: 'completed',
        ),
      ],
    );
  }

  // ======== CATEGORIES ========
  static List<CategoryModel> getDemoCategories() {
    return [
      CategoryModel(
        id: 'cat_1',
        designation: 'Géographie',
        description: 'Questions sur les pays, villes et capitales',
        logo: '🌍',
      ),
      CategoryModel(
        id: 'cat_2',
        designation: 'Histoire',
        description: 'Questions historiques du monde entier',
        logo: '📚',
      ),
      CategoryModel(
        id: 'cat_3',
        designation: 'Science',
        description: 'Biologie, physique, chimie',
        logo: '🔬',
      ),
      CategoryModel(
        id: 'cat_4',
        designation: 'Culture',
        description: 'Cinéma, musique, littérature',
        logo: '🎭',
      ),
    ];
  }

  // ======== QUIZ QUESTIONS ========
  static List<QuestionModel> getDemoQuestions(String categoryId) {
    final questionsMap = {
      'cat_1': [
        QuestionModel(
          id: 'geo_1',
          enonce: 'Quelle est la capitale de la France?',
          categorieId: 'cat_1',
          choix: ['Paris', 'Lyon', 'Marseille', 'Toulouse'],
          correctAnswer: 'Paris',
        ),
        QuestionModel(
          id: 'geo_2',
          enonce: 'Quel est le plus grand océan?',
          categorieId: 'cat_1',
          choix: ['Atlantique', 'Pacifique', 'Indien', 'Arctique'],
          correctAnswer: 'Pacifique',
        ),
        QuestionModel(
          id: 'geo_3',
          enonce: 'Combien de continents existe-t-il?',
          categorieId: 'cat_1',
          choix: ['5', '6', '7', '8'],
          correctAnswer: '7',
        ),
      ],
      'cat_2': [
        QuestionModel(
          id: 'hist_1',
          enonce: 'En quelle année la Révolution française a-t-elle commencé?',
          categorieId: 'cat_2',
          choix: ['1789', '1792', '1799', '1804'],
          correctAnswer: '1789',
        ),
        QuestionModel(
          id: 'hist_2',
          enonce: 'Qui a découvert l\'Amérique en 1492?',
          categorieId: 'cat_2',
          choix: ['Christophe Colomb', 'Vasco de Gama', 'Ferdinand Magellan', 'John Cabot'],
          correctAnswer: 'Christophe Colomb',
        ),
        QuestionModel(
          id: 'hist_3',
          enonce: 'En quelle année l\'Empire romain s\'est-il effondré?',
          categorieId: 'cat_2',
          choix: ['476', '1453', '1066', '1492'],
          correctAnswer: '476',
        ),
      ],
      'cat_3': [
        QuestionModel(
          id: 'sci_1',
          enonce: 'Quel élément chimique a pour symbole "O"?',
          categorieId: 'cat_3',
          choix: ['Or', 'Oxygène', 'Osmium', 'Nobélium'],
          correctAnswer: 'Oxygène',
        ),
        QuestionModel(
          id: 'sci_2',
          enonce: 'Quelle est la vitesse de la lumière?',
          categorieId: 'cat_3',
          choix: ['300 000 km/s', '150 000 km/s', '500 000 km/s', '100 000 km/s'],
          correctAnswer: '300 000 km/s',
        ),
      ],
      'cat_4': [
        QuestionModel(
          id: 'cult_1',
          enonce: 'Quel réalisateur a fait "Inception"?',
          categorieId: 'cat_4',
          choix: ['Christopher Nolan', 'Steven Spielberg', 'James Cameron', 'Denis Villeneuve'],
          correctAnswer: 'Christopher Nolan',
        ),
        QuestionModel(
          id: 'cult_2',
          enonce: 'Quel artiste a peint "La Nuit étoilée"?',
          categorieId: 'cat_4',
          choix: ['Vincent van Gogh', 'Pablo Picasso', 'Salvador Dalí', 'Frida Kahlo'],
          correctAnswer: 'Vincent van Gogh',
        ),
      ],
    };

    return questionsMap[categoryId] ?? [];
  }
}
