import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/data/models/user_model.dart';
import 'package:quizz_game/data/models/score_model.dart';
import 'package:quizz_game/data/models/recharge_model.dart';
import 'package:quizz_game/data/services/user_service.dart';
import 'package:quizz_game/core/data/mock_data.dart';

// Le Provider global qui expose le store UserModel? (null si non authentifié)
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserNotifier(userService);
});

class UserNotifier extends StateNotifier<UserModel?> {
  final UserService _userService;

  // L'état initial est null (non authentifié)
  UserNotifier(this._userService) : super(null);

  // ------------------------- A. Authentification -------------------------

  /// Tente de se connecter, sauvegarde le token et met à jour l'état.
  /// En mode démo, utilise directement les fake data.
  Future<void> login(String email, String password) async {
    try {
      // 🎮 Mode démo : skip l'API et utiliser directement les fake data
      if (email == 'demo' && password == 'demo') {
        state = MockData.getDemoUser();
        return;
      }

      // Sinon, appel du service (qui retournera aussi les fake data si l'API ne répond pas)
      final user = await _userService.login(email, password);
      state = user; // 🔑 Met à jour l'état avec l'utilisateur authentifié
    } catch (e) {
      // Gérer l'erreur (l'UI doit l'afficher)
      rethrow; 
    }
  }

  /// Vérifie le token au démarrage (Auto-Login).
  Future<void> attemptAutoLogin() async {
    final token = await _userService.readToken();
    if (token == null) return;
    
    try {
      final user = await _userService.fetchMe();
      state = user; // 🔑 Hydrate l'état
    } catch (e) {
      // Token invalide ou expiré, on se déconnecte localement
      await logout(); 
    }
  }

  /// Déconnecte l'utilisateur et supprime le token sécurisé.
  Future<void> logout() async {
    await _userService.deleteToken(); 
    state = null; // Réinitialise l'état
  }

  // ------------------------- B. Mises à Jour de l'État Local -------------------------

  /// Ajoute un nouveau score à la liste de l'utilisateur (utilisé par GameNotifier).
  void addScore(ScoreModel newScore) {
    if (state == null) return;
    
    // Crée une nouvelle liste pour garantir l'immutabilité
    final updatedScores = [...state!.scores, newScore];
    
    // Crée une nouvelle instance de UserModel avec la méthode copyWith
    state = state!.copyWith(scores: updatedScores);
  }

  /// Ajoute une nouvelle recharge.
  void addRecharge(RechargeModel newRecharge) {
     if (state == null) return;
     final updatedRecharges = [...state!.recharges, newRecharge];
     state = state!.copyWith(recharges: updatedRecharges);
  }
}