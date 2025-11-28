import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/data/models/user_model.dart';
import 'package:quizz_game/data/services/user_service.dart'; // Importe votre UserService

// 1. Définition du Provider pour le Notifier (il injecte le service)
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  // Injection du UserService défini par l'utilisateur
  final userService = ref.watch(userServiceProvider); 
  return UserNotifier(userService);
});

// 2. La classe Notifier
class UserNotifier extends StateNotifier<UserModel?> {
  final UserService _userService;

  // Initialise avec un état null (non connecté)
  UserNotifier(this._userService) : super(null); 

  /// Tente de se connecter et d'hydrater le state.
  Future<void> login(String pseudo, String password) async {
    try {
      // Utilise la méthode login du service (avec fallback)
      final user = await _userService.login(pseudo, password);
      // Met à jour l'état de Riverpod
      state = user; 
      
      // La redirection vers /home doit être gérée par la page appelante (LoginPage)
      
    } catch (e) {
      // En cas d'échec de connexion (par exemple, 401 si l'API est UP)
      // Laisse l'état à null et propage l'erreur à la UI pour affichage
      state = null;
      rethrow;
    }
  }
  
  /// Tente de se reconnecter en utilisant un token persistant.
  Future<void> attemptAutoLogin() async {
    final token = await _userService.readToken();
    if (token == null) {
      state = null;
      return;
    }

    try {
      // Utilise fetchMe du service (avec fallback)
      final user = await _userService.fetchMe();
      state = user;
    } catch (e) {
      // Si fetchMe échoue (token invalide, 401), on déconnecte
      await _userService.deleteToken();
      state = null;
    }
  }

  /// Déconnecte l'utilisateur
  Future<void> logout() async {
    await _userService.deleteToken();
    state = null;
  }
  
  /// Met à jour l'état de l'utilisateur après une transaction (ex: achat de pièces)
  void updateUserInfo(UserModel updatedUser) {
    state = updatedUser;
  }
}