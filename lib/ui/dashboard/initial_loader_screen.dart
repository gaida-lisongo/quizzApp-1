import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/ui/common/loading_indicator.dart';
import 'package:quizz_game/store/user/user_notifier.dart';
import 'package:quizz_game/data/models/user_model.dart';

class InitialLoaderScreen extends ConsumerStatefulWidget {
  const InitialLoaderScreen({super.key});

  @override
  ConsumerState<InitialLoaderScreen> createState() => _InitialLoaderScreenState();
}

class _InitialLoaderScreenState extends ConsumerState<InitialLoaderScreen> {
  
  @override
  void initState() {
    super.initState();
    // Déclenche la vérification d'authentification après le rendu initial du widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  void _checkAuthStatus() {
    // 1. Déclenche l'action de vérification du JWT
    final userNotifier = ref.read(userProvider.notifier);
    userNotifier.attemptAutoLogin().catchError((e) {
      // Gérer l'erreur de façon silencieuse, la redirection suivra.
    });
    
    // 2. Écoute l'état pour la navigation
    // Ceci s'exécutera une seule fois après la mise à jour de l'état par attemptAutoLogin
    ref.listen<UserModel?>(userProvider, (previousUser, newUser) {
      if (newUser != null) {
        // Redirection vers la page d'accueil (authentifié)
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Redirection vers la page de connexion (non authentifié)
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Affiche le loader pendant la vérification du token JWT
    return const Scaffold(
      backgroundColor: Colors.black, 
      body: Center(child: LoadingIndicator()),
    );
  }
}